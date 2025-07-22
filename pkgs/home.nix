{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./bat.nix
    ./cli.nix
    # ./emacs.nix
    # ./firefox.nix      # not yet ready
    # ./fzf.nix          # replaced by television
    ./git.nix
    ./hyprpanel.nix
    # ./hyprlock.nix
    ./lsd.nix
    # ./mpd.nix
    # ./niriswitcher.nix
    ./nvim
    ./starship.nix
    ./television.nix
    # ./waybar.nix
    #   ./vscode.nix
    ./zsh.nix
  ];

  # Home Manager version
  home = {
    stateVersion = "24.11";

    # User information
    username = username;
    homeDirectory = "/home/${username}";

    # User-specific packages
    packages = with pkgs; [
      blender
      pyprland
      fpp
      # ags
      igrep
      base16-shell-preview
      base16-schemes
      # unstable.gemini-cli
      unstable.manix
      unstable.rmpc
      rtaudio
      erdtree # You can think of erdtree as a little bit of du, tree, find, wc and ls.
      unstable.opencode
      cmake
      #      unstable.mpd
      meld
      normcap
      fd
      igrep
      # ripgrep
      repgrep
      ripgrep-all
      alejandra
      unstable.pre-commit
      nodejs # Provides npm
      kdePackages.okular
      vgrep # User-friendly pager for grep/git-grep/ripgrep
      xonsh # Python-ish, BASHwards-compatible shell
      vimPluginsUpdater
      vimgolf # Interactive Vim golf game, train you vim skills
      rofi-obsidian
      rofi-rbw-wayland # Rofi-frontend for Bitwarden
      wtype
      rbw
      pinentry-rofi
      pinentry
      alsa-ucm-conf # maybe this fixed sound issue?
      tradingview
      emacs-pgtk
      neovide
      appimage-run
      unstable.home-manager
      codex # Claude Assistant CLI
      claudia
      statix # Lints and suggestions for the Nix programming language
      # nur.repos.novel2430.zen-browser-bin   # Zen Browser
      # nur.repos."7mind".ibkr-tws     # Interactive Brokers TWS
      nur.repos.k3a.ib-tws
      nixdoc
      glow # Beautiful terminal markdown viewer
      gum # Terminal-based GUI toolkit
      keepassxc # Password manager
      keepmenu # Menu for KeePassXC
      git-credential-keepassxc # Credential helper for Git
      libnotify
      papirus-icon-theme
      pcmanfm-qt
      zed-editor # Code Editor
      pnpm # npm package manager
      git-filter-repo
      sof-tools
      (python312.withPackages (
        ps:
          with ps; [
            requests
            pyquery
            jupyterlab
            jupyter
            matplotlib
            numpy
            pandas
            pillow
            plotly
            pytest
            # seaborn
            python-dotenv
            regex
            # tabulate
            # ipykernel
            # selenium
            # beautifulsoup4
            # pika
            # pymongo
            # lxml
            # redis
            # aiohttp
            # NetscapeBookmarksFileParser
            scipy
            aiofiles
            duckduckgo-search
            scikit-image
            imageio
            pywavelets
            debugpy
          ]
      ))
    ];

    sessionVariables = {
      P = "$HOME/git/py";
      C = "$HOME/.config";
      G = "$HOME/git";
      R = "$HOME/repos";
      O = "$HOME/Obsidian";
      D = "$HOME/dotfiles";
      N = "$HOME/nix";
      DL = "$HOME/Downloads";
      TERM = "xterm-256color";
      VISUAL = "nvim";
      EDITOR = "nvim";
      OPENAI_API_KEY = "$(cat /run/secrets/api_keys/openai 2>/dev/null || echo '')";
      GEMINI_API_KEY = "$(cat /run/secrets/api_keys/gemini 2>/dev/null || echo '')";
      ANTHROPIC_API_KEY = "$(cat /run/secrets/api_keys/anthropic 2>/dev/null || echo '')";
      NIXOS_OZONE_WL = 1;
      BASE16_SHELL = "$HOME/.config/base16-shell";
      TERM_ITALICS = "true";
      BAT_THEME = "base16";
    };

    file = {
      ".pre-commit-config.yaml" = {
        source = ../.pre-commit-config.yaml; # Path to the file in your dotfiles
        target = ".pre-commit-config.yaml";
      };
      ".gitignore" = {
        text = ''
          keys.txt
          example_config/
          example_config/*
          secrets.pt.yaml
        '';
      };
    };
  };

  fonts.fontconfig.enable = true;
  # catppuccin = {
  #   flavor = "mocha";
  #   accent = "peach";
  #   enable = true;
  # };

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/markdown" = "code.desktop";
        "text/plain" = "code.desktop";
        "text/x-csv" = "code.desktop";
        "text/x-log" = "code.desktop";
        "text/x-patch" = "code.desktop";
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/mailto" = "firefox.desktop";
        "x-scheme-handler/vscode" = "vscode.desktop";
        "image/jpeg" = "loupe.desktop";
        "image/png" = "loupe.desktop";
        "image/gif" = "loupe.desktop";
        "image/bmp" = "loupe.desktop";
        "image/svg+xml" = "loupe.desktop";
        "application/pdf" = "org.kde.okular.desktop";
        "application/xml" = "code.desktop";
        "application/x-yaml" = "code.desktop";
        "application/json" = "code.desktop";
        "image/avif" = "loupe.desktop";
        "audio/*" = ["vlc.desktop"];
        "video/*" = ["vlc.desktop"];
      };
    };
    userDirs = {
      enable = true;
      desktop = "$HOME/Desktop";
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      music = "$HOME/Music";
      pictures = "$HOME/Pictures";
      videos = "$HOME/Videos";
    };
    configFile = {
      "nvim/lua" = {
        recursive = true;
        source = ./nvim/lua;
      };
      "mimeapps.list".force = true;
    };
  };
  stylix = {
    enable = true;
    autoEnable = true;
    targets = {
      neovim.enable = false;
      # waybar.enable = false;
      wofi.enable = false;
      hyprland.enable = false;
      hyprlock.enable = false;
      # vscode = {
      #   enable = true;
      # };
      kitty = {
        enable = true;
        variant256Colors = true;
      };
      font-packages.enable = true;
    };
    # iconTheme = {
    # enable = true;
    # package = pkgs.papirus-icon-theme;
    # dark = "Papirus-Dark";
    # light = "Papirus-Light";
    # };
    # cursor = {
    # name = "DMZ-Black";
    # size = 24;
    # package = pkgs.vanilla-dmz;
    # };
    # opacity = {
    # applications = 0.95;
    # desktop = 0.95;
    # popups = 1.0;
    # terminal = 0.95;
    # };
  };
}
