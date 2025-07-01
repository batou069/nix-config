{
  pkgs,
  inputs,
  ...
}: let
  r-with-packages = pkgs.rWrapper.override {
    packages = with pkgs.rPackages; [
      IRkernel
    ];
  };

  zen-browser = pkgs.stdenv.mkDerivation rec {
    pname = "zen-browser";
    version = "1.13.2b";

    src = pkgs.fetchurl {
      url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-x86_64.tar.xz";
      sha256 = "sha256-GOD/qZsdCIgldRsOR/Hxo+mB0K7iutKt9XYUj9+6Tgc=";
    };

    nativeBuildInputs = with pkgs; [autoPatchelfHook makeWrapper];
    buildInputs = with pkgs; [
      libGL
      nss
      nspr
      fontconfig
      openssl
      pipewire
      libpulseaudio
      alsa-lib
      gtk3
      cairo
      gdk-pixbuf
      glib
      dbus
      librsvg
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];

    sourceRoot = "zen";

    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin $out/share/applications $out/share/pixmaps
      cp -r . $out/
      makeWrapper $out/zen-bin $out/bin/zen \
        --set LD_LIBRARY_PATH ${pkgs.lib.makeLibraryPath buildInputs} \
        --set XDG_CURRENT_DESKTOP Hyprland \
        --set XDG_SESSION_TYPE wayland \
        --set MOZ_ENABLE_WAYLAND 1
      # Copy icon to a standard location
      cp $out/zen.png $out/share/pixmaps/zen-browser.png || echo "Warning: zen.png not found in source"
      # Install desktop file
      cp ${desktopItem}/share/applications/zen-browser.desktop $out/share/applications/zen-browser.desktop
      runHook postInstall
    '';

    desktopItem = pkgs.makeDesktopItem {
      name = "zen-browser";
      exec = "zen"; # Use executable name, resolved via PATH
      icon = "zen-browser"; # Use icon name, registered in pixmaps
      comment = "A customizable, user-friendly web browser based on Firefox";
      desktopName = "Zen Browser";
      categories = ["Network" "WebBrowser"];
    };
  };

  normcap-wrapped = pkgs.writeShellScriptBin "normcap" ''
    #!${pkgs.stdenv.shell}
    export QT_QPA_PLATFORM=wayland
    export QT_QPA_PLATFORMTHEME=qt6ct
    export XDG_CURRENT_DESKTOP=Hyprland
    # export QT_LOGGING_RULES=qt6ct.debug=true
    exec ${pkgs.normcap}/bin/normcap "$@"
  '';
in {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    (with pkgs; [
      # System Packages
      # home-manager
      bc
      isd # interactively interact with systemd
      erdtree # You can think of erdtree as a little bit of du, tree, find, wc and ls.
      baobab
      btrfs-progs
      clang
      curl
      cpufrequtils
      duf # Utility For Viewing Disk Usage In Terminal
      findutils
      ffmpeg
      glib #for gsettings to work
      gsettings-qt
      git
      killall
      libappindicator
      libnotify
      openssl #required by Rainbow borders
      pciutils
      wget
      xdg-user-dirs
      xdg-utils
      sof-firmware # added due to sound issues, missing microphone
      fastfetch
      (mpv.override {scripts = [mpvScripts.mpris];}) # with tray
      # ranger

      # Hyprland Stuff
      # Build AGS v1 from source
      inputs.ags.packages.${pkgs.system}.default
      btop
      brightnessctl # for brightness control
      cava
      cliphist
      loupe
      gnome-system-monitor
      grim
      gtk-engine-murrine #for gtk themes
      hypridle
      imagemagick
      inxi
      jq
      ijq
      manix
      mediainfo

      kitty
      libsForQt5.qtstyleplugin-kvantum #kvantum
      networkmanagerapplet
      nwg-displays
      nwg-look
      nvtopPackages.full
      pamixer
      pavucontrol
      playerctl
      polkit_gnome
      libsForQt5.qt5ct
      kdePackages.qt6ct
      kdePackages.qtwayland
      kdePackages.qtstyleplugin-kvantum #kvantum
      rofi-wayland
      slurp
      swappy
      swaynotificationcenter
      swww
      unzip
      wallust
      wl-clipboard
      wlogout
      xarchiver
      yad
      yt-dlp
      nix-search-tv
      gemini-cli
      claude-code
      # --- MY PACKAGES ---
      # Your requested packages
      lutris
      heroic
      bottles
      stow # Manage dotfiles symlinking
      gnome-font-viewer # self explanatory
      fx
      yq-go # Note: The package is named yq-go
      figlet
      bitwarden-cli
      ghostty
      uv
      ruff
      tmux
      gedit
      normcap-wrapped
      bitwarden-desktop
      twingate
      vlc
      obsidian
      foot
      calibre
      # nyxt
      # qutebrowser
      neovide
      rstudioWrapper
      hyprls
      zen-browser
      lazygit
      lazycli
      lazydocker
      lazyjournal
      bitwarden-menu
      chromedriver
      google-chrome
      # FROM ZaneyOS
      appimage-run # Needed For AppImage Support
      hyprpicker # Color Picker
      lm_sensors # Used For Getting Hardware Temps
      lshw # Detailed Hardware Information
      ncdu # Disk Usage Analyzer With Ncurses Interface
      picard # For Changing Music Metadata & Getting Cover Art
      usbutils # Good Tools For USB Devices
      gcr
      # Dev Stuff
      nixd
    ])
    ++ [
      #   python-packages # Add the python environment
      r-with-packages # Add the R environment
    ];

  programs = {
    hyprland = {
      enable = true;
      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };

    #    git = {
    #      enable = true;
    #      package = pkgs.gitFull;
    #      config = {
    #        # Default user (GitHub)
    #        user = {
    #          name = "batou069";
    #          email = "laurentf84@gmail.com";
    #        };
    #
    #        # Set up the credential helper
    #        credential = {
    #          helper = "libsecret";
    #        };
    #
    #        # Automatically switch to GitLab user for specific directory
    #        "includeIf \"gitdir:~/git/\"" = {
    #          path = toString ./gitconfig-gitlab;
    #        };
    #      };
    #    };

    waybar.enable = true;
    hyprlock.enable = true;
    firefox.enable = true;
    nm-applet.indicator = true;
    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      exo
      mousepad
      thunar-archive-plugin
      thunar-volman
      tumbler
      #      thunar-vcs-plugin
      thunar-media-tags-plugin
    ];

    virt-manager.enable = false;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = false;
    };

    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # Extra Portal Configuration
  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
  };
}
