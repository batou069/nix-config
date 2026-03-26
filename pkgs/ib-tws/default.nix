# Interactive Brokers Trader Workstation (TWS)
#
# Based on the AUR ib-tws package (https://aur.archlinux.org/packages/ib-tws).
# Uses the offline standalone installer and extracts the bundled JRE + JARs.
#
# The download URL points to "latest-standalone" which is a moving target.
# When IB releases a new version, update `version` and `sha256` together.
# To get the new hash: nix-prefetch-url <url>
# Then convert: nix hash convert --hash-algo sha256 --to sri <hash>
{ lib
, stdenv
, fetchurl
, buildFHSEnv
, writeShellScript
, # Runtime dependencies: Java Swing/AWT UI
  alsa-lib
, at-spi2-core
, cairo
, fontconfig
, freetype
, gdk-pixbuf
, glib
, gtk3
, libGL
, libX11
, libXext
, libXi
, libXrender
, libXtst
, libXxf86vm
, pango
, # Runtime dependencies: JxBrowser embedded Chromium
  cups
, dbus
, expat
, libdrm
, libxcb
, libXcomposite
, libXcursor
, libXdamage
, libXfixes
, libXrandr
, libXScrnSaver
, libxkbcommon
, libxshmfence
, mesa
, nspr
, nss
, systemd
, # Build-time: installer needs zlib inside FHS
  zlib
,
}:
let
  pname = "ib-tws";
  version = "10.44.1g";

  src = fetchurl {
    url = "https://download2.interactivebrokers.com/installers/tws/latest-standalone/tws-latest-standalone-linux-x64.sh";
    hash = "sha256-6iv4d9HPIj93DhNpdcYxFBiTWOUkfD2x9cUN8g+3zPI=";
    executable = true;
  };

  # FHS environment used ONLY at build time to run the install4j-based
  # installer. The installer's embedded native binaries expect glibc at
  # /lib64/ld-linux-x86-64.so.2 — which doesn't exist on NixOS.
  installerFhs = buildFHSEnv {
    name = "${pname}-installer";
    targetPkgs = p: [ p.zlib ];
    runScript = "bash";
  };

  # Stage 1: Run the offline installer and extract the bundled JRE + JARs.
  # TWS bundles a Java 21 JRE that Interactive Brokers tests against.
  # We use it as-is rather than substituting a system JDK.
  tws-unwrapped = stdenv.mkDerivation {
    pname = "${pname}-unwrapped";
    inherit version src;

    preferLocalBuild = true;
    dontUnpack = true;
    # Don't let Nix shrink RPATHs or strip the bundled JRE binaries.
    # The JRE uses $ORIGIN-relative paths to find its own libraries,
    # and it will run inside an FHS environment at runtime.
    dontPatchELF = true;
    dontStrip = true;

    installPhase = ''
      runHook preInstall

      # The installer creates desktop entries and logs in $HOME
      export HOME="$(mktemp -d)"
      local target="$TMPDIR/tws-install"
      mkdir -p "$target"

      echo "==> Running TWS standalone installer (this takes a minute)..."
      ${installerFhs}/bin/${pname}-installer -c '"$@"' _ "${src}" -q -dir "$target"

      # --- Locate the bundled JRE ---
      # The install4j framework logs which files it installs, including java.
      local log="$target/.install4j/installation.log"
      local jre_dir=""

      if [ -f "$log" ] && grep -q "Install file.*/java;" "$log"; then
        jre_dir=$(grep "Install file.*/java;" "$log" \
          | head -1 \
          | cut -d';' -f1 \
          | sed 's/.* Install file: //' \
          | sed 's|/bin/java||')
      fi

      # Fallback: search the installation tree for java binary
      if [ -z "$jre_dir" ] || [ ! -x "$jre_dir/bin/java" ]; then
        echo "==> JRE not found in install4j log, searching installation tree..."
        local java_bin
        java_bin=$(find "$target" -path '*/bin/java' -type f | head -1)
        if [ -n "$java_bin" ]; then
          jre_dir=$(cd "$(dirname "$java_bin")/.." && pwd)
        fi
      fi

      if [ ! -x "$jre_dir/bin/java" ]; then
        echo "ERROR: Could not locate bundled JRE"
        echo "Installation directory contents:"
        find "$target" -maxdepth 3 -type d
        exit 1
      fi

      echo "==> Found bundled JRE: $jre_dir"
      "$jre_dir/bin/java" -version 2>&1 || true

      # --- Install JRE and application JARs ---
      mkdir -p "$out/share/${pname}/jre" "$out/share/${pname}/jars"
      cp -a "$jre_dir"/. "$out/share/${pname}/jre/"
      cp "$target/jars"/*.jar "$out/share/${pname}/jars/"

      # Cleanup installer artifacts from $HOME
      rm -rf "$HOME"

      runHook postInstall
    '';

    meta = with lib; {
      description = "Interactive Brokers TWS (unwrapped files)";
      homepage = "https://www.interactivebrokers.com";
      license = licenses.unfree;
      platforms = [ "x86_64-linux" ];
    };
  };

  # The launcher script runs INSIDE the FHS namespace.
  # buildFHSEnv maps $profile/share/ → /usr/share/ so the paths below resolve.
  launcherScript = writeShellScript "${pname}-launcher" ''
    # --- Config ---
    IB_CONFIG_DIR="''${IB_CONFIG_DIR:-$HOME/.ib-tws}"
    mkdir -p "$IB_CONFIG_DIR"

    # Java GC and memory (4 GB heap, G1 collector)
    JAVA_GC="-Xmx4G -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:ParallelGCThreads=20 -XX:ConcGCThreads=5 -XX:InitiatingHeapOccupancyPercent=70"

    # UI rendering: anti-aliased fonts, Swing tweaks
    JAVA_UI="-Dswing.aatext=TRUE -Dawt.useSystemAAFontSettings=on -Dsun.awt.nopixfmt=true -Dsun.java2d.noddraw=true -Dswing.boldMetal=false -Dsun.locale.formatasdefault=true"

    # User overrides (create ~/.config/ib-tws.conf to customize)
    # Example: JAVA_GC="-Xmx8G ..." or JAVA_EXTRA_FLAGS="-Dfoo=bar"
    [ -f "$HOME/.config/ib-tws.conf" ] && . "$HOME/.config/ib-tws.conf"

    # Java Swing uses GTK for native look. On Wayland, GTK3 tries the
    # Wayland backend which crashes Swing with:
    #   gdk_x11_display_set_window_scale: assertion failed
    # Force X11 (via XWayland) to avoid this.
    export GDK_BACKEND=x11

    # Tiling/Wayland compositors (Hyprland, Sway, etc.) don't reparent
    # windows. Without this hint, Java AWT miscalculates window positions,
    # breaking drag/drop and causing visual glitches.
    export _JAVA_AWT_WM_NONREPARENTING=1

    cd /usr/share/${pname}/jars
    exec /usr/share/${pname}/jre/bin/java \
      -cp "*" \
      $JAVA_GC $JAVA_UI ''${JAVA_EXTRA_FLAGS:-} \
      --add-opens=java.base/java.util=ALL-UNNAMED \
      --add-opens=java.base/java.util.concurrent=ALL-UNNAMED \
      --add-exports=java.base/sun.util=ALL-UNNAMED \
      --add-exports=java.desktop/com.sun.java.swing.plaf.motif=ALL-UNNAMED \
      --add-opens=java.desktop/java.awt=ALL-UNNAMED \
      --add-opens=java.desktop/java.awt.dnd=ALL-UNNAMED \
      --add-opens=java.desktop/javax.swing=ALL-UNNAMED \
      --add-opens=java.desktop/javax.swing.event=ALL-UNNAMED \
      --add-opens=java.desktop/javax.swing.plaf.basic=ALL-UNNAMED \
      --add-opens=java.desktop/javax.swing.table=ALL-UNNAMED \
      --add-opens=java.desktop/sun.awt=ALL-UNNAMED \
      --add-exports=java.desktop/sun.awt.X11=ALL-UNNAMED \
      --add-exports=java.desktop/sun.swing=ALL-UNNAMED \
      --add-opens=javafx.graphics/com.sun.javafx.application=ALL-UNNAMED \
      --add-exports=javafx.media/com.sun.media.jfxmedia=ALL-UNNAMED \
      --add-exports=javafx.media/com.sun.media.jfxmedia.events=ALL-UNNAMED \
      --add-exports=javafx.media/com.sun.media.jfxmedia.locator=ALL-UNNAMED \
      --add-exports=javafx.media/com.sun.media.jfxmediaimpl=ALL-UNNAMED \
      --add-exports=javafx.web/com.sun.javafx.webkit=ALL-UNNAMED \
      --add-opens=javafx.web/com.sun.webkit=ALL-UNNAMED \
      --add-opens=javafx.swing/javafx.embed.swing=ALL-UNNAMED \
      --add-opens=javafx.graphics/com.sun.javafx.stage=ALL-UNNAMED \
      --add-exports=javafx.graphics/com.sun.javafx.stage=ALL-UNNAMED \
      --add-exports=javafx.controls/com.sun.javafx.scene.control=ALL-UNNAMED \
      --add-opens=jdk.management/com.sun.management.internal=ALL-UNNAMED \
      -DjtsConfigDir="$IB_CONFIG_DIR" \
      -Djxbrowser.chromium.switches=--no-sandbox,--disable-gpu-sandbox \
      jclient.LoginFrame "$IB_CONFIG_DIR" "$@"
  '';
  # Stage 2: Runtime FHS wrapper.
  # TWS + JxBrowser (embedded Chromium) both need standard Linux library paths.
in
buildFHSEnv {
  name = pname;

  targetPkgs = _p: [
    tws-unwrapped
    # JRE runtime dependency
    zlib
    # Java Swing / AWT UI
    alsa-lib
    at-spi2-core
    cairo
    fontconfig
    freetype
    gdk-pixbuf
    glib
    gtk3
    libGL
    libX11
    libXext
    libXi
    libXrender
    libXtst
    libXxf86vm
    pango
    # JxBrowser embedded Chromium
    cups
    dbus
    expat
    libdrm
    libxcb
    libXcomposite
    libXcursor
    libXdamage
    libXfixes
    libXrandr
    libXScrnSaver
    libxkbcommon
    libxshmfence
    mesa
    nspr
    nss
    systemd
  ];

  runScript = launcherScript;

  extraInstallCommands = ''
        mkdir -p "$out/share/applications"
        cat > "$out/share/applications/${pname}.desktop" <<DESKTOP
    [Desktop Entry]
    Type=Application
    Name=IB Trader Workstation
    Comment=Interactive Brokers Trading Platform
    Exec=$out/bin/${pname}
    Icon=ib-tws
    Categories=Office;Finance;
    StartupWMClass=jclient-LoginFrame
    DESKTOP
  '';

  meta = with lib; {
    description = "Trader Workstation (TWS) — Electronic trading platform from Interactive Brokers";
    homepage = "https://www.interactivebrokers.com";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
    mainProgram = pname;
  };
}
