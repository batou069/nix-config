{ pkgs
, pkgs-unstable
, inputs
, ...
}:
let
  r-with-packages = pkgs.rWrapper.override {
    packages = with pkgs.rPackages; [
      IRkernel
      tidyverse
      lubridate
      modelr
      caTools
      psych
      devtools
      sandwich
      lemon
      gridExtra
      arm
      broom
      boot
      RcppEigen
      lme4
    ];
  };
in
{
  imports = [
    ../../home/gemini/gemini-cli-lf.nix
  ];

  environment.systemPackages =
    (with pkgs; [
      fuzzel
      overskride
      ksnip
      ytmdl
      influxdb3
      pstree
      # games

      dreamchess
      lc0
      pkgs-unstable.stockfish
      pandoc
      emojify
      oath-toolkit
      smassh
      pastel
      catppuccin-plymouth
      cargo-seek
      # System Packages
      alsa-utils
      isd # interactively interact with systemd
      baobab
      btrfs-progs
      clang

      # MCP SERVERS

      # mcp-server-fetch
      # mcp-server-sequential-thinking
      # context7-mcp
      # mcp-server-filesystem
      # (callPackage ../../pkgs/wrapped-mcp-server-memory.nix {
      #   original-mcp-server-memory = inputs.nix-mcp-servers.packages.${pkgs.system}.mcp-server-memory;
      # })
      # mcp-server-git
      # tavily-mcp
      # github-mcp-server
      # serena
      # mcp-server-brave-search

      jrnl
      cpufrequtils
      duf # Utility For Viewing Disk Usage In Terminal
      findutils
      ffmpeg
      pkg-config
      gsettings-qt
      git
      git-credential-manager
      killall
      libappindicator
      libnotify
      openssl # required by Rainbow borders
      pciutils
      wget
      xdg-user-dirs
      xdg-utils
      linux-firmware
      d2

      # (mpv.override {scripts = [mpvScripts.mpris];}) # with tray
      # ranger
      inputs.zen-browser.packages."${system}".default
      # Hyprland Stuff
      #ags
      # inputs.ags.packages.${pkgs.system}.default
      nix-your-shell
      btop
      brightnessctl # for brightness control
      cava
      cliphist
      loupe
      gnome-system-monitor
      grim
      gtk-engine-murrine # for gtk themes
      hypridle
      imagemagick
      inxi

      ijq
      manix
      mediainfo

      libsForQt5.qtstyleplugin-kvantum # kvantum
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
      kdePackages.qtstyleplugin-kvantum # kvantum
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
      stow # Manage dotfiles symlinking
      gnome-font-viewer
      fx
      yq-go
      figlet
      # uv # Python Package Manager & more
      gedit # Editor Gui
      vlc # Video Player
      obsidian
      foot # terminal
      calibre # ebooks manager
      # nyxt
      # qutebrowser
      nix-init # create pkg from url
      vulnix # vulnerability scanner

      lazycli
      lazydocker
      lazyjournal
      bitwarden-menu
      chromium
      lagrange
      # FROM ZaneyOS
      appimage-run # Needed For AppImage Support
      hyprpicker # Color Picker
      grimblast # Screenshots
      nix-init # Screenshots
      lshw # Detailed Hardware Information
      ncdu # Disk Usage Analyzer With Ncurses Interface
      picard # For Changing Music Metadata & Getting Cover Art
      usbutils # Good Tools For USB Devices
      # gcr
      # Dev Stuff
      # nh
      meowpdf
      # zsh-f-sy-h
      # zsh-forgit
      # zsh-autopair
      # zsh-you-should-use
      # zsh-history-to-fish
      # End Dev Stuff
    ])
    ++ (with pkgs-unstable; [
      nixd
      bc
      curl
      glib # for gsettings to work
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
      pipx
      lm_sensors # Used For Getting Hardware Temps
      sof-firmware
      inputs.hyprviz.packages.${pkgs.system}.default
      hyprshade
    ])
    ++ [
      r-with-packages # Add the R environment
    ];

  programs = {
    zoom-us.enable = true;
    # mangowc.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableXonshIntegration = true;
    };

    # xonsh.enable = false;
    hyprlock.enable = true;
    waybar.enable = true;
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
      extraCompatPackages = [ pkgs.proton-ge-bin ];
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

  # services = {
  # aria2 = {
  #   enable = true;
  #   rpcSecretFile = "${config.users.users.${username}.home}/.config/aria2-rpc-secret";
  #   # settings = {
  #   #   dir = "${config.users.users.${username}.home}/Downloads/aria2";
  #   #   enable-rpc = true;
  #   # };
  # };
  # };

  # # Extra Portal Configuration
  # xdg.portal = {
  #   enable = true;
  #   wlr.enable = false;
  #   extraPortals = [
  #     pkgs.xdg-desktop-portal-hyprland
  #     pkgs.xdg-desktop-portal-gtk
  #   ];
  #   config.common.default = "hyprland";
  #   config."org.freedesktop.impl.portal.FileChooser".default = "gtk";
  # };
}
