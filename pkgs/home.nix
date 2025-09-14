{
  pkgs,
  username,
  lib,
  inputs,
  ...
}: let
  pythonEnv = pkgs.python312.withPackages (ps:
    with ps; [
      black
      ruff
      ruff_format
      isort
      # faiss
      alive-progress
      spacy
      nltk
      huggingface-hub
      torchvision
      torchaudio
      diffusers
      transformers
      tokenizers
      accelerate
      imageio
      imageio-ffmpeg
      easydict
      ftfy
      addict
      beautifulsoup4
      tensorboard
      torchvision
      deepface
      facenet-pytorch
      torch
      tsfresh
      optuna
      pyquery
      imbalanced-learn
      scipy
      requests
      rich
      polars
      pandas
      numpy
      matplotlib
      pymilvus
      scann
      pygame
      jupyterlab
      jupyter
      pillow
      opencv-python
      tqdm
      plotly
      pytest
      imageio
      seaborn
      python-dotenv
      regex
      tabulate
      ipykernel
      aiofiles
      pip
      scikit-learn
      scikit-image
      debugpy
      sqlalchemy
      pkgs.pyprland
      google-auth-oauthlib
      google-auth-httplib2
      google-api-python-client
    ]);
  customWaybar = pkgs.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
  });
in {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./bat.nix
    ./cli.nix
    ./nixvim
    # ./emacs.nix
    # ./firefox.nix      # not yet ready
    ./fzf.nix # replaced by television
    ./git.nix
    # ./hyprpanel.nix
    # ./hyprlock.nix
    ./lsd.nix
    # ./mpd.nix
    # ./niriswitcher.nix
    # ./nvim
    ./starship.nix
    ./television.nix
    #   ./waybar.nix
    #   ./vscode.nix
    ./zsh.nix
  ];
  programs = {
    ruff = {
      enable = true;
      settings = {};
    };
    hyprpanel.enable = false;
    uv.enable = true;
    nixvim = {
      enable = true;
      vimAlias = true;

      # Import the main nixvim module
      # imports = [];
    };
  };
  services.tldr-update.enable = true;
  # Home Manager version
  home = {
    stateVersion = "24.11";

    # User information
    username = username;
    homeDirectory = "/home/${username}";

    packages = [
      pythonEnv
      # jupyter
      # jupyter-all # Jupyter Notebook and JupyterLab with popular extensions///
      customWaybar
      pkgs.blender # 3D creation suite
      pkgs.fpp
      # ags
      pkgs.igrep # Improved grep with context and file filtering
      pkgs.base16-shell-preview # Set of shell scripts to change terminal colors using
      pkgs.base16-schemes # Collection of base16 color schemes
      pkgs.unstable.manix
      pkgs.unstable.rmpc
      pkgs.rtaudio # Real-time audio I/O library
      pkgs.erdtree # Visualize directory structure as a tree
      # unstable.opencode
      pkgs.cmake
      # unstable.mpd
      pkgs.meld
      pkgs.normcap
      pkgs.fd
      # ripgrep
      pkgs.repgrep # A more powerful ripgrep with additional features
      pkgs.ripgrep-all
      pkgs.alejandra
      pkgs.unstable.pre-commit
      pkgs.nodejs # Provides npm
      pkgs.kdePackages.okular
      pkgs.vgrep # User-friendly pager for grep/git-grep/ripgrep
      # xonsh # Python-ish, BASHwards-compatible shell
      pkgs.vimPluginsUpdater
      pkgs.vimgolf # Interactive Vim golf game, train you vim skills
      pkgs.rofi-obsidian # Rofi plugin to quickly open Obsidian notes
      pkgs.rofi-rbw-wayland # Rofi-frontend for Bitwarden
      pkgs.wtype
      pkgs.rbw
      pkgs.pinentry-rofi
      pkgs.pinentry
      pkgs.alsa-ucm-conf # maybe this fixed sound issue?
      pkgs.tradingview
      pkgs.emacs-pgtk
      pkgs.neovide
      pkgs.appimage-run
      pkgs.codex # Claude Assistant CLI
      pkgs.claudia
      pkgs.tealdeer
      pkgs.statix # Lints and suggestions for the Nix programming language
      # nur.repos.novel2430.zen-browser-bin # Zen Browser
      # nur.repos."7mind".ibkr-tws     # Interactive Brokers TWS
      pkgs.nur.repos.k3a.ib-tws
      pkgs.nixdoc
      pkgs.glow # Beautiful terminal markdown viewer
      pkgs.gum # Terminal-based GUI toolkit
      pkgs.keepassxc # Password manager
      pkgs.keepmenu # Menu for KeePassXC
      pkgs.git-credential-keepassxc # Credential helper for Git
      pkgs.libnotify
      pkgs.papirus-icon-theme
      pkgs.pcmanfm-qt
      pkgs.zed-editor # Code Editor
      pkgs.pnpm # npm package manager
      pkgs.git-filter-repo
      pkgs.sof-tools
      pkgs.fabric-ai
      pkgs.faiss # Command line tool for interacting with Generative AI models
      (pkgs.callPackage ./ipython-ai.nix {}).out
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
      GOOGLE_API_KEY = "$(cat /run/secrets/api_keys/gemini 2>/dev/null || echo '')";
      ANTHROPIC_API_KEY = "$(cat /run/secrets/api_keys/anthropic 2>/dev/null || echo '')";
      NIXOS_OZONE_WL = 1;
      BASE16_SHELL = "$HOME/.config/base16-shell";
      TERM_ITALICS = "true";
      BAT_THEME = "base16";
      PAGER = "less";
      LESS = "-R";
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
      ".ipython/extensions/custom_gemini_provider.py".source = ./custom-gemini-provider.py;
    };

    activation = {
      updateVSCodePythonPath = lib.hm.dag.entryAfter ["writeBoundary"] ''
        set -e # Exit immediately if a command exits with a non-zero status.
        python_path="${pkgs.python312}/bin/python3"
        settings_file="$HOME/.config/Code/User/settings.json"
        tmp_file="$settings_file.tmp"

        printf "Ensuring VSCode Python path is set to: %s\n" "$python_path" >&2

        # Ensure the directory exists
        mkdir -p "$(dirname "$settings_file")"

        # Create an empty JSON object if the file doesn't exist
        if [ ! -f "$settings_file" ]; then
          printf "{}\n" > "$settings_file"
          printf "Created empty settings file: %s\n" "$settings_file" >&2
        fi

        # Use jq to update the file, handling errors
        if ${pkgs.jq}/bin/jq \
          --arg path "$python_path" \
          '.["python.defaultInterpreterPath"] = $path' \
          "$settings_file" > "$tmp_file"; then
          # Check if the content has actually changed before moving
          if ! cmp -s "$settings_file" "$tmp_file"; then
            mv "$tmp_file" "$settings_file"
            printf "Updated VSCode Python path in: %s\n" "$settings_file" >&2
          else
            rm "$tmp_file"
            printf "VSCode Python path already correct in: %s\n" "$settings_file" >&2
          fi
        else
          printf "ERROR: Failed to update %s with jq.\n" "$settings_file" >&2
          rm "$tmp_file"
          exit 1
        fi
      '';
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
      waybar.enable = false;
      wofi.enable = false;
      hyprland.enable = false;
      hyprlock.enable = false;
      vscode = {
        enable = true;
      };
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
