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


  zen-browser = let
    real_zen + pkgs.stdenv.mkDerivation rec {
      pname = "zen-browser";
      version = "1.13.2b";
      src = pkgs.fetchurl {
        url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-x86_64.tar.xz";
        sha256 = "sha256-GOD/qZsdCIgldRsOR/Hxo+mB0K7iutKt9XYUj9+6Tgc=";
      };
      # autoPatchelfHook is essential for patching the bundled libraries.
      nativeBuildInputs = [ pkgs.autoPatchelfHook ];
      # These are the system libraries the browser will need.
      buildInputs = with pkgs; [
        alsa-lib gtk3 cairo gdk-pixbuf glib dbus openssl librsvg
      ];
      # A safeguard against breaking the pre-compiled binary.
      dontStrip = true;
      installPhase = ''
        mkdir -p $out/lib/zen-browser
        mv * $out/lib/zen-browser/
      '';
    };
  in

      mkdir -p $out/bin
      ln -s $out/lib/zen-browser/zen-bin $out/bin/zen-browser

      mkdir -p $out/share/applications
      cat > $out/share/applications/zen-browser.desktop <<EOF
      [Desktop Entry]
      Name=Zen Browser
      Exec=zen-browser
      Icon=zen-browser
      Type=Application
      Categories=Network;WebBrowser;
      EOF

      mkdir -p $out/share/icons/hicolor/128x128/apps
      # The tarball contains a 'browser' directory with the icon
      cp $out/lib/zen-browser/browser/chrome/icons/default/default128.png $out/share/icons/hicolor/128x128/apps/zen-browser.png

    '';
  };

  # Definition for normcap-wrapped (as a peer to zen-browser)
  normcap-wrapped = pkgs.writeShellScriptBin "normcap" ''
    #!${pkgs.stdenv.shell}
    export QT_QPA_PLATFORM=wayland
    export XDG_CURRENT_DESKTOP=Hyprland
    exec ${pkgs.normcap}/bin/normcap "$@"
  '';

  in 

  {

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
    zoxide
    starship    
    fx
    yq-go # Note: The package is named yq-go
    figlet
    bitwarden-cli
    ghostty
    uv
    ruff
    tmux
    zellij
    gedit
    normcap-wrapped
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
          path = toString ./gitconfig-gitlab; 
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
