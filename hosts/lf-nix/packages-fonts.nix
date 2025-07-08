{pkgs, ...}: let
  r-with-packages = pkgs.rWrapper.override {
    packages = with pkgs.rPackages; [
      IRkernel
    ];
  };
in {
  nixpkgs.config.allowUnfree = true;

  # nix.extraOptions = ''
  #   plugin-files = ${pkgs.nix-doc}/lib/libnix_doc_plugin.so
  # '';

  environment.systemPackages =
    (with pkgs; [
      # System Packages
      # home-manager
      alsa-utils

      isd # interactively interact with systemd
      erdtree # You can think of erdtree as a little bit of du, tree, find, wc and ls.
      baobab
      btrfs-progs
      clang
      mcp-server-fetch

      cpufrequtils
      duf # Utility For Viewing Disk Usage In Terminal
      findutils
      ffmpeg
      gsettings-qt
      git
      git-credential-manager
      killall
      libappindicator
      libnotify
      openssl #required by Rainbow borders
      pciutils
      wget
      xdg-user-dirs
      xdg-utils
      linux-firmware

      (mpv.override {scripts = [mpvScripts.mpris];}) # with tray
      # ranger

      # Hyprland Stuff
      ags
      # inputs.ags.packages.${pkgs.system}.default
      nix-your-shell
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

      ijq
      manix
      mediainfo

      libsForQt5.qtstyleplugin-kvantum #kvantum
      networkmanagerapplet
      nwg-displays
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

      unzip
      wallust
      wl-clipboard
      wlogout
      xarchiver
      yad
      yt-dlp

      # --- MY PACKAGES ---
      # Your requested packages
      lutris
      heroic
      bottles
      stow # Manage dotfiles symlinking
      gnome-font-viewer
      fx
      yq-go # Note: The package is named yq-go
      figlet
      ghostty
      uv
      tmux
      gedit
      vlc
      obsidian
      foot
      calibre
      # nyxt
      # qutebrowser
      rstudioWrapper

      lazycli
      lazydocker
      lazyjournal
      bitwarden-menu
      chromedriver
      google-chrome
      lagrange
      # FROM ZaneyOS
      appimage-run # Needed For AppImage Support
      hyprpicker # Color Picker
      lshw # Detailed Hardware Information
      ncdu # Disk Usage Analyzer With Ncurses Interface
      picard # For Changing Music Metadata & Getting Cover Art
      usbutils # Good Tools For USB Devices
      gcr
      # Dev Stuff
      nixd
      nh
    ])
    ++ (with pkgs.unstable; [
      #   gemini-cli
      bc
      curl
      glib #for gsettings to work
      fastfetch
      jq
      nwg-look
      swww
      nix-search-tv
      claude-code
      bitwarden-cli
      ruff
      bitwarden-desktop
      twingate
      hyprls
      lazygit
      lm_sensors # Used For Getting Hardware Temps
      sof-firmware
    ])
    ++ [
      #   python-packages # Add the python environment
      r-with-packages # Add the R environment
    ]
;

  programs = {
    hyprland = {
      enable = true;
      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
      withUWSM = true;
    };
    hyprlock.enable = true;
    waybar.enable = false;
    thunar = {
      enable = true;
      # thunar.
      plugins = with pkgs.xfce; [
        exo
        mousepad
        thunar-archive-plugin
        thunar-volman
        tumbler
        #      thunar-vcs-plugin
        thunar-media-tags-plugin
      ];
    };
    virt-manager.enable = false;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = false;
    };
    firefox.enable = true;
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
