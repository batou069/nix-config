{ config
, pkgs
, username
, lib
, inputs
, pkgs-unstable
, ...
}:
let
  pythonEnv312 = pkgs-unstable.python312.withPackages (ps:
    with ps; [
      flask
      black
      isort
      alive-progress
      spacy
      spacy-models.en_core_web_sm
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
      #     scann
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
      pkgs-unstable.pyprland
      google-auth-oauthlib
      google-auth-httplib2
      google-api-python-client
      # llama-index
      chromadb
      typer
      mcp
      httpx
      fastmcp
    ]);
  customWaybar = pkgs.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  });
  mcp-config =
    let
      mcp-pkgs = inputs.nix-mcp-servers.packages.${pkgs.system};
      # Helper to create a server entry by pointing to the binary
      mkServer = pkg: { command = "${pkg}/bin/${pkg.pname or pkg.name}"; };
    in
    inputs.mcp-servers-nix.lib.mkConfig pkgs {
      fileName = "gemini-settings.json";
      # This is the correct, manual way to define servers to avoid module errors
      # and resolve the dependency collisions you are seeing.
      settings.servers = {
        # --- Servers from the cameronfyfe package set ---
        fetch = mkServer mcp-pkgs.mcp-server-fetch;
        "sequential-thinking" = {
          command = "bash";
          args = [
            "-c"
            "${pkgs.nodejs}/bin/npx -y @modelcontextprotocol/server-sequential-thinking"
          ];
        };
        filesystem = {
          command = "${mcp-pkgs.mcp-server-filesystem}/bin/mcp-server-filesystem";
          args = [ "/home/lf/nix" "/home/lf/git" "/nix" ];
        };
        git = {
          command = "${mcp-pkgs.mcp-server-git}/bin/mcp-server-git";
          args = [ "--repository" "/home/lf/nix" ]; # Set a default repository
        };
        github = mkServer mcp-pkgs.github-mcp-server;
        "brave-search" = mkServer mcp-pkgs.mcp-server-brave-search;

        # --- Custom MCP Servers ---
        nixos = {
          command = "${pkgs.nix}/bin/nix";
          args = [ "run" "github:utensils/mcp-nixos" "--" ];
        };

        # --- Servers from your main nixpkgs ---
        context7 = mkServer pkgs.context7-mcp;
        serena = mkServer inputs.serena.packages.${pkgs.system}.serena;
        tavily = mkServer pkgs.tavily-mcp;

        # --- Special case for memory server with the stderr fix ---
        memory = {
          command = "bash";
          args = [
            "-c"
            # We wrap the command to discard the noisy status message
            "${mcp-pkgs.mcp-server-memory}/bin/mcp-server-memory 2>/dev/null"
          ];
        };
      };
    };
