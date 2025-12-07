{ config
, inputs
, pkgs
, lib
, libPkg
, ...
}:
let
  pythonEnv312 = pkgs.python312.withPackages (
    ps:
      with ps; [
        pnglatex
        plotly
        kaleido
        pyperclip
        flask
        black
        plotly
        isort
        alive-progress
        # spacy
        # spacy-models.en_core_web_sm
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
        # opencv-python
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
        # llama-index
        # chromadb
        mcp
        httpx
        fastmcp
      ]
  );
  customWaybar = pkgs.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  });
  tclint-dummy = pkgs.writeShellScriptBin "tclint" "exit 0";
in
{
  news.display = "show";
  imports = [
    # inputs.nixvim.homeModules.nixvim
    # inputs.zen-browser.homeModules.default
    ./tui
    ./editors # Import all editors
    ./gui
    ./shells
    ./kde.nix
    ./mcp.nix
    # ./zen-browser.nix
    ./mpd.nix
    ./gemini.nix
    ./email.nix
  ];

  programs = {
    # Tell the unstable Home Manager module which package to use for activation.
    home-manager = {
      package = pkgs.home-manager;
    };

    # Centralized MCP Server Configuration

    # astroid = {
    #   enable = true;
    # };
    #
    # notmuch = {
    #   enable = true;
    # };
    lesspipe.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      config = {
        hide_env_diff = true;
      };
      # Shell integrations are auto-enabled when the shell is enabled
    };

    bluetuith = {
      enable = true;
      settings = {
        keybindings = {
          adapter = "hci0";
          Menu = "Alt+m";
        };
      };
    };

    # fuzzel = {
    #   enable = true;
    #   # settings = {
    #   #   # colors = {
    #   #   #   # background = "24273add";
    #   #   #   text = "cad3f5ff";
    #   #   #   prompt = "b8c0e0ff";
    #   #   #   placeholder = "8087a2ff";
    #   #   #   input = "cad3f5ff";
    #   #   #   match = "f5a97fff";
    #   #   #   selection = "5b6078ff";
    #   #   #   selection-text = "cad3f5ff";
    #   #   #   selection-match = "f5a97fff";
    #   #   #   counter = "8087a2ff";
    #   #   #   border = "f5a97fff";
    #   #   # };
    #   # };
    # };
    retroarch = {
      cores = {
        mgba.enable = true;
        genesis-plus-gx.enable = true;
        dosbox-pure.enable = true;
        dolphin.enable = true;
        bsnes.enable = true;
        blastem.enable = true;
        yabause.enable = true;
        citra.enable = true;
        vice-xvic.enable = true;
        snes9x = {
          enable = true;
          package = pkgs.libretro.snes9x2010;
        };
      };
    };

    discord.enable = true;

    zapzap.enable = true;
    claude-code.enable = true;
    claude-code.package = pkgs.claude-code;
    hyprshot.enable = true;
    hyprshot.saveLocation = "$HOME/Pictures/Screenshots";
    satty.enable = true;
    swappy.enable = true;
    swappy.settings = {
      Default = {
        auto_save = false;
        custom_color = "rgba(193,125,17,1)";
        early_exit = false;
        fill_shape = false;
        line_size = 5;
        paint_mode = "brush";
        save_dir = "$HOME/Pictures";
        save_filename_format = "swappy-%Y%m%d-%H%M%S.png";
        show_panel = false;
        text_font = "sans-serif";
        text_size = 20;
        transparency = 50;
        transparent = false;
      };
    };
    vivid = {
      enable = true;
      enableZshIntegration = true;
      # activeTheme = "molokai";
      themes = {
        ayu = builtins.fetchurl {
          url = "https://raw.githubusercontent.com/NearlyTRex/Vivid/refs/heads/master/themes/ayu.yml";
          sha256 = "sha256:02fj9y2857rhv3hdcn1xijxwims5x3caxg2qs8g85nvp2xbvz3gl";
        };

        mocha = builtins.fetchurl {
          url = "https://raw.githubusercontent.com/NearlyTRex/Vivid/refs/heads/master/themes/catppuccin-macchiato.yml";
          sha256 = "02np9axddfl4wyw31xvdn2hj7hi8wgd5knqp10gwl2hzk775ql5l";
        };
      };
    };

    aider-chat.enable = true;
    aider-chat.settings = {
      cache-prompts = true;
      # lint = true;
      verify-ssl = false;
    };
    fabric-ai = {
      enable = true;
      package = pkgs.fabric-ai;
      enableZshIntegration = true;
      enableYtAlias = true;
      enablePatternsAliases = true;
    };

    anime-downloader.enable = true;
    amber.enable = true;
    amber.ambsSettings = {
      regex = false;
      column = false;
      row = false;
      binary = false;
      statistics = false;
      skipped = false;
      interactive = true;
      recursive = true;
      symlink = true;
      color = true;
      file = true;
      skip_vcs = true;
      skip_gitignore = false;
      fixed_order = true;
      parent_ignore = true;
      line_by_match = false;
    };
    ruff = {
      enable = true;
      package = pkgs.ruff;
      settings = { };
    };
    hyprpanel.enable = false;
    uv.enable = true;
    nixvim = {
      enable = true;
      package = libPkg inputs.neovim-nightly;

      defaultEditor = true;

      performance = {
        byteCompileLua.enable = true;
      };

      vimAlias = true;
      viAlias = true;
      extraConfigLuaPre = ''
        vim.loader.enable()

        require("mcphub").setup({
          auto_approve = true,
          mcp_request_timeout = 120000,
        })
      '';
      luaLoader.enable = true;
      extraPlugins = [
        (libPkg inputs.mcp-hub-nvim)
      ];
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
      name = lib.mkForce config.stylix.icons.${config.stylix.polarity};
    };
    colorScheme = "dark";
    gtk3 = {
      bookmarks = [
        "file://${config.home.homeDirectory}/Documents"
        "file://${config.home.homeDirectory}/Downloads"
        "file://${config.home.homeDirectory}/Pictures"
        "file://${config.home.homeDirectory}/Videos"
        "file://${config.home.homeDirectory}/Downloads"
        "file://${config.home.homeDirectory}/repos"
      ];
    };
  };

  services = {
    espanso = {
      enable = true;
      configs = {
        vscode = {
          filter_title = "Visual Studio Code$";
          backend = "Clipboard";
        };
      };
      matches = {
        default = {
          matches = [
            {
              trigger = ":nrs";
              replace = "nix nixos-rebuild switch --flake $N";
            }
            {
              trigger = ":lf";
              replace = "Laurent Flaster";
            }
            {
              trigger = ":now";
              replace = "{{currentdate}} {{currenttime}}";
            }
            {
              trigger = ":code";
              replace = "```\n$|$\n```";
            }
            {
              trigger = ":rebuild";
              replace = "sudo nixos-rebuild switch --flake $N#lf-nix -vv";
            }
          ];
        };
        global_vars = {
          global_vars = [
            {
              name = "currentdate";
              type = "date";
              params = { format = "%d/%m/%Y"; };
            }
            {
              name = "currenttime";
              type = "date";
              params = { format = "%R"; };
            }
          ];
        };
      };
    };

    signaturepdf = {
      enable = true;
      port = 8082;
      extraConfig = {
        max_file_uploads = "201";
        post_max_size = "24M";
        upload_max_filesize = "24M";
      };
    };

    activitywatch = {
      enable = true;
      watchers = {
        aw-watcher-window-wayland = {
          package = pkgs.aw-watcher-window-wayland;
        };
        # aw-watcher-afk = {
        #   enable = false;
        #   package = pkgs.aw-watcher-afk;
        #   settings = {
        #     timeout = 180;
        #     poll_time = 5;
        #   };
        # };

        # aw-watcher-window = {
        #   package = pkgs.aw-watcher-window;
        #   settings = {
        #     poll_time = 4;
        #     exclude_title = true;
        #   };
        # };
      };
    };

    tomat = {
      enable = true;
      package = pkgs.tomat;
    };
    emacs = {
      enable = true;
      client.enable = true;
    };
    # cliphist.enable = true;
    tldr-update.enable = true;
    home-manager.autoUpgrade.useFlake = true;
    home-manager.autoUpgrade.flakeDir = "${config.home.homeDirectory}/nix";
    # wl-clip-persist.enable = false;
    # wl-clip-persist.clipboardType = "regular"; # Type: one of "regular", "primary", "both"
    # wl-clip-persist.extraOptions = [
    # # Available options include:
    # - --write-timeout : Timeout for writing clipboard data (default: 3000.
    # - --ignore-event-on-error: Only handle events without errors.
    # - --all-mime-type-regex : Filter events by MIME type regex.
    # - --selection-size-limit : Limit clipboard data size.
    # - --reconnect-tries : Number of reconnection attempts.
    # - --reconnect-delay : Delay between reconnect attempts (default: 100.
    # - --disable-timestamps: Disable log timestamps.

    #
    # "--write-timeout"
    # "1000"
    # "--ignore-event-on-error"
    # "--all-mime-type-regex"
    # "'(?i)^(?!image/).+'"
    # "--selection-size-limit"
    # "1048576"
    # ]
    # copyq = {
    #   enable = true;
    #   forceXWayland = true;
    # };
  };

  systemd.user.startServices = "sd-switch";

  systemd.user.services = {
    waybar = {
      Unit = {
        Description = "Waybar";
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.waybar}/bin/waybar";
        Restart = "on-failure";
        RestartSec = 1;
      };
      Install = {
        WantedBy = [ "hyprland-session.target" ];
      };
    };

    activitywatch-watcher-aw-watcher-window-wayland = {
      Unit.ConditionEnvironment = "HYPRLAND_INSTANCE_SIGNATURE";
    };
  };

  # Home Manager version
  home = {
    # This is required because we are using the unstable version of Home Manager
    # with a stable Nixpkgs release, which is intentional.
    enableNixpkgsReleaseCheck = false;
    stateVersion = "24.11";

    # User information
    username = "lf";
    homeDirectory = "/home/lf";

    packages = [
      pkgs.home-manager
      pkgs.tree-sitter
      (pkgs.writeShellApplication {
        name = "ns";
        runtimeInputs = with pkgs; [
          fzf
          nix-search-tv
        ];
        text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
        excludeShellChecks = [ "SC2016" ];
      })
      pkgs.treefmt
      pkgs.spotify-player
      pythonEnv312
      customWaybar
      pkgs.blender # 3D creation suite
      pkgs.fpp
      pkgs.igrep # Improved grep with context and file filtering
      # pkgs.base16-shell-preview # Set of shell scripts to change terminal colors using
      # pkgs.base16-schemes # Collection of base16 color schemes
      pkgs.manix
      pkgs.rmpc
      pkgs.rtaudio # Real-time audio I/O library
      pkgs.erdtree # Visualize directory structure as a tree
      pkgs.cmake
      pkgs.meld
      pkgs.normcap
      pkgs.repgrep # A more powerful ripgrep with additional features
      pkgs.ripgrep-all
      pkgs.alejandra
      pkgs.pre-commit
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
      pkgs.pnpm # npm package manager
      pkgs.git-filter-repo
      pkgs.sof-tools
      pkgs.faiss # Command line tool for interacting with Generative AI models
      # (pkgs.callPackage ./ipython-ai.nix { inherit pkgs; }).out

      pkgs.dosbox-staging

      pkgs.dosbox-x

      pkgs.google-chrome

      # pkgs.antigravity-fhs

      tclint-dummy
    ];

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

      # Declaratively load Hyprland plugins as a workaround for the NixOS module bug
      # ".config/hypr/plugins-load.conf" = {
      #   text = ''
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
      linkMcpConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        set -e
        # Ensure the target directory exists
        mkdir -p "$HOME/.gemini"
        # Create the symlink, overwriting if it already exists
        ln -sf "$HOME/.config/mcp/mcp.json" "$HOME/.gemini/settings.json"
      '';
    };
  };

  fonts.fontconfig.enable = true;

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/markdown" = "gedit.desktop";
        "text/plain" = "code.desktop";
        "text/x-csv" = "code.desktop";
        "text/x-log" = "code.desktop";
        "text/x-patch" = "code.desktop";
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
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
      defaultApplicationPackages = [
        pkgs.gnome-text-editor
        pkgs.loupe
        pkgs.totem
        pkgs.vscode-fhs
      ];
    };
    userDirs = {
      enable = true;
      createDirectories = true;
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
        default = [
          "hyprland"
          "gtk"
        ];
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
      ghostty.enable = false;
      bat.enable = false;
      tmux.enable = false;
      neovim = {
        enable = false;
        # plugin = "base16-nvim";
        transparentBackground = {
          main = true;
          numberLine = true;
          signColumn = true;
        };
      };
      starship.enable = false;
      wofi.enable = false;
      fzf.enable = false;
      hyprland.enable = false;
      vscode.enable = false;
      kitty.enable = true;
    };
    base16Scheme = ../assets/base16_themes/catppuccin-macchiato.yaml;
    image = ../assets/wallpapers/astronaut_jellyfish.jpg; # ../../assets/base16_themes/cupcake.yaml;

    targets.qt.platform = lib.mkForce "qtct";
    polarity = "dark";
    targets.font-packages.enable = true;

    icons = {
      enable = true;
      package = pkgs.juno-theme;
      dark = "Juno-ocean";
      light = "Juno-mirage";
    };

    # rose-pine-cursor , bibata-cursors, phinger-cursors-dark
    cursor = {
      name = "Rose Pine";
      size = 40;
      package = pkgs.rose-pine-cursor;
    };

    opacity = {
      applications = 1.5;
      desktop = 1.5;
      popups = 0.8;
      terminal = 1.0;
    };

    fonts = {
      sansSerif = {
        # package = pkgs.aleo-fonts;
        # name = "Aleo";
        package = pkgs.nerd-fonts.fantasque-sans-mono;
        name = "Fantasque";
      };

      serif = {
        # package = pkgs.noto-fonts-cjk-sans;
        # name = "Noto Sans CJK JP";
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };

      monospace = {
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF Bold";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 10;
        desktop = 12;
        popups = 14;
        terminal = 14;
      };
    };
  };
}
