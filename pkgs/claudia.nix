# /home/lf/nix/pkgs/claudia.nix
{
  pkgs,
  pkgs-unstable,
  claudia-src,
}: let
  bun_dependencies = pkgs.stdenv.mkDerivation {
    pname = "claudia-bun-deps";
    version = "unstable-from-source";

    src = claudia-src;

    # We only need bun here. `patchShebangs` is a command provided by stdenv,
    # not a separate package input.
    nativeBuildInputs = [
      pkgs-unstable.bun
    ];

    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    # This hash will be wrong. You need to get the new one after the fix.
    outputHash = "sha256-nxi2N7IKLe0vJV4pD/DBIcssTmSa8cUjq+R9ZFJqIrE=";

    installPhase = ''
      runHook preInstall
      bun install --frozen-lockfile
      # Copy the contents of node_modules into the output directory
      cp -r node_modules/. $out/
      runHook postInstall
    '';

    # After installing, fix the scripts.
    # The `patchShebangs` command is available here automatically.
    postInstall = ''
      patchShebangs $out
    '';
  };
in
  pkgs.stdenv.mkDerivation {
    pname = "claudia";
    version = "unstable-from-source";

    src = claudia-src;

    nativeBuildInputs = with pkgs; [
      rustc
      cargo
      pkgs-unstable.bun
      git
      pkg-config
      gcc
      gnumake
    ];

    buildInputs = with pkgs; [
      webkitgtk_4_1
      gtk3
      libayatana-appindicator
      librsvg
      patchelf
      openssl
      xdotool
      libsoup_3
    ];

    preBuild = ''
      ln -s ${bun_dependencies} node_modules
    '';

    buildPhase = ''
      runHook preBuild
      bun run tauri build
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      install -Dm755 src-tauri/target/release/claudia $out/bin/claudia
      runHook postInstall
    '';

    meta = with pkgs.lib; {
      description = "A GUI for Claude AI, built with Tauri and Rust.";
      homepage = "https://github.com/getAsterisk/claudia";
      license = licenses.mit;
      platforms = platforms.linux;
      maintainers = [];
    };
  }