in
{
  # Tell the unstable Home Manager module which package to use for activation.
  programs.home-manager.package = pkgs-unstable.home-manager;
  news.display = "show";
  imports = [
    inputs.nixvim.homeModules.nixvim
    inputs.zen-browser.homeModules.default
    ./tui
    ./editors # Import all editors
    ./gui
    ./shells
  ];

  programs = {
    ruff = {
      enable = true;
      settings = { };
    };
    hyprpanel.enable = false;
    uv.enable = true;
    nixvim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
      extraConfigLuaPre = ''
        vim.loader.enable()
      '';
    };
    # aria2 = {
    #   enable = true;
    #   settings = {
    #     dir = "/home/lf/Downloads/aria2";
    #     enable-rpc = true;
    #     rpcSecretFile = "/home/lf/.config/aria2-rpc-secret";
    #   };
    # };
  };

  gtk = {
    enable = true;
    iconTheme = {
      package = lib.mkForce config.stylix.icons.package;
      name = lib.mkForce config.stylix.icons.dark;
    };
  };

  services = {
    tldr-update.enable = true;
    # copyq = {
    #   enable = true;
    #   forceXWayland = true;
    # };
  };

  # Home Manager version
  home = {
    # This is required because we are using the unstable version of Home Manager
    # with a stable Nixpkgs release, which is intentional.
    enableNixpkgsReleaseCheck = false;
    stateVersion = "24.11";

    # User information
    username = username;

    packages = [
      pkgs.treefmt
      pkgs.spotify-player
      pythonEnv312
      customWaybar
      pkgs.blender # 3D creation suite
      pkgs.fpp
      pkgs.igrep # Improved grep with context and file filtering
      # pkgs.base16-shell-preview # Set of shell scripts to change terminal colors using
      # pkgs.base16-schemes # Collection of base16 color schemes
      pkgs-unstable.manix
      pkgs-unstable.rmpc
      pkgs.rtaudio # Real-time audio I/O library
      pkgs.erdtree # Visualize directory structure as a tree
      pkgs-unstable.opencode
      pkgs.cmake
      pkgs.meld
      pkgs-unstable.normcap
      pkgs.repgrep # A more powerful ripgrep with additional features
      pkgs.ripgrep-all
      pkgs.alejandra
      pkgs-unstable.pre-commit
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
      # pkgs.tradingview
      pkgs.neovide
      pkgs.appimage-run
      pkgs.codex # Claude Assistant CLI
      pkgs.claudia
      pkgs.tealdeer
      pkgs.statix # Lints and suggestions for the Nix programming language
      # nur.repos.novel2430.zen-browser-bin # Zen Browser
      # nur.repos."7mind".ibkr-tws     # Interactive Brokers TWS
      # pkgs.nur.repos.k3a.ib-tws
      # pkgs.nur.repos.clefru.ib-tws
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
      # (pkgs.callPackage ./ipython-ai.nix { inherit pkgs-unstable; }).out

      pkgs.dosbox-staging
      pkgs.dosbox-x
      pkgs.google-chrome
    ];

    sessionVariables = {
      # Personal directory shortcuts
      P = "$HOME/git/py";
      C = "$HOME/.config";
      G = "$HOME/git";
      R = "$HOME/repos";
      O = "$HOME/Obsidian";
      D = "$HOME/dotfiles";
      N = "$HOME/nix";
      DL = "$HOME/Downloads";

      # Personal application preferences
      TERM = "xterm-kitty";
      VISUAL = "nvim";
      EDITOR = "nvim";
      PAGER = "less";
      LESS = "-R";

      # Secrets
      # OPENAI_API_KEY = "$(cat /run/secrets/api_keys/openai 2>/dev/null || echo '')";
      GEMINI_API_KEY = "$(cat /run/secrets/api_keys/gemini 2>/dev/null || echo '')";
      GOOGLE_API_KEY = "$(cat /run/secrets/api_keys/gemini 2>/dev/null || echo '')";
      ZSH_AI_COMMANDS_OPENAI_API_KEY = "$(cat /run/secrets/api_keys/openai 2>/dev/null || echo '')";
      ANTHROPIC_API_KEY = "$(cat /run/secrets/api_keys/anthropic 2>/dev/null || echo '')";
      BW_SESSION = "$(cat /run/secrets/bitwarden 2>/dev/null || echo '')";
      INFLUX_TOKEN = "$(cat /run/secrets/influxdb 2>/dev/null || echo '')";
      # Keys for MCP Servers
      TAVILY_API_KEY = "$(cat /run/secrets/api_keys/tavily 2>/dev/null || echo '')";
      BRAVE_API_KEY = "$(cat /run/secrets/api_keys/brave_search 2>/dev/null || echo '')";
      GITHUB_TOKEN = "$(cat /run/secrets/api_keys/github_mcp 2>/dev/null || echo '')";
      # Theming and shell appearance
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
      # ".ipython/extensions/custom_gemini_provider.py".source = ./custom-gemini-provider.py;
      ".gemini/settings.json".source = mcp-config;

      # Declaratively load Hyprland plugins as a workaround for the NixOS module bug
      # ".config/hypr/plugins-load.conf" = {
      #   text = ''
      #     # WARNING: This file is generated by Nix. Do not edit it manually.
      #     exec-once = hyprctl plugin load ${inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo}/lib/libhyprexpo.so
      #     exec-once = hyprctl plugin load ${inputs.hyprland-plugins.packages.${pkgs.system}.xtra-dispatchers}/lib/libxtra-dispatchers.so
      #     exec-once = hyprctl plugin load ${inputs.hy3.packages.${pkgs.system}.hy3}/lib/libhy3.so
      #   '';
      # };
    };

    activation = {
      updateVSCodePythonPath = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
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

  fonts.fontconfig.enable = false;

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
        "audio/*" = [ "vlc.desktop" ];
        "video/*" = [ "vlc.desktop" ];
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
    # Extra Portal Configuration
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
        pkgs.gnome-keyring
      ];
      config.hyprland = {
        default = [ "hyprland" "gtk" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };
    };
  };

  stylix = {
    enable = true;
    enableReleaseChecks = false;
    autoEnable = true;
    targets = {
      bat.enable = true;
      tmux.enable = true;
      neovim = {
        enable = true;
        # plugin = "base16-nvim";
        transparentBackground = {
          main = true;
          numberLine = true;
          signColumn = true;
        };
      };
      starship.enable = true;
      wofi.enable = true;
      fzf.enable = true;
      hyprland.enable = true;
      vscode.enable = true;
      kitty.enable = true;
    };
    polarity = "either";
    targets.font-packages.enable = true;
    icons = {
      enable = true;
      package = pkgs.juno-theme;
      # dark = "Papirus-Dark";
      # light = "Papirus-Light";
    };

    opacity = {
      applications = 1.5;
      desktop = 1.5;
      popups = 0.80;
      terminal = 1.0;
    };
  };
}
