# 💫 https://github.com/JaKooLit 💫 #
# Packages and Fonts config including the "programs" options

{ pkgs, inputs, ...}: let

  python-packages = pkgs.python312.withPackages (
    ps:
      with ps; [
        requests
        pyquery # needed for hyprland-dots Weather script
        requests
        jupyterlab
        matplotlib
        numpy
        pandas
        pillow
        plotly
        pytest
        seaborn
        python-dotenv
        regex
        tabulate
        ]
    );

  r-with-packages = pkgs.rWrapper.override {
    packages = with pkgs.rPackages; [
      IRkernel
    ];
  };

  zen-browser = pkgs.rustPlatform.buildRustPackage rec {
    pname = "zen-browser";
    version = "1.13.2b";

    src = pkgs.fetchFromGitHub {
      owner = "zen-browser";
      repo = "desktop";
      rev = "v${version}";
      # This is the real source hash you already correctly found.
      sha256 = "sha256-LGoGq49lShsaBkZyTuBOauP3t3Syd4Wu5NUBACcsucw=";
    };

  # This is the key. It tells Nix to use the lock file from the source.
  # We no longer need cargoHash or cargoSha256 at all.
  cargoLock.lockFile = "${src}/Cargo.lock";
    # Dependencies needed to build Tauri apps
    nativeBuildInputs = with pkgs; [ pkg-config ];
    buildInputs = with pkgs; [
      webkitgtk
      gtk3
      cairo
      gdk-pixbuf
      glib
      dbus
      openssl
      librsvg
    ];

    # Fix for running in NixOS
    postInstall = ''
      install -Dm644 $src/zen-browser/icons/icon.png $out/share/icons/hicolor/128x128/apps/zen-browser.png
      install -Dm644 $src/zen-browser/zen.desktop $out/share/applications/zen-browser.desktop

      substituteInPlace $out/share/applications/zen-browser.desktop \
        --replace 'Exec=zen' 'Exec=${placeholder "out"}/bin/zen'
    '';
  };


  in {

  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = (with pkgs; [
  # System Packages
    bc
    baobab
    btrfs-progs
    clang
    curl
    cpufrequtils
    duf
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
    vim
    wget
    xdg-user-dirs
    xdg-utils

    fastfetch
    (mpv.override {scripts = [mpvScripts.mpris];}) # with tray
    #ranger
      
    # Hyprland Stuff
    # Buuild AGS v1 from source
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

    # --- MY PACKAGES ---
    # Your requested packages
    yq-go # Note: The package is named yq-go
    figlet
    bitwarden-cli
    ghostty
    uv
    ruff
    tmux
    zellij
    gedit
    normcap
    bitwarden-desktop
    twingate
    vlc
    obsidian
    foot
    calibre
    nyxt
    qutebrowser
    neovide
    rstudioWrapper
    hyprls
    vscode
    # The custom zen-browser package
    zen-browser
    lazygit
    lazycli
    lazydocker
    lazyjournal
    bitwarden-menu
  ]) ++ [
      python-packages # Add the python environment
      r-with-packages # Add the R environment
  ];

#FONTS
fonts = {
    packages = with pkgs; [
      dejavu_fonts
      fira-code
      fira-code-symbols
      font-awesome
      hackgen-nf-font
      ibm-plex
      inter
      jetbrains-mono
      material-icons
      maple-mono.NF
      minecraftia
      nerd-fonts.im-writing
      nerd-fonts.blex-mono
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-monochrome-emoji
      powerline-fonts
      roboto
      roboto-mono
      symbola
      terminus_font
      victor-mono
      nerd-fonts.fantasque-sans-mono
      zoxide
      starship
    ];
  };
  
  programs = {
	  hyprland = {
      enable = true;
     	  #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland; #hyprland-git
		    #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland; #xdph-git
     	  
        portalPackage = pkgs.xdg-desktop-portal-hyprland; # xdph none git
  	  xwayland.enable = true;
    };

    git = {
      enable = true;
      package = pkgs.gitFull;
      config = {
        # Default user (GitHub)
        user = {
          name = "batou069";
          email = "laurentf84@gmail.com";
        };

        # Set up the credential helper
        credential = {
          helper = "libsecret";
        };

        # Automatically switch to GitLab user for specific directory
        "includeIf \"gitdir:~/git/\"" = {
          path = ./gitconfig-gitlab; 
        };
      };
    };

    waybar.enable = true;
    hyprlock.enable = true;
    firefox.enable = true;
    nm-applet.indicator = true;
    neovim.enable = true;

    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
	exo
	mousepad
	thunar-archive-plugin
	thunar-volman
	tumbler
        thunar-vcs-plugin
        thunar-media-tags-plugin
    ];
	
    virt-manager.enable = false;
    
    steam = {
      enable = true;
      gamescopeSession.enable = true;
     # remotePlay.openFirewall = true;
      #dedicatedServer.openFirewall = true;
    };
    
    xwayland.enable = true;

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
