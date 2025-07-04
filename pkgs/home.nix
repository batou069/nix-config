{
  pkgs,
  username,
  inputs,
  # config,
  ...
}: {
  imports = [
    ./cli.nix
    ./vscode.nix
    ./bat.nix
    # ./firefox.nix
    ./fzf.nix
    ./git.nix
    ./lsd.nix
    ./nvim
    ./starship2.nix
    ./zsh.nix
  ];

  # nixpkgs.overlays = [
  #         inputs.nur.overlays.default];

  # Home Manager version
  home = {
    stateVersion = "24.11";

    # User information
    username = username;
    homeDirectory = "/home/${username}";

    # User-specific packages
    packages = with pkgs; [
      # --- Fonts ---
      # General Purpose / Sans-Serif Fonts
      dejavu_fonts
      ibm-plex
      inter
      roboto

      # Monospace / Programming Fonts
      fira-code
      jetbrains-mono
      hackgen-nf-font
      roboto-mono
      terminus_font
      victor-mono
      nerd-fonts.im-writing
      nerd-fonts.fantasque-sans-mono
      maple-mono.NF

      # Icon / Symbol Fonts
      font-awesome
      fira-code-symbols
      material-icons
      powerline-fonts
      symbola

      # Noto Fonts
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-monochrome-emoji

      # Niche/Specific Fonts
      minecraftia

      fpp
      igrep
      unstable.ladybird
      unstable.manix
      meld
      normcap
      fd
      igrep
      # ripgrep
      repgrep
      # ripgrep-all
      alejandra
      unstable.pre-commit
      kdePackages.okular
      vgrep # User-friendly pager for grep/git-grep/ripgrep
      xonsh # Python-ish, BASHwards-compatible shell
      # pkgs.nur.repos
      vimPluginsUpdater
      vimgolf
      rofi-obsidian
      tradingview
      neovide
      appimage-run
      unstable.home-manager
      codex
      claudia
      statix
      nur.repos.AusCyber.zen-browser
      # ; nur.repos.7mind.ibkr-tws
      # nur.repos.novel2430.zen-browser
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
            ipykernel
            # selenium
            # beautifulsoup4
            # pika
            # pymongo
            # lxml
            # redis
            # aiohttp
            # NetscapeBookmarksFileParser
            scipy
          ]
      ))
    ];

    sessionVariables = {
      I = "$HOME/git/c/";
      P = "$HOME/git/py/";
      C = "$HOME/.config/";
      G = "$HOME/git/";
      R = "$HOME/apps/";
      O = "$HOME/Obsidian/";
      D = "$HOME/dotfiles/";
      N = "$HOME/NixOS-Hyprland/";
      TERM = "xterm-256color";
      VISUAL = "nvim";
      EDITOR = "nvim";
      OPENAI_API_KEY = "$(cat /run/secrets/api_keys/openai 2>/dev/null || echo '')";
      GEMINI_API_KEY = "$(cat /run/secrets/api_keys/gemini 2>/dev/null || echo '')";
      ANTHROPIC_API_KEY = "$(cat /run/secrets/api_keys/anthropic 2>/dev/null || echo '')";
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
        '';
      };
    };
  };

  fonts.fontconfig.enable = true;

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
    # configFile."nvim/lua" = {
    #   recursive = true;
    #   source = ./lua;
    # };

    configFile = {
      "mimeapps.list".force = true;
    };
  };
}
