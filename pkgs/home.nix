{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./cli.nix
    ./vscode.nix
    ./bat.nix
    # ./firefox.nix
    # ./fzf.nix
    ./git.nix
    ./hyprlock.nix
    ./lsd.nix
    ./nvim
    ./starship.nix
    ./television.nix
    # ./waybar.nix
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
      fpp
      # ags
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
      vimPluginsUpdater
      vimgolf
      rofi-obsidian
      rofi-rbw
      tradingview
      neovide
      appimage-run
      unstable.home-manager
      codex
      claudia
      statix
      nur.repos.novel2430.zen-browser-bin
      nur.repos."7mind".ibkr-tws
      nixdoc
      glow
      gum
      mpd
      keepassxc
      keepmenu
      git-credential-keepassxc
      helix
      # evil-helix
      wtype
      libnotify
      papirus-icon-theme
      pcmanfm-qt
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
            aiofiles
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

    # programs.niriswitcher = {
    #     enable = true;
    #     settings = {
    #           keys = {
    #             modifier = "Super";
    #             switch = {
    #               next = "Tab";
    #               prev = "Shift+Tab";
    #             };
    #             window = {
    #                 close = "q";
    #                 abort = "Escape";
    #               };
    #           };
    #           appearance = {
    #             system_theme = "dark";
    #             icon_size = 64;
    #           };
    #           separate_workspaces = true;
    #           current_output_only = false;
    #           double_click_to_hide = false;
    #           center_on_focus = false;
    #           log_level = "WARN";
    #       };
    #   };

    # qt = {
    #   enable = true;
    #   platformTheme.name = "gtk";
    #   style = {
    #     package = pkgs.adwaita-qt;
    #     name = "adwaita-dark";
    #     };
    #   };

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
    stylix.targets = {
      neovim.enable = false;
      waybar.enable = false;
      rofi.enable = false;
      hyprland.enable = false;
      hyprlock.enable = false;
      # vscode = {
      #   enable = true;
      # };
      #   iconTheme = {
      #     enable = true;
      #     package = pkgs.papirus-icon-theme;
      #     dark = "Papirus-Dark";
      #     light = "Papirus-Light";
      #   };
      #  cursor = {
      #    name = "DMZ-Black";
      #    size = 24;
      #    package = pkgs.vanilla-dmz;
      #  };
    };
  };
}
