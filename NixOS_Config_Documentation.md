# NixOS Configuration Documentation

This document provides a comprehensive overview of the NixOS configuration files in this repository.

## Directory Structure

The following is a tree view of the repository's structure:
```
.
├── README.md
├── flake.nix
├── flake.lock
├── cache.nix
├── keys.txt
├── test.nix
├── treefmt.nix
├── .editorconfig
├── .pre-commit-config.yaml
├── assets
│   ├── .zshrc
│   ├── fastfetch
│   ├── gtk-3.0
│   ├── Thunar
│   └── xfce4
├── hosts
│   ├── default
│   ├── lf-nix
│   └── viech
├── modules
└── pkgs
    └── nvim
        ├── lua
        │   ├── config
        │   └── plugins
        └── default.nix
```

## File Contents

This section contains the content of each configuration file.

### /home/lf/nix/flake.nix
```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    #
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # stylix.url = "github:nix-community/stylix/release-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:aylur/ags/v1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-mineral = {
      url = "github:cynicsketch/nix-mineral"; # Refers to the main branch and is updated to the latest commit when you use "nix flake update"
      # url = "github:cynicsketch/nix-mineral/v0.1.6-alpha" # Refers to a specific tag and follows that tag until you change it
      # url = "github:cynicsketch/nix-mineral/cfaf4cf15c7e6dc7f882c471056b57ea9ea0ee61" # Refers to a specific commit and follows that until you change it
      flake = false;
    };
    disko.url = "github:nix-community/disko";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    sops-nix.url = "github:Mic92/sops-nix";
    flake-utils.url = "github:numtide/flake-utils";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable, # Fixed missing comma
    home-manager,
    ags,
    disko,
    sops-nix,
    nur,
    ...
  }: let
    # nur-no-pkgs = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/main.tar.gz") {};
    # nur.modules.nixos.default;
    # nur.legacyPackages."${system}".repos.iopq.modules.xraya;
    # Function to generate a NixOS system configuration
    # --- Old approach (commented out) ---
    # pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    mkNixosSystem = {
      system,
      host,
      username,
    }:
      nixpkgs.lib.nixosSystem {
        # --- Old specialArgs (commented out) ---
        # specialArgs = {inherit system inputs username host pkgs-unstable;};
        # --- New specialArgs ---
        # pkgs-unstable is no longer needed as it will be part of the main `pkgs` via the overlay.
        specialArgs = {inherit system inputs username host;};

        modules = [
          # --- New overlay approach ---
          # This module adds an overlay to the main `pkgs` set for this system.
          # Unstable packages will be accessible via `pkgs.unstable`.
          {
            nixpkgs.overlays = [
              (final: prev: {
                unstable = import nixpkgs-unstable {
                  system = prev.system;
                  config.allowUnfree = true;
                };
              })
            ];
          }

          disko.nixosModules.default
          ./hosts/${host}/config.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.${username} = {
              imports = [./pkgs/home.nix];
            };
            # --- Old extraSpecialArgs for home-manager (commented out) ---
            # home-manager.extraSpecialArgs = {inherit inputs username system pkgs-unstable;};
            # --- New extraSpecialArgs for home-manager ---
            # The main `pkgs` (which now includes the unstable overlay) is passed automatically.
            home-manager.extraSpecialArgs = {inherit inputs username system;};
          }
        ];
      };
  in {
    nixosConfigurations = {
      "lf-nix" = mkNixosSystem {
        system = "x86_64-linux";
        host = "lf-nix";
        username = "lf";
      };

      "viech" = mkNixosSystem {
        system = "x86_64-linux";
        host = "viech";
        username = "lf";
      };
    };
    # imports = lib.attrValues nur-no-pkgs.repos.moredhel.hmModules.rawModules;

    services.unison = {
      enable = true;
      profiles = {
        org = {
          src = "/home/moredhel/org";
          dest = "/home/moredhel/org.backup";
          extraArgs = "-batch -watch -ui text -repeat 60 -fat";
        };
      };
    };
  };
}
```


### /home/lf/nix/hosts/lf-nix/packages-fonts.nix
```nix
{
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}: let
  r-with-packages = pkgs.rWrapper.override {
    packages = with pkgs.rPackages; [
      IRkernel
    ];
  };
in {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    (with pkgs; [
      # System Packages
      # home-manager

      isd # interactively interact with systemd
      erdtree # You can think of erdtree as a little bit of du, tree, find, wc and ls.
      baobab
      btrfs-progs
      clang

      cpufrequtils
      duf # Utility For Viewing Disk Usage In Terminal
      findutils
      ffmpeg
      gsettings-qt
      git
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
      inputs.ags.packages.${pkgs.system}.default
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
    ])
    ++ (with pkgs.unstable; [
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

      gemini-cli
      bc
      curl
      glib #for gsettings to work
      sof-firmware
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
    ])
    ++ [
      #   python-packages # Add the python environment
      r-with-packages # Add the R environment
    ];

  programs = {
    hyprland = {
      enable = true;
      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
      withUWSM = true;
    };

    waybar.enable = true;
    hyprlock.enable = true;
    firefox.enable = true;
    nm-applet.indicator = true;
    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      exo
      mousepad
      thunar-archive-plugin
      thunar-volman
      tumbler
      #      thunar-vcs-plugin
      thunar-media-tags-plugin
    ];

    virt-manager.enable = false;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = false;
    };

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
```


### /home/lf/nix/pkgs/home.nix
```nix
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
    ./fzf.nix
    ./git.nix
    ./lsd.nix
    ./nvim
    ./starship.nix
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
      unstable.home-manager
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
```







### /home/lf/nix/pkgs/nvim/default.nix
```nix
{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;

    plugins = with pkgs.vimPlugins; [
      # Plugin Manager
      lazy-nvim
      # Base Distro
      LazyVim

      #   # Coding
      #   mini-pairs
      #   ts-comments-nvim
      #   mini-ai
      #   lazydev-nvim

      #   # Blink
      #   blink-cmp
      #   friendly-snippets

      #   # Editor
      #   neo-tree-nvim
      #   grug-far-nvim
      #   flash-nvim
      #   which-key-nvim
      #   gitsigns-nvim
      #   trouble-nvim
      #   todo-comments-nvim

      #   # Fzf
      #   fzf-lua

      #   # Formatting
      #   conform-nvim

      #   # Linting
      #   nvim-lint

      #   # LSP
      #   nvim-lspconfig

      #   # TreeSitter
      #   nvim-treesitter.withAllGrammars
      #   nvim-treesitter-textobjects
      #   nvim-ts-autotag

      #   # UI
      #   bufferline-nvim
      #   lualine-nvim
      #   noice-nvim
      #   mini-icons
      #   nui-nvim

      #   # Util
      #   snacks-nvim
      #   persistence-nvim
      #   plenary-nvim

      #   # Mini-comment Extra
      #   mini-comment
      #   nvim-ts-context-commentstring

      #   # Mini-surround Extra
      #   mini-surround

      #   # DAP Core Extra
      #   nvim-dap
      #   nvim-dap-ui
      #   nvim-dap-virtual-text
      #   nvim-nio

      #   # DAP Neovim Lua Adapter Extra
      #   # one-small-step-for-vimkind

      #   # Aerial Extra
      #   aerial-nvim

      #   # Illuminate Extra
      #   vim-illuminate

      #   # Inc-rename Extra
      #   inc-rename-nvim

      #   # Leap Extra
      #   flit-nvim
      #   leap-nvim
      #   vim-repeat

      #   # Mini-diff Extra
      #   mini-diff

      #   # Navic Extra
      #   nvim-navic

      #   # Overseer Extra
      #   overseer-nvim

      #   # Clangd Extra
      #   clangd_extensions-nvim

      #   # Helm Extra
      #   vim-helm

      #   # JSON/YAML Extra
      #   SchemaStore-nvim # load known formats for json and yaml

      #   # Markdown Extra
      #   markdown-preview-nvim
      #   render-markdown-nvim

      #   # Python Extra
      #   neotest-python
      #   nvim-dap-python

      #   # Rust Extra
      #   crates-nvim
      #   rustaceanvim

      #   # Terraform Extra
      #   # telescope-terraform-doc-nvim
      #   # telescope-terraform-nvim

      #   # LSP Extra
      #   neoconf-nvim
      #   none-ls-nvim

      #   # Test Extra
      #   neotest

      #   # Edgy Extra
      #   edgy-nvim

      #   # Mini-animate Extra
      #   mini-animate

      #   # Treesitter-context Extra
      #   nvim-treesitter-context

      #   # Project Extra
      #   project-nvim

      #   # Startuptime
      #   vim-startuptime

      #   nvim-web-devicons
      #   nvim-notify
      #   nvim-lsp-notify

      #   # smart typing
      #   guess-indent-nvim

      #   # LSP
      #   nvim-lightbulb # lightbulb for quick actions
      #   nvim-code-action-menu # code action menu
      # ];

      # extraPackages = with pkgs; [
      #   gcc # needed for nvim-treesitter

      #   # HTML, CSS, JSON
      #   vscode-langservers-extracted

      #   # LazyVim defaults
      #   stylua
      #   shfmt

      #   # Markdown extra
      #   markdownlint-cli2
      #   marksman

      #   # JSON and YAML extras
      #   nodePackages.yaml-language-server

      #   # Custom
      #   editorconfig-checker
      #   shellcheck
    ];

    extraLuaConfig = ''
            vim.g.mapleader = " "
            vim.g.maplocalleader = "\\"
            require("lazy").setup({
        spec = {
          -- add LazyVim and import its plugins
          { "LazyVim/LazyVim", import = "lazyvim.plugins" },
          -- import/override with your plugins
          { import = "plugins" },
        },
        defaults = {
          -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
          -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
          lazy = false,
          -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
          -- have outdated releases, which may break your Neovim install.
          version = false, -- always use the latest git commit
          -- version = "*", -- try installing the latest stable version for plugins that support semver
        },
        install = { colorscheme = { "catppuccin" } },
        checker = {
          enabled = true, -- check for plugin updates periodically
          notify = false, -- notify on update
        }, -- automatically check for plugin updates
        performance = {
          rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
              "gzip",
              -- "matchit",
              -- "matchparen",
              -- "netrwPlugin",
              "tarPlugin",
              "tohtml",
              "tutor",
              "zipPlugin",
            },
          },
        },
      })
            --[[
            require("lazy").setup({
              spec = {
                { "LazyVim/LazyVim", import = "lazyvim.plugins" },
                -- import any extras modules here
                { import = "lazyvim.plugins.extras.coding.mini-comment" },
                { import = "lazyvim.plugins.extras.coding.mini-surround" },
                { import = "lazyvim.plugins.extras.dap.core" },
                { import = "lazyvim.plugins.extras.dap.nlua" },
                -- We need to use Edgy before Aerial
                { import = "lazyvim.plugins.extras.ui.edgy" },
                { import = "lazyvim.plugins.extras.editor.aerial" },
                { import = "lazyvim.plugins.extras.editor.illuminate" },
                { import = "lazyvim.plugins.extras.editor.inc-rename" },
                { import = "lazyvim.plugins.extras.editor.leap" },
                { import = "lazyvim.plugins.extras.editor.mini-diff" },
                { import = "lazyvim.plugins.extras.editor.navic" },
                { import = "lazyvim.plugins.extras.editor.overseer" },
                { import = "lazyvim.plugins.extras.lang.clangd" },
                { import = "lazyvim.plugins.extras.lang.docker" },
                { import = "lazyvim.plugins.extras.lang.helm" },
                { import = "lazyvim.plugins.extras.lang.json" },
                { import = "lazyvim.plugins.extras.lang.markdown" },
                { import = "lazyvim.plugins.extras.lang.nushell" },
                { import = "lazyvim.plugins.extras.lang.python" },
                { import = "lazyvim.plugins.extras.lang.rust" },
                { import = "lazyvim.plugins.extras.lang.terraform" },
                { import = "lazyvim.plugins.extras.lang.yaml" },
                { import = "lazyvim.plugins.extras.lsp.neoconf" },
                { import = "lazyvim.plugins.extras.lsp.none-ls" },
                { import = "lazyvim.plugins.extras.test.core" },
                { import = "lazyvim.plugins.extras.ui.mini-animate" },
                { import = "lazyvim.plugins.extras.ui.treesitter-context" },
                { import = "lazyvim.plugins.extras.util.project" },
                { import = "lazyvim.plugins.extras.util.startuptime" },
                -- import/override with your plugins
                { import = "plugins" },
              },
              defaults = {
                -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
                -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
                lazy = false,
                -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
                -- have outdated releases, which may break your Neovim install.
                version = false, -- always use the latest git commit
                -- version = "*", -- try installing the latest stable version for plugins that support semver
              },
              performance = {
                -- Used for NixOS
                reset_packpath = false,
                rtp = {
                  reset = false,
                  -- disable some rtp plugins
                  disabled_plugins = {
                    "gzip",
                    -- "matchit",
                    -- "matchparen",
                    -- "netrwPlugin",
                    "tarPlugin",
                    "tohtml",
                    "tutor",
                    "zipPlugin",
                  },
                }
              },
              dev = {
                path = "/etc/profiles/per-user/lf/etc/xdg/nvim/pack/myNeovimPackages/start",
                patterns = {""},
              },
              install = {
                missing = false,
              },
            })
            --]]
    '';
  };

  xdg.configFile."nvim/lua" = {
    recursive = true;
    source = ./lua; # Or the path to your lua config
  };
}
```


### /home/lf/nix/pkgs/starship.nix
```nix
{lib, ...}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    settings = let
     	darkgray = "242";
      	rosewater = "#f5e0dc";
	flamingo = "#f2cdcd";
	pink = "#f5c2e7";
	mauve = "#cba6f7";
	red = "#f38ba8";
	maroon = "#eba0ac";
	peach = "#fab387";
	yellow = "#f9e2af";
	green = "#a6e3a1";
	teal = "#94e2d5";
	sky = "#89dceb";
	sapphire = "#74c7ec";
	blue = "#89b4fa";
	lavender = "#b4befe";
	text = "#cdd6f4";
	subtext1 = "#bac2de";
	subtext0 = "#a6adc8";
	overlay2 = "#9399b2";
	overlay1 = "#7f849c";
	overlay0 = "#6c7086";
	surface2 = "#585b70";
	surface1 = "#45475a";
	surface0 = "#313244";
	base = "#1e1e2e";
	mantle = "#181825";
	crust = "#11111b";
    in {
      format = lib.concatStrings [
        "$username"
        "($hostname )"
        "$directory"
        "($git_branch )"
        "($git_state )"
        "($git_status )"
        "($git_metrics )"
        "($cmd_duration )"
        "$line_break"
        "($python )"
        "($nix_shell )"
        "($direnv )"
        "$character"
      ];
      
      directory = {
       # style = "blue";
       # read_only = " !";
        style = "bold ${peach}";
	truncate_to_repo = true;
	truncation_length = 0;
	truncation_symbol = "repo: ";
	read_only = "\uf456";
#	read_only = "\";
      };

      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vicmd_symbol = "[❮](green)";
      };

      git_branch = {
        format = "[$branch]($style)";
        # style = darkgray;
        symbol = " ";
	style = "bold ${green}";
      };

      git_status = {
        ahead = "";
	behind = "";
	deleted = "x";
	diverged = "";
	style = "text";
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted )](218)($ahead_behind$stashed)]($style)";
        conflicted = "​";
        untracked = "​";
        modified = "​";
        staged = "​";
        renamed = "​";
        stashed = "≡";
      };

      git_state = {
        format = "[$state( $progress_current/$progress_total)]($style)";
        style = "dimmed";
        rebase = "rebase";
        merge = "merge";
        revert = "revert";
        cherry_pick = "pick";
        bisect = "bisect";
        am = "am";
        am_or_rebase = "am/rebase";
      };

      sudo = {
	  disabled = false;
      };	

      git_metrics = {
      	disabled = false;
	      added_style = "bold ${green}";
	      format = "[+$added]($added_style)/[-$deleted]($deleted_style)";
      };


      cmd_duration = {
       # format = "[$duration]($style)";
#        style = "yellow";
        disabled = false;
	style="bold ${flamingo}";
	format = "took [$duration]($style)";
	show_milliseconds = true;
	show_notifications = true;
	min_time_to_notify = 30000;
      };

      python = {
        format = "[$virtualenv]($style)";
        style = darkgray;
      };

      nix_shell = {
        format = "❄️";
        style = darkgray;
        heuristic = true;
#        format = "via [$symbol(($name))]($style)";
      };

      direnv = {
        format = "[($loaded/$allowed)]($style)";
        style = darkgray;
        disabled = false;
        loaded_msg = "";
        allowed_msg = "";
      };

      username = {
				format = " [$user]($style)";
				show_always = true;
				style_root = "bold ${red}";
				style_user = "bold ${mauve}";
      };

      hostname = {
        format = "@[$hostname]($style) in";
        disabled = false;
	ssh_only = false;
	style = "bold ${maroon}";
	ssh_symbol = " ";
	};
 
	battery = {
  		display = [
		    { # 0% to 15%
		      disabled = false;
		      style = "bold ${red}";
		      threshold = 15;
		    }
		    { # 15% to 50%
		      disabled = true;
		      style = "bold ${peach}";
		      threshold = 50;
		    }
		    { # 50% to 90%
		      disabled = true;
		      style = "bold ${green}";
		      threshold = 90;
		    }
		  ];
	};
	
	status = {
	disabled = false;
	format = "[\[$symbol$status_common_meaning$status_signal_name$status_maybe_int\ = {($style)";
	map_symbol = true;
	pipestatus = true;
	symbol = "✖";
	not_executable_symbol = "";
	not_found_symbol = "";
	sigint_symbol = "󰟾";
	signal_symbol = "";
	};
	
	os = {
	disabled = false;
	format = " [$symbol]($style)";
	style = "bold ${mauve}";
	};
#	character = {
#	error_symbol = "";
#	success_symbol = "❯(bold green)";
#	};
	# SYMBOLS
	git_commit = {
	tag_symbol = "  ";
	};
	golang = {
	symbol = " ";
	};
	guix_shell = {
	symbol = " ";
	};
	haskell = {
	symbol = " ";
	};
	haxe = {
	symbol = " ";
	};
	hg_branch = {
	symbol = " ";
	};
	java = {
	symbol = " ";
	};
	julia = {
	symbol = " ";
	};
	kotlin = {
	symbol = " ";
	};
	lua = {
	symbol = " ";
	};
	memory_usage = {
	symbol = "󰍛 ";
	};
	meson = {
	symbol = "󰔷 ";
	};
	nim = {
	symbol = "󰆥 ";
	};
	nodejs = {
	symbol = " ";
	};
	ocaml = {
	symbol = " ";
	};
	os.symbols = {
	Alpaquita = " ";
	Alpine = " ";
	AlmaLinux = " ";
	Amazon = " ";
	Android = " ";
	Arch = " ";
	Artix = " ";
	CentOS = " ";
	Debian = " ";
	DragonFly = " ";
	Emscripten = " ";
	EndeavourOS = " ";
	Fedora = " ";
	FreeBSD = " ";
	Garuda = "󰛓 ";
	Gentoo = " ";
	HardenedBSD = "󰞌 ";
	Illumos = "󰈸 ";
	Kali = " ";
	Linux = " ";
	Mabox = " ";
	Macos = " ";
	Manjaro = " ";
	Mariner = " ";
	MidnightBSD = " ";
	Mint = " ";
	NetBSD = " ";
	NixOS = " ";
	OpenBSD = "󰈺 ";
	openSUSE = " ";
	OracleLinux = "󰌷 ";
	Pop = " ";
	Raspbian = " ";
	Redhat = " ";
	RedHatEnterprise = " ";
	RockyLinux = " ";
	Redox = "󰀘 ";
	Solus = "󰠳 ";
	SUSE = " ";
	Ubuntu = " ";
	Unknown = " ";
	Void = " ";
	Windows = "󰍲 ";
	};

	package = {
	symbol = "󰏗 ";
};
	perl = {
	symbol = " ";
};
	php = {
	symbol = " ";
};
	pijul_channel = {
	symbol = " ";
};
	python = {
	symbol = " ";
};
	rlang = {
	symbol = "󰟔 ";
};
	ruby = {
	symbol = " ";
};
	rust = {
	symbol = "󱘗 ";
};
	scala = {
	symbol = " ";
};
	swift = {
	symbol = " ";
};
	zig = {
	symbol = " ";
};
	gradle = {
	symbol = " "	;
	};
      };
    };
  }
```


### /home/lf/nix/hosts/lf-nix/config.nix
```nix
{
  # config,
  pkgs,
  host,
  username,
  options,
  # lib,
  inputs,
  # system,
  ...
}: let
  inherit (import ./variables.nix) keyboardLayout;
in {
  imports = [
    ./hardware.nix
    ./users.nix
    ./packages-fonts.nix
    ../../modules/intel-drivers.nix
    ../../modules/vm-guest-services.nix
    ../../modules/local-hardware-clock.nix
    "${inputs.nix-mineral}/nix-mineral.nix"
  ];

  # BOOT related stuff
  boot = {
    #kernelPackages = pkgs.linuxPackages_zen; # Performance geared
    kernelPackages = pkgs.linuxPackages_latest; # Best Balance
    #kernelPackages = pkgs.linuxPackages_lts # Most Stable

    kernelParams = [
      "systemd.mask=systemd-vconsole-setup.service"
      "systemd.mask=dev-tpmrm0.device" #this is to mask that stupid 1.5 mins systemd bug
      "nowatchdog"
      "modprobe.blacklist=sp5100_tco" #watchdog for AMD
      "modprobe.blacklist=iTCO_wdt" #watchdog for Intel
    ];

    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "uas" "usbhid" "sd_mod"];
      kernelModules = [];
    };

    # Needed For Some Steam Games
    #kernel.sysctl = {
    #  "vm.max_map_count" = 2147483642;
    #};

    ## BOOT LOADERS: NOTE USE ONLY 1. either systemd or grub
    # Bootloader SystemD
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 5;

    # Make /tmp a tmpfs
    tmp = {
      useTmpfs = false;
      tmpfsSize = "30%";
    };

    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };

    plymouth.enable = true;
  };

  vm.guest-services.enable = false;
  local.hardware-clock.enable = false;

  # networking
  networking = {
    networkmanager.enable = true;
    hostName = "${host}";
    timeServers =
      options.networking.timeServers.default
      ++ [
        "pool.ntp.org"
      ];
  };

  # Set your time zone.
  # services.automatic-timezoned.enable = true; #based on IP location

  #https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  time.timeZone = "Asia/Jerusalem"; # Set local timezone

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "he_IL.UTF-8";
    LC_IDENTIFICATION = "he_IL.UTF-8";
    LC_MEASUREMENT = "he_IL.UTF-8";
    LC_MONETARY = "he_IL.UTF-8";
    LC_NAME = "he_IL.UTF-8";
    LC_NUMERIC = "he_IL.UTF-8";
    LC_PAPER = "he_IL.UTF-8";
    LC_TELEPHONE = "he_IL.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Services to start
  services = {
    xserver = {
      enable = false;
      xkb = {
        layout = "${keyboardLayout}";
        variant = "";
      };
    };

    greetd = {
      enable = true;
      vt = 1;
      settings = {
        default_session = {
          user = username;
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet
          --time --cmd Hyprland";
        };
      };
    };

    smartd = {
      enable = true;
      autodetect = true;
    };

    gvfs.enable = true;
    tumbler.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      extraConfig = {
        pipewire = {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.allowed-rates" = [
              44100
              48000
              88200
              96000
              176400
              192000
              352800
              384000
              705600
              768000
            ];
            "default.clock.quantum" = 1024;
            "default.clock.min-quantum" = 1024;
            "default.clock.max-quantum" = 1024;
          };
        };
      };
      wireplumber.extraConfig = {
        "51-disable-suspend" = {
          "monitor.session.rule.suspend-node.disabled" = true;
        };
      };
    };

    #pulseaudio.enable = false; #unstable
    udev.enable = true;
    envfs.enable = true;
    dbus.enable = true;

    fstrim = {
      enable = true;
      interval = "weekly";
    };

    libinput.enable = true;

    rpcbind.enable = false;
    nfs.server.enable = false;

    openssh.enable = true;
    flatpak.enable = false;

    blueman.enable = true;

    #hardware.openrgb.enable = true;
    #hardware.openrgb.motherboard = "amd";

    fwupd.enable = false;
    upower.enable = true;
    gnome.gnome-keyring.enable = true;

    #printing = {
    #  enable = false;
    #  drivers = [
    # pkgs.hplipWithPlugin
    #  ];
    #};

    #avahi = {
    #  enable = true;
    #  nssmdns4 = true;
    #  openFirewall = true;
    #};

    #ipp-usb.enable = true;

    syncthing = {
      enable = true;
      user = "${username}";
      dataDir = "/home/${username}";
      configDir = "/home/${username}/.config/syncthing";
    };
  };

  systemd.services = {
    #    # Service to clone your private GitLab repository
    #    initial-clone-gitlab = {
    #      description = "Initial clone of private GitLab repository";
    #      wants = [ "network-online.target" ];
    #      after = [ "network-online.target" ];
    #      # ADD THIS BLOCK: Make commands available to the script
    #      path = [
    #        pkgs.gitFull      # Provides 'git'
    #        pkgs.util-linux   # Provides 'runuser'
    #      ];
    #      script = ''
    #        if [ ! -d "/home/${username}/git/laurent.flaster" ]; then
    #          mkdir -p /home/${username}/git
    #          chown ${username} /home/${username}/git
    #          runuser -u ${username} -- git clone https://git.infinitylabs.co.il/ilrd/ramat-gan/ai3/laurent.flaster.git /home/${username}/git/laurent.flaster
    #        fi
    #      '';
    #      serviceConfig = {
    #        Type = "oneshot";
    #        RemainAfterExit = true;
    #        User = "root";
    #      };
    #    };

    # Service to clone your Obsidian Brain repository
    initial-clone-brain = {
      description = "Initial clone of Obsidian Brain repository";
      wants = ["network-online.target"];
      after = ["network-online.target"];
      # ADD THIS BLOCK: Make commands available to the script
      path = [
        pkgs.gitFull # Provides 'git'
        pkgs.util-linux # Provides 'runuser'
      ];
      script = ''
        if [ ! -d "/home/${username}/Obsidian/brain" ]; then
          mkdir -p /home/${username}/Obsidian
          chown ${username} /home/${username}/Obsidian
          runuser -u ${username} -- git clone https://github.com/batou069/brain.git /home/${username}/Obsidian/brain
        fi
      '';
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        User = "root";
        PrivateTmp = false;
        ProtectHome = false;
      };
    };
  };
  # zram
  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 30;
    swapDevices = 1;
    algorithm = "zstd";
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
  };

  #hardware.sane = {
  #  enable = true;
  #  extraBackends = [ pkgs.sane-airscan ];
  #  disabledDefaultBackends = [ "escl" ];
  #};

  # Extra Logitech Support
  hardware = {
    firmware = [ pkgs.sof-firmware ];
    logitech.wireless.enable = true;
    logitech.wireless.enableGraphical = true;
  };

  #  hardware.graphics = {
  #    enable = true;
  #  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Bluetooth
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
  };

  # Security / Polkit
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    polkit.extraConfig = ''
       polkit.addRule(function(action, subject) {
         if (
           subject.isInGroup("users")
             && (
               action.id == "org.freedesktop.login1.reboot" ||
               action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
               action.id == "org.freedesktop.login1.power-off" ||
               action.id == "org.freedesktop.login1.power-off-multiple-sessions"
             )
           )
         {
           return polkit.Result.YES;
         }
      })
    '';
  };
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  # Cachix, Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  };

  # Virtualization / Containers
  virtualisation.libvirtd.enable = false;
  virtualisation.podman = {
    enable = false;
    dockerCompat = false;
    defaultNetwork.settings.dns_enabled = false;
  };

  virtualisation.docker = {
    enable = true;
    rootless.enable = false;
    autoPrune.enable = true;
    enableOnBoot = true;
  };

  console.keyMap = "${keyboardLayout}";

  # For Electron apps to use wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Enable Wayland Ozone platform for Electron apps
    ELECTRON_OZONE_PLATFORM_HINT = "wayland"; # Or "AUTO"
    # You might also try:
    # ELECTRON_ENABLE_WAYLAND = "1";
  };

  programs = {
    # Zsh configuration
    zsh = {
      enable = true;
      enableCompletion = true;
      ohMyZsh.enable = false;

      autosuggestions.enable = false;
      syntaxHighlighting.enable = false;
      promptInit = "";
    };
  };

  # nixpkgs.config.packageOverrides = pkgs: {
  #   nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/main.tar.gz") {
  #     inherit pkgs;
  #   };
  # };

  environment.variables.FZF_SHELL_DIR = "${pkgs.fzf}/share/fzf";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
```


### /home/lf/nix/hosts/viech/packages-fonts.nix
```nix
{
  pkgs,
  inputs,
  ...
}: let
  r-with-packages = pkgs.rWrapper.override {
    packages = with pkgs.rPackages; [
      IRkernel
    ];
  };

  zen-browser = pkgs.stdenv.mkDerivation rec {
    pname = "zen-browser";
    version = "1.13.2b";

    src = pkgs.fetchurl {
      url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-x86_64.tar.xz";
      sha256 = "sha256-GOD/qZsdCIgldRsOR/Hxo+mB0K7iutKt9XYUj9+6Tgc=";
    };

    nativeBuildInputs = with pkgs; [autoPatchelfHook makeWrapper];
    buildInputs = with pkgs; [
      libGL
      nss
      nspr
      fontconfig
      openssl
      pipewire
      libpulseaudio
      alsa-lib
      gtk3
      cairo
      gdk-pixbuf
      glib
      dbus
      librsvg
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];

    sourceRoot = "zen";

    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin $out/share/applications $out/share/pixmaps
      cp -r . $out/
      makeWrapper $out/zen-bin $out/bin/zen \
        --set LD_LIBRARY_PATH ${pkgs.lib.makeLibraryPath buildInputs} \
        --set XDG_CURRENT_DESKTOP Hyprland \
        --set XDG_SESSION_TYPE wayland \
        --set MOZ_ENABLE_WAYLAND 1
      # Copy icon to a standard location
      cp $out/zen.png $out/share/pixmaps/zen-browser.png || echo "Warning: zen.png not found in source"
      # Install desktop file
      cp ${desktopItem}/share/applications/zen-browser.desktop $out/share/applications/zen-browser.desktop
      runHook postInstall
    '';

    desktopItem = pkgs.makeDesktopItem {
      name = "zen-browser";
      exec = "zen"; # Use executable name, resolved via PATH
      icon = "zen-browser"; # Use icon name, registered in pixmaps
      comment = "A customizable, user-friendly web browser based on Firefox";
      desktopName = "Zen Browser";
      categories = ["Network" "WebBrowser"];
    };
  };

  normcap-wrapped = pkgs.writeShellScriptBin "normcap" ''
    #!${pkgs.stdenv.shell}
    export QT_QPA_PLATFORM=wayland
    export QT_QPA_PLATFORMTHEME=qt6ct
    export XDG_CURRENT_DESKTOP=Hyprland
    # export QT_LOGGING_RULES=qt6ct.debug=true
    exec ${pkgs.normcap}/bin/normcap "$@"
  '';
in {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    (with pkgs; [
      # System Packages
      # home-manager
      bc
      isd # interactively interact with systemd
      erdtree # You can think of erdtree as a little bit of du, tree, find, wc and ls.
      baobab
      btrfs-progs
      clang
      curl
      cpufrequtils
      duf # Utility For Viewing Disk Usage In Terminal
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
      wget
      xdg-user-dirs
      xdg-utils
      sof-firmware # added due to sound issues, missing microphone
      fastfetch
      (mpv.override {scripts = [mpvScripts.mpris];}) # with tray
      # ranger

      # Hyprland Stuff
      # Build AGS v1 from source
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
      ijq
      manix
      mediainfo

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
      nix-search-tv
      gemini-cli
      claude-code
      # --- MY PACKAGES ---
      # Your requested packages
      lutris
      heroic
      bottles
      stow # Manage dotfiles symlinking
      gnome-font-viewer # self explanatory
      fx
      yq-go # Note: The package is named yq-go
      figlet
      bitwarden-cli
      ghostty
      uv
      ruff
      tmux
      gedit
      normcap-wrapped
      bitwarden-desktop
      twingate
      vlc
      obsidian
      foot
      calibre
      # nyxt
      # qutebrowser
      neovide
      rstudioWrapper
      hyprls
      zen-browser
      lazygit
      lazycli
      lazydocker
      lazyjournal
      bitwarden-menu
      chromedriver
      google-chrome
      # FROM ZaneyOS
      appimage-run # Needed For AppImage Support
      hyprpicker # Color Picker
      lm_sensors # Used For Getting Hardware Temps
      lshw # Detailed Hardware Information
      ncdu # Disk Usage Analyzer With Ncurses Interface
      picard # For Changing Music Metadata & Getting Cover Art
      usbutils # Good Tools For USB Devices
      gcr
      # Dev Stuff
      nixd
    ])
    ++ [
      #   python-packages # Add the python environment
      r-with-packages # Add the R environment
    ];

  programs = {
    hyprland = {
      enable = true;
      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };

    #    git = {
    #      enable = true;
    #      package = pkgs.gitFull;
    #      config = {
    #        # Default user (GitHub)
    #        user = {
    #          name = "batou069";
    #          email = "laurentf84@gmail.com";
    #        };
    #
    #        # Set up the credential helper
    #        credential = {
    #          helper = "libsecret";
    #        };
    #
    #        # Automatically switch to GitLab user for specific directory
    #        "includeIf \"gitdir:~/git/\"" = {
    #          path = toString ./gitconfig-gitlab;
    #        };
    #      };
    #    };

    waybar.enable = true;
    hyprlock.enable = true;
    firefox.enable = true;
    nm-applet.indicator = true;
    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      exo
      mousepad
      thunar-archive-plugin
      thunar-volman
      tumbler
      #      thunar-vcs-plugin
      thunar-media-tags-plugin
    ];

    virt-manager.enable = false;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = false;
    };

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
```


### /home/lf/nix/hosts/viech/home.nix
```nix
{
  pkgs,
  username,
  ...
}: {
  # Home Manager version
  home.stateVersion = "24.11";

  # User information
  home.username = username;
  home.homeDirectory = "/home/${username}";

  imports = [
    ./home/cli.nix
    ./home/vscode.nix
    # ./home/firefox
  ];

  fonts.fontconfig.enable = true;

  # User-specific packages
  home.packages = with pkgs; [
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

    eza
    fd
    # ripgrep
    repgrep
    # ripgrep-all
    alejandra
    pre-commit
    kdePackages.okular
    vgrep # User-friendly pager for grep/git-grep/ripgrep
    xonsh # Python-ish, BASHwards-compatible shell
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
          seaborn
          python-dotenv
          regex
          tabulate
          ipykernel
          selenium
          beautifulsoup4
          pika
          pymongo
          lxml
          redis
          aiohttp
          networkx
          python-louvain
          neo4j
          mypy
          mypy-extensions
        ]
    ))
  ];

  home.sessionVariables = {
    P = "$HOME/git/py/";
    C = "$HOME/.config/";
    G = "$HOME/git/";
    R = "$HOME/repos/";
    O = "$HOME/Obsidian/";
    D = "$HOME/dotfiles/";
    N = "$HOME/NixOS-Hyprland/";
    TERM = "xterm-256color";
    VISUAL = "nvim";
    EDITOR = "nvim";
  };

  home.file.".pre-commit-config.yaml" = {
    source = ../../.pre-commit-config.yaml; # Path to the file in your dotfiles
    target = ".pre-commit-config.yaml";
  };

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
        # "image/heif" = "org.kde.gwenview.desktop";
        # "image/x-icns" = "loupe.desktop";
        # "inode/directory" = "org.kde.dolphin.desktop";
      };
    };
    userDirs = {
      enable = true;
      desktop = "$HOME/Desktop";
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      music = "$HOME/Music";
      pictures = "$HOME/Pictures";
      # publicShare = "$HOME/";
      # templates = "$HOME/";
      videos = "$HOME/Videos";
    };

    configFile = {
      "mimeapps.list".force = true;
    };
  };
}
```


### /home/lf/nix/hosts/viech/variables.nix
```nix
{
  # Hyprland Settings
  extraMonitorSettings = "";

  # Waybar Settings
  clock24h = true;

  # Program Options
  browser = "firefox"; # Set Default Browser (google-chrome-stable for google-chrome)
  terminal = "kitty"; # Set Default System Terminal
  keyboardLayout = "us";
}
```


### /home/lf/nix/pkgs/nvim/lua/plugins/changes.lua
```lua
local sql_ft = { "sql", "mysql", "plsql" }

return {
  -- SQL Plugins
  {
    "tpope/vim-dadbod",
    cmd = "DB",
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    dependencies = "tpope/vim-dadbod",
    keys = {
      { "<leader>D", "<cmd>DBUIToggle<CR>", desc = "Toggle DBUI" },
    },
    init = function()
      local data_path = vim.fn.stdpath("data")
      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.db_ui_save_location = data_path .. "/dadbod_ui"
      vim.g.db_ui_show_database_icon = true
      vim.g.db_ui_tmp_query_location = data_path .. "/dadbod_ui/tmp"
      vim.g.db_ui_use_nerd_fonts = true
      vim.g.db_ui_use_nvim_notify = true
      vim.g.db_ui_execute_on_save = false
    end,
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = "tpope/vim-dadbod",
    ft = sql_ft,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = sql_ft,
        callback = function()
          if LazyVim.has_extra("coding.nvim-cmp") then
            local cmp = require("cmp")
            local sources = vim.tbl_map(function(source)
              return { name = source.name }
            end, cmp.get_config().sources)
            table.insert(sources, { name = "vim-dadbod-completion" })
            cmp.setup.buffer({ sources = sources })
          end
        end,
      })
    end,
  },

  -- Debugging Plugins
  {
    "nvim-neotest/neotest-python",
  },
  {
    "mfussenegger/nvim-dap-python",
    keys = {
      { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
      { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
    },
    config = function()
      if vim.fn.has("win32") == 1 then
        require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe"))
      else
        require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/bin/python"))
      end
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {},
      },
    },
  },
  {
    "shunsambongi/neotest-testthat",
  },

  -- LSP & Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "R-nvim/cmp-r" },
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources or {}, {
        { name = "cmp_r" },
      }))
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "tsx", "ninja", "rst", "r", "rnoweb", "sql", "bash", "html",
        "javascript", "json", "lua", "markdown", "markdown_inline",
        "python", "query", "regex", "typescript", "vim", "yaml",
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = false,
      ensure_installed = {},
    },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = { settings = { logLevel = "error" } },
          keys = {
            { "<leader>co", LazyVim.lsp.action["source.organizeImports"], desc = "Organize Imports" },
          },
        },
        ruff_lsp = {
          keys = {
            { "<leader>co", LazyVim.lsp.action["source.organizeImports"], desc = "Organize Imports" },
          },
        },
        r_language_server = {
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern("DESCRIPTION", "NAMESPACE", ".Rbuildignore")(fname)
              or require("lspconfig.util").find_git_ancestor(fname)
              or vim.loop.os_homedir()
          end,
        },
        marksman = {},
      },
      setup = {
        ruff = function()
          LazyVim.lsp.on_attach(function(client, _)
            client.server_capabilities.hoverProvider = false
          end)
        end,
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      for _, ft in ipairs(sql_ft) do
        opts.linters_by_ft[ft] = opts.linters_by_ft[ft] or {}
        table.insert(opts.linters_by_ft[ft], "sqlfluff")
      end
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        ["markdown-toc"] = {
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find("<!%-%- toc %-%->") then
                return true
              end
            end
          end,
        },
        ["markdownlint-cli2"] = {
          condition = function(_, ctx)
            local diag = vim.tbl_filter(function(d)
              return d.source == "markdownlint"
            end, vim.diagnostic.get(ctx.buf))
            return #diag > 0
          end,
        },
        sqlfluff = {
          args = { "format", "--dialect=ansi", "-" },
        },
      },
      formatters_by_ft = {
        ["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
        ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
        sql_ft = { "sqlfluff" },
      },
    },
  },
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      sources = {
        default = { "dadbod" },
        providers = {
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        },
      },
    },
    dependencies = { "kristijanhusak/vim-dadbod-completion" },
  },
  { "R-nvim/cmp-r" },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "markdownlint-cli2", "markdown-toc", "sqlfluff" } },
  },
}
```


### /home/lf/nix/modules/intel-drivers.nix
```nix
{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.drivers.intel;
in {
  options.drivers.intel = {
    enable = mkEnableOption "Enable Intel Graphics Drivers";
  };

  config = mkIf cfg.enable {
    nixpkgs.config.packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
    };

    # OpenGL
    hardware.graphics = {
      extraPackages = with pkgs; [
        intel-media-driver
        libvdpau-va-gl
        libva
			  libva-utils
      ];
    };
	hardware.firmware = with pkgs; [
	  sof-firmware
	];
  };
}
```


### /home/lf/nix/pkgs/nvim/lua/plugins/lightbulb.lua
```lua
return {
  { "kosayoda/nvim-lightbulb", opts = { autocmd = { enabled = true } } }
}
```


### /home/lf/nix/cache.nix
```nix
{...}: {
  # NOTE: These caches are used on NixOS (nixos-rebuild) only, and not in
  # home-manager (which would only use the user's nix.conf).

  nix.settings.substituters = [
    "https://cachix.cachix.org"
    "https://fencer.cachix.org"
    "https://ghcide-nix.cachix.org/"
    "https://hercules-ci.cachix.org/"
    "https://mpickering.cachix.org/"
    "https://nix-community.cachix.org"
    "https://nix-linter.cachix.org"
    "https://nixfmt.cachix.org"
    "https://pre-commit-hooks.cachix.org"
    "https://static-haskell-nix.cachix.org"
    "https://iammrinal0.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
    "fencer.cachix.org-1:Uc3oXF1AHnhrc7kwEAY+NHNH7BvkngdBiFLHPDCUVwA="
    "ghcide-nix.cachix.org-1:ibAY5FD+XWLzbLr8fxK6n8fL9zZe7jS+gYeyxyWYK5c="
    "hercules-ci.cachix.org-1:ZZeDl9Va+xe9j+KqdzoBZMFJHVQ42Uu/c/1/KMC5Lw0="
    "mpickering.cachix.org-1:COxPsDJqqrggZgvKG6JeH9baHPue8/pcpYkmcBPUbeg="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "nix-linter.cachix.org-1:BdTne5LEHQfIoJh4RsoVdgvqfObpyHO5L0SCjXFShlE="
    "nixfmt.cachix.org-1:uyEQg16IhCFeDpFV07aL+Dbmh18XHVUqpkk/35WAgJI="
    "pre-commit-hooks.cachix.org-1:Pkk3Panw5AW24TOv6kz3PvLhlH8puAsJTBbOPmBo7Rc="
    "static-haskell-nix.cachix.org-1:Q17HawmAwaM1/BfIxaEDKAxwTOyRVhPG5Ji9K3+FvUU="
    "iammrinal0.cachix.org-1:uWCwkRYptDrFnr4qxYyYFJZb4+e/QebcODAe8Of/ngc="
  ];
}
```


### /home/lf/nix/pkgs/nvim/lua/plugins/bash.lua
```lua
return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        sh = { "shellcheck" },
      },
    }
  },
}
```


### /home/lf/nix/hosts/default/config.nix
```nix
# 💫 https://github.com/JaKooLit 💫 #
# Main default config


# NOTE!!! : Packages and Fonts are configured in packages-&-fonts.nix


{ config, pkgs, host, username, options, lib, inputs, system, ...}: let
  
  inherit (import ./variables.nix) keyboardLayout;
    
  in {
  imports = [
    ./hardware.nix
    ./users.nix
    ./packages-fonts.nix
    ../../modules/amd-drivers.nix
    ../../modules/nvidia-drivers.nix
    ../../modules/nvidia-prime-drivers.nix
    ../../modules/intel-drivers.nix
    ../../modules/vm-guest-services.nix
    ../../modules/local-hardware-clock.nix
  ];

  # BOOT related stuff
  boot = {
    kernelPackages = pkgs.linuxPackages_zen; # zen Kernel
    #kernelPackages = pkgs.linuxPackages_latest; # Kernel 

    kernelParams = [
      "systemd.mask=systemd-vconsole-setup.service"
      "systemd.mask=dev-tpmrm0.device" #this is to mask that stupid 1.5 mins systemd bug
      "nowatchdog" 
      "modprobe.blacklist=sp5100_tco" #watchdog for AMD
      "modprobe.blacklist=iTCO_wdt" #watchdog for Intel
 	  ];

    # This is for OBS Virtual Cam Support
    #kernelModules = [ "v4l2loopback" ];
    #  extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    
    initrd = { 
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
      kernelModules = [ ];
    };

    # Needed For Some Steam Games
    #kernel.sysctl = {
    #  "vm.max_map_count" = 2147483642;
    #};

    ## BOOT LOADERS: NOTE USE ONLY 1. either systemd or grub  
    # Bootloader SystemD
    loader.systemd-boot.enable = true;
  
    loader.efi = {
	    #efiSysMountPoint = "/efi"; #this is if you have separate /efi partition
	    canTouchEfiVariables = true;
  	  };

    loader.timeout = 5;    
  			
    # Bootloader GRUB
    #loader.grub = {
	    #enable = true;
	    #  devices = [ "nodev" ];
	    #  efiSupport = true;
      #  gfxmodeBios = "auto";
	    #  memtest86.enable = true;
	    #  extraGrubInstallArgs = [ "--bootloader-id=${host}" ];
	    #  configurationName = "${host}";
  	  #	 };

    # Bootloader GRUB theme, configure below

    ## -end of BOOTLOADERS----- ##
  
    # Make /tmp a tmpfs
    tmp = {
      useTmpfs = false;
      tmpfsSize = "30%";
      };
    
    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
      };
    
    plymouth.enable = true;
  };

  # GRUB Bootloader theme. Of course you need to enable GRUB above.. duh! and also, enable it on flake.nix
  #distro-grub-themes = {
  #  enable = true;
  #  theme = "nixos";
  #};

  # Extra Module Options
  drivers = {
    amdgpu.enable = true;
    intel.enable = true;
    nvidia.enable = false;
    nvidia-prime = {
       enable = false;
         intelBusID = "";
         nvidiaBusID = "";
    };
  };
  vm.guest-services.enable = false;
  local.hardware-clock.enable = false;

  # networking
  networking = {
    networkmanager.enable = true;
    hostName = "${host}";
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
  }; 

  # Set your time zone.
  services.automatic-timezoned.enable = true; #based on IP location
  
  #https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  #time.timeZone = "Asia/Seoul"; # Set local timezone

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


  # Services to start
  services = {
    xserver = {
      enable = false;
      xkb = {
        layout = "${keyboardLayout}";
        variant = "";
      };
    };
    
    greetd = {
      enable = true;
      vt = 3;
      settings = {
        default_session = {
          user = username;
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # start Hyprland with a TUI login manager
        };
      };
    };
    
    smartd = {
      enable = false;
      autodetect = true;
    };
    
	  gvfs.enable = true;
	  tumbler.enable = true;

	  pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
	    wireplumber.enable = true;
  	  };
	
    #pulseaudio.enable = false; #unstable
	  udev.enable = true;
	  envfs.enable = true;
	  dbus.enable = true;

	  fstrim = {
      enable = true;
      interval = "weekly";
      };
  
    libinput.enable = true;

    rpcbind.enable = false;
    nfs.server.enable = false;
  
    openssh.enable = true;
    flatpak.enable = false;
	
  	blueman.enable = true;
  	
  	#hardware.openrgb.enable = true;
  	#hardware.openrgb.motherboard = "amd";

	  fwupd.enable = true;

	  upower.enable = true;
    
    gnome.gnome-keyring.enable = true;
    
    #printing = {
    #  enable = false;
    #  drivers = [
        # pkgs.hplipWithPlugin
    #  ];
    #};
    
    #avahi = {
    #  enable = true;
    #  nssmdns4 = true;
    #  openFirewall = true;
    #};
    
    #ipp-usb.enable = true;
    
    #syncthing = {
    #  enable = false;
    #  user = "${username}";
    #  dataDir = "/home/${username}";
    #  configDir = "/home/${username}/.config/syncthing";
    #};

  };
  
  systemd.services.flatpak-repo = {
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # zram
  zramSwap = {
	  enable = true;
	  priority = 100;
	  memoryPercent = 30;
	  swapDevices = 1;
    algorithm = "zstd";
    };

  powerManagement = {
  	enable = true;
	  cpuFreqGovernor = "schedutil";
  };

  #hardware.sane = {
  #  enable = true;
  #  extraBackends = [ pkgs.sane-airscan ];
  #  disabledDefaultBackends = [ "escl" ];
  #};

  # Extra Logitech Support
  hardware = { 
     logitech.wireless.enable = false;
     logitech.wireless.enableGraphical = false;
  }; 

  services.pulseaudio.enable = false; # stable branch

  # Bluetooth
  hardware = {
  	bluetooth = {
	    enable = true;
	    powerOnBoot = true;
	    settings = {
		    General = {
		      Enable = "Source,Sink,Media,Socket";
		      Experimental = true;
		    };
      };
    };
  };

  # Security / Polkit
  security = { 
    rtkit.enable = true;
    polkit.enable = true;
    polkit.extraConfig = ''
     polkit.addRule(function(action, subject) {
       if (
         subject.isInGroup("users")
           && (
             action.id == "org.freedesktop.login1.reboot" ||
             action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
             action.id == "org.freedesktop.login1.power-off" ||
             action.id == "org.freedesktop.login1.power-off-multiple-sessions"
           )
         )
       {
         return polkit.Result.YES;
       }
    })
  '';
 };
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  # Cachix, Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Virtualization / Containers
  virtualisation.libvirtd.enable = false;
  virtualisation.podman = {
    enable = false;
    dockerCompat = false;
    defaultNetwork.settings.dns_enabled = false;
  };

  # OpenGL
  hardware.graphics = {
    enable = true;
  };

  console.keyMap = "${keyboardLayout}";

  # For Electron apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
```


### /home/lf/nix/pkgs/nvim/lua/config/options.lua
```lua
-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local cmd = vim.cmd
local opt = vim.opt
local hl = vim.api.nvim_set_hl
local fn = vim.fn
local api = vim.api
-- Set to "ruff_lsp" to use the old LSP implementation version.
vim.g.lazyvim_python_ruff = "ruff"

vim.g.python3_host_prog = "/etc/profiles/per-user/lf/bin/python3"
vim.g.lazyvim_python_lsp = "basedpyright"
-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable nvim intro
opt.shortmess:append("sI")
local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
  "did_install_default_menus",
  "loaded_netrw",
  "loaded_netrwPlugin",
  "loaded_2html_plugin",
  "loaded_zipPlugin",
  "loaded_gzip",
  "loaded_tarPlugin",
  "loaded_sql_completion",
  "loaded_tutor_mode_plugin",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

vim.loader.enable()
vim.g.logging_level = vim.log.levels.INFO

vim.g.loaded_perl_provider = 0 -- Disable perl provider
vim.g.loaded_ruby_provider = 0 -- Disable ruby provider
vim.g.loaded_node_provider = 0 -- Disable node provider
vim.g.vimsyn_embed = "l"

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = "a" -- Enable mouse support
opt.clipboard = "unnamedplus" -- Copy/paste to system clipboard
opt.swapfile = false -- Don't use swapfile
opt.completeopt = "menu,menuone,noselect,noinsert" -- Autocomplete options

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true -- Show line number
opt.relativenumber = true -- Show relative Numbers
opt.showmatch = true -- Highlight matching parenthesis
opt.foldmethod = "marker" -- Enable folding (default 'foldmarker')
opt.colorcolumn = "80" -- Line lenght marker at 80 columns
opt.splitright = true -- Vertical split to the right
opt.splitbelow = true -- Horizontal split to the bottom
opt.ignorecase = true -- Ignore case letters when search
opt.smartcase = true -- Ignore lowercase for the whole pattern
opt.linebreak = true -- Wrap on word boundary
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.laststatus = 3 -- PLACEHOLDER TODO, Set global statusline, optimal for avante
opt.cursorline = true
vim.g.have_nerd_font = true

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 4 -- Shift 4 spaces when tab
opt.tabstop = 4 -- 1 tab == 4 spaces
opt.autoindent = true -- copy indent from current line when starting new one

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true -- Enable background buffers
opt.history = 100 -- Remember N lines in history
-- opt.lazyredraw = true       -- Faster scrolling
opt.synmaxcol = 240 -- Max column for syntax highlight
opt.updatetime = 250 -- ms to wait for trigger an event

vim.g.health = { style = nil }
vim.wo.signcolumn = "yes" -- ?
opt.breakindent = true -- Keeps indentation on wrapped lines (visual improvement)
opt.undofile = true
opt.hlsearch = true -- Default = true / Highlight all matching searches
opt.timeoutlen = 300
opt.backup = false
opt.writebackup = false

-- ASK AI for Difference
opt.whichwrap = "b,s,<,>,[,],h,l"
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

opt.listchars = {
  tab = "→ ",
  -- space = "·",
  trail = "•",
  -- eol = "¬",
  nbsp = "␣",
  extends = "⟩",
  precedes = "⟦",
}
opt.scrolloff = 999
opt.sidescrolloff = 8 -- minimal number of screen columns either side of cursor if wrap is `false`
opt.numberwidth = 4 -- set number column width to 2 {default 4}
opt.smartindent = true
opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
opt.showtabline = 1 -- 1: Show tabs from 2+ open ones, 2: always show tabs
opt.backspace = "indent,eol,start" -- allow backspace on
opt.pumheight = 10 -- pop up menu height
opt.conceallevel = 0 -- so that `` is visible in markdown files
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.cmdheight = 1 -- more space in the neovim command line for displaying messages

cmd([[language en_US.UTF-8]])

local config_dir = fn.stdpath("config")
---@cast config_dir string
vim.g.netrw_liststyle = 3

opt.inccommand = "split"

-- https://github.com/hendrikmi/dotfiles/blob/main/nvim/lua/core/options.lua
opt.shortmess:append("c") -- don't give |ins-completion-menu| messages
opt.iskeyword:append("-,_") -- Makes hyphenated words (e.g., self-hosted) treated as single words in searches, motions (like w), and other word-based operations
opt.formatoptions:remove({ "c", "r", "o" }) -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
-- opt.runtimepath:remove("/usr/share/vim/vimfiles") -- separate vim plugins from neovim in case vim still in use
-- views can only be fully collapsed with the global statusline
-- PLACEHOLDER TODO

--          ╭─────────────────────────────────────────────────────────╮
--          │        api.nvim_create_autocmd("TextYankPost", {        │
--          │     desc = "Highlight when yanking (copying) text",     │
--          │                         group =                         │
--          │  api.nvim_create_augroup("kickstart-highlight-yank", {  │
--          │                    clear = true }),                     │
--          │                  callback = function()                  │
--          │                 vim.highlight.on_yank()                 │
--          │                          end,                           │
--          │                           })                            │
--          ╰─────────────────────────────────────────────────────────╯

opt.autochdir = true
opt.virtualedit = "block"
opt.cursorcolumn = false
opt.wrapscan = false
opt.fillchars = { eob = " " }
opt.wrap = true; -- Enable line wrapping

-- cmd("let g:netrw_liststyle = 3")
-- cmd([[highlight WinSeparator guibg = None]])
-- cmd([[highlight CursorLine guibg = None]])
-- cmd([[highlight CursorLineNr guifg = #d8a657]])
-- -- changing bg and border colors
-- hl(0, "FloatBorder", { link = "Normal" })
-- hl(0, "LspInfoBorder", { link = "Normal" })
-- hl(0, "NormalFloat", { link = "Normal" })
-- hl(0, "Pmenu", { link = "Normal" })
-- hl(0, "PmenuSel", { link = "Search" })

-- -- blink cmp
-- hl(0, "BlinkCmpMenu", { link = "Normal" })
-- hl(0, "BlinkCmpMenuBorder", { link = "Normal" })
-- hl(0, "BlinkCmpMenuSelection", { link = "Search" })
-- hl(0, "BlinkCmpLabelMatch", { link = "Search" })

-- -- snacks dashboard
-- hl(0, "SnacksDashboardHeader", { fg = "#d8a657" })
-- hl(0, "SnacksDashboardDesc", { fg = "#83a598" })
-- hl(0, "SnacksDashboardFooter", { fg = "#d8a657" })
--]]

-- snacks indentline
-- hl(0, "SnacksIndent1", { fg = "#ea6962" })
-- hl(0, "SnacksIndent2", { fg = "#d8a657" })
-- hl(0, "SnacksIndent3", { fg = "#458588" })
-- hl(0, "SnacksIndent4", { fg = "#8ec07c" })
-- hl(0, "SnacksIndent5", { fg = "#d3869b" })
-- hl(0, "SnacksIndent6", { fg = "#e78a4e" })
-- hl(0, "SnacksIndent7", { fg = "#83a598" })

-- snacks picker
-- hl(0, "SnacksPickerDir", { fg = "#928374" })

-- rainbow delimiter
hl(0, "RainbowDelimiter1", { fg = "#ea6962" })
hl(0, "RainbowDelimiter2", { fg = "#d8a657" })
hl(0, "RainbowDelimiter3", { fg = "#458588" })
hl(0, "RainbowDelimiter4", { fg = "#8ec07c" })
hl(0, "RainbowDelimiter5", { fg = "#d3869b" })
hl(0, "RainbowDelimiter6", { fg = "#e78a4e" })
hl(0, "RainbowDelimiter7", { fg = "#83a598" })

-- enabled with `:LazyExtras`
vim.g.lazyvim_cmp = "blink.cmp"
vim.g.lazyvim_picker = "fzf"

-- The setup below will automatically configure connections without the need for manual input each time.

-- Example configuration using dictionary with keys:
--    vim.g.dbs = {
--      dev = "Replace with your database connection URL.",
--      staging = "Replace with your database connection URL.",
--    }
-- or
-- Example configuration using a list of dictionaries:
vim.g.dbs = {
  { name = "mysql", url = "mysql://root:123@localhost:3306/" },
  -- { name = "staging", url = "Replace with your database connection URL." },
}
vim.opt_local.conceallevel = 2
-- or
-- Create a `.lazy.lua` file in your project and set your connections like this:
-- ```lua
--    vim.g.dbs = {...}
--
--    return {}
-- ```

-- Alternatively, you can also use other methods to inject your environment variables.

-- Finally, please make sure to add `.lazy.lua` to your `.gitignore` file to protect your secrets.

--          ╭─────────────────────────────────────────────────────────╮
--          │      Add this block somewhere near the top of your      │
--          │          init.lua, after any global settings.           │
--          │        vim.api.nvim_create_autocmd("VimEnter", {        │
--          │   once = true, -- Ensures this autocmd only runs once   │
--          │                   per Neovim session                    │
--          │                  callback = function()                  │
--          │               math.randomseed(os.time())                │
--          │    local fg_color_code = math.random(0, 15) -- Using    │
--          │               standard 16 terminal colors               │
--          │          vim.cmd("hi AlphaHeader ctermfg=" ..           │
--          │                tostring(fg_color_code))                 │
--          │  local gui_colors = { "#FF0000", "#00FF00", "#0000FF",  │
--          │  "#FFFF00", "#00FFFF", "#FF00FF" } -- Add more colors   │
--          │local gui_color = gui_colors[math.random(1, #gui_colors)]│
--          │      vim.cmd("hi AlphaHeader guifg=" .. gui_color)      │
--          │                          end,                           │
--          │                           })                            │
--          ╰─────────────────────────────────────────────────────────╯
```


### /home/lf/nix/hosts/default/packages-fonts.nix
```nix
# 💫 https://github.com/JaKooLit 💫 #

### /home/lf/nix/pkgs/nvim/lua/config/autocmds.lua
```lua
-- Autocmds are automatically loaded on the VeryLazy event
# Packages and Fonts config including the "programs" options

{ pkgs, inputs, ...}: let

  python-packages = pkgs.python3.withPackages (
    ps:
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
      with ps; [
        requests
        pyquery # needed for hyprland-dots Weather script
        ]
    );

  in {

-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = (with pkgs; [
  # System Packages
    bc
    baobab
    btrfs-progs
    clang
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
    curl
    cpufrequtils
    duf
    findutils
    ffmpeg   
    glib #for gsettings to work
    gsettings-qt
    git
-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

    killall  
    libappindicator
    libnotify
    openssl #required by Rainbow borders
    pciutils
    vim
    wget
    xdg-user-dirs
-- Define autocommands with Lua APIs
-- See: :h api-autocmd, :h augroup
-- https://neovim.io/doc/user/autocmd.html

    xdg-utils

    fastfetch
    (mpv.override {scripts = [mpvScripts.mpris];}) # with tray
    #ranger
      
local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

    # Hyprland Stuff
    # Buuild AGS v1 from source
    inputs.ags.packages.${pkgs.system}.default
    btop
-----------------------------------------------------------
-- General settings
    brightnessctl # for brightness control
    cava
    cliphist
    loupe
    gnome-system-monitor
    grim
    gtk-engine-murrine #for gtk themes
    hypridle
-----------------------------------------------------------

    imagemagick 
    inxi
    jq
    kitty
    libsForQt5.qtstyleplugin-kvantum #kvantum
    networkmanagerapplet
    nwg-displays
--          ╭─────────────────────────────────────────────────────────╮
    nwg-look
    nvtopPackages.full	 
    pamixer
    pavucontrol
    playerctl
    polkit_gnome
    libsForQt5.qt5ct
--          │                    Highlight on yank                    │
--          │       augroup('YankHighlight', { clear = true })        │
    kdePackages.qt6ct
    kdePackages.qtwayland
    kdePackages.qtstyleplugin-kvantum #kvantum
    rofi-wayland
    slurp
    swappy
--          │                autocmd('TextYankPost', {                │
--          │                group = 'YankHighlight',                 │
    swaynotificationcenter
    swww
    unzip
    wallust
    wl-clipboard
    wlogout
    xarchiver
    yad
    yt-dlp

--          │                  callback = function()                  │
    #waybar  # if wanted experimental next line
--          │ vim.highlight.on_yank({ higroup = 'IncSearch', timeout  │
--          │                       = '1000' })                       │
    #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
  ]) ++ [
	  python-packages
  ];

#FONTS
fonts.enable = true;
fonts.fontconfig.enable = true;
--          │                           end                           │
--          │                           })                            │
fonts.fonts = with pkgs; [
  fonts = [
      dejavu_fonts
      fira-code
      fira-code-symbols
      font-awesome
      hackgen-nf-font
--          ╰─────────────────────────────────────────────────────────╯

-- Remove whitespace on save
autocmd("BufWritePre", {
  pattern = "",
      ibm-plex
      inter
      jetbrains-mono
      material-icons
      maple-mono.NF
      minecraftia
  command = ":%s/\\s\\+$//e",
})

-- Don't auto commenting new lines
autocmd("BufEnter", {
  pattern = "",
      nerd-fonts.im-writing
      nerd-fonts.blex-mono
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
  command = "set fo-=c fo-=r fo-=o",
})


autocmd({'BufEnter', 'BufWinEnter'}, {
  pattern = {'*.xsh'},
  callback = function ()
      noto-fonts-monochrome-emoji
      powerline-fonts
      roboto
      roboto-mono
      symbola
      terminus_font
    vim.opt_local.syntax = 'python'
  end,
})



-----------------------------------------------------------
-- Settings for filetypes
      victor-mono
     ];
   ];
  };
  
  programs = {
	  hyprland = {
      enable = true;
-----------------------------------------------------------

-- Disable line length marker
augroup("setLineLength", { clear = true })
     	  #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland; #hyprland-git
autocmd("Filetype", {
  group = "setLineLength",
  pattern = { "text", "markdown", "html", "xhtml", "javascript", "typescript" },
		    #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland; #xdph-git
     	  
  command = "setlocal cc=0",
})

-- Set indentation to 2 spaces
augroup("setIndent", { clear = true })
autocmd("Filetype", {
        portalPackage = pkgs.xdg-desktop-portal-hyprland; # xdph none git
  	  xwayland.enable = true;
    };

	
	  waybar.enable = true;
	  hyprlock.enable = true;
	  firefox.enable = true;
  group = "setIndent",
  pattern = { "xml", "html", "xhtml", "css", "scss", "javascript", "typescript", "yaml", "lua", "nix"},
	  git.enable = true;
    nm-applet.indicator = true;
    neovim.enable = true;

	  thunar.enable = true;
  command = "setlocal shiftwidth=2 tabstop=2",
})

-----------------------------------------------------------
-- Terminal settings
	  thunar.plugins = with pkgs.xfce; [
		  exo
		  mousepad
		  thunar-archive-plugin
		  thunar-volman
		  tumbler
  	  ];
	
-----------------------------------------------------------

-- Open a Terminal on the right tab
autocmd("CmdlineEnter", {
    virt-manager.enable = false;
    
    #steam = {
    #  enable = true;
    #  gamescopeSession.enable = true;
    #  remotePlay.openFirewall = true;
  command = "command! Term :botright vsplit term://$SHELL",
})

-- Enter insert mode when switching to terminal
autocmd("TermOpen", {
    #  dedicatedServer.openFirewall = true;
    #};
    
    xwayland.enable = true;

    dconf.enable = true;
  command = "setlocal listchars= nonumber norelativenumber nocursorline",
})

autocmd("TermOpen", {
  pattern = "",
  command = "startinsert",
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
})

-- Close terminal buffer on process exit
autocmd("BufLeave", {
  pattern = "term://*",
  command = "stopinsert",
})

      enableSSHSupport = true;
    };
	
  };

  # Extra Portal Configuration
  xdg.portal = {
    enable = true;
    wlr.enable = false;
-- go to last loc when opening a buffer
-- this mean that when you open a file, you will be at the last position
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
      pkgs.xdg-desktop-portal
    ];
    };

  }
```
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = {

    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- resize neovim split when terminal is resized
vim.api.nvim_command("autocmd VimResized * wincmd =")

-- Hyprlang LSP
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.hl", "hypr*.conf" },
  callback = function(event)
    print(string.format("starting hyprls for %s", vim.inspect(event)))
    vim.lsp.start({
      name = "hyprlang",
      cmd = { "hyprls" },
      root_dir = vim.fn.getcwd(),
    })
  end,
})
```


### /home/lf/nix/hosts/default/users.nix
```nix
# 💫 https://github.com/JaKooLit 💫 #

### /home/lf/nix/pkgs/nvim/lua/config/keymaps.lua
```lua
-- Keymaps are automatically loaded on the VeryLazy event
# Users - NOTE: Packages defined on this will be on current user only

{ pkgs, username, ... }:

let
  inherit (import ./variables.nix) gitUsername;
in
{
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
  users = { 
    mutableUsers = true;
    users."${username}" = {
      homeMode = "755";
      isNormalUser = true;
-- Add any additional keymaps here
local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- Find and center
      description = "${gitUsername}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- save w/o auto-formatting
map("n", "<leader>sn", "<cmd>noautocmd w <CR>", opts)

        "lp"
        "video" 
        "input" 
        "audio"
      ];

    # define user packages here
    packages = with pkgs; [
map("n", "<localleader>r", ":w<CR>:term python3 %:p<CR>", { desc = "Run Python File", noremap = true, silent = true })
      ];
    };
    
    defaultUserShell = pkgs.zsh;
  }; 
  
  environment.shells = with pkgs; [ zsh ];
map("n", "<localleader>t", ":w<CR>:term pytest -s %:p<CR>", { desc = "PyTest", noremap = true, silent = true })

  environment.systemPackages = with pkgs; [ lsd fzf ]; 
    
  programs = {
  # Zsh configuration
	  zsh = {
    	enable = true;
map("n", "<leader><leader>S", ":source %<cr>", { desc = "Source Buffer", noremap = true, silent = true })

	  	enableCompletion = true;
      ohMyZsh = {
        enable = true;
        plugins = ["git"];
        theme = "agnoster"; 
      	};
      
-- Terminal: <C-q> toggles a floating terminal; <Space>t opens a terminal in a small horizontal split.
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      
      promptInit = ''
map("n", "<C-q>", ":Lspsaga term_toggle<cr>", { desc = "Floating Terminal", noremap = true, silent = true })
        fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

        #pokemon colorscripts like. Make sure to install krabby package
        #krabby random --no-mega --no-gmax --no-regional --no-title -s; 

        # Set-up icons for files/directories in terminal using lsd
map("n", "<leader>t", ":sp<bar>term<cr>:resize 10<cr>", { desc = "Split Terminal", noremap = true, silent = true })

-- inc rename\
vim.keymap.set("n", "<leader>rn", ":IncRename ")
```
        alias ls='lsd'
        alias l='ls -l'
        alias la='ls -a'
        alias lla='ls -la'
        alias lt='ls --tree'

        source <(fzf --zsh);
        HISTFILE=~/.zsh_history;
        HISTSIZE=10000;
        SAVEHIST=10000;

        setopt appendhistory;
        '';
      };
   };
}
```


### /home/lf/nix/pkgs/nvim/lua/config/lazy.lua
```lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "catppuccin", "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
```


### /home/lf/nix/hosts/default/variables.nix
```nix
# 💫 https://github.com/JaKooLit 💫 #
# Variables

{
  # Git Configuration ( For Pulling Software Repos )
  gitUsername = "JaKooLit";
  gitEmail = "ejhay.games@gmail.com";

  # Hyprland Settings
  extraMonitorSettings = "";

  # Waybar Settings
  clock24h = true;

  # Program Options
  browser = "firefox"; # Set Default Browser (google-chrome-stable for google-chrome)
  terminal = "kitty"; # Set Default System Terminal
  keyboardLayout = "us";
}
```


### /home/lf/nix/hosts/lf-nix/disko.nix
```nix
{
  device,
  swap,
}: {
  devices = {
    disk.system = {
      type = "disk";
      inherit device;
      content = {
        type = "gpt";
        partitions = {
          esp = {
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["umask=0077"];
            };
          };
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";
              askPassword = true;
              settings.allowDiscards = true;
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = let
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                in {
                  "/persist" = {
                    mountpoint = "/persist";
                    inherit mountOptions;
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    inherit mountOptions;
                  };
                  "/swap" = {
                    mountpoint = "/swap";
                    swap.swapfile.size = swap;
                  };
                };
              };
            };
          };
        };
      };
    };
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=8G"
        "defaults"
        "mode=755"
      ];
    };
  };
}
```


### /home/lf/nix/pkgs/nvim/lua/config/lsp.lua
```lua
require("lspconfig").nixd.setup({
  cmd = { "nixd" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      formatting = {
        command = { "alejandra" },
      },
    },
  },
})
```


### /home/lf/nix/hosts/lf-nix/hardware.nix
```nix
# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/15b1dbc5-5ead-41c6-863d-b8b6a78435df";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/FBE6-0ED2";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/f18be78c-c354-4328-a826-acb28a1b0d95";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
```


### /home/lf/nix/pkgs/nvim/lua/plugins/alpha.lua
```lua
local M = {} -- M is a common convention for a module table

local MY_CUSTOM_HEADERS = {
  -- Your first example header (jgs)
  {
    [[            .-'''''-.    ]],
    [[          .'         `.  ]],
    [[         :             : ]],
    [[        :               :]],
    [[        :      _/|      :]],
    [[         :   =/_/      : ]],
    [[          `._/ |     .'  ]],
    [[       (   /  ,|...-'    ]],
    [[        \_/^\/||__       ]],
    [[     _/~  `""~`"` \_     ]],
    [[  __/  -'.  ` .  `\_\__  ]],
    [[/jgs     \           \-.\ ]],
  },
  {
    "                                                     ",
    "  ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓ ",
    "  ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒ ",
    " ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░ ",
    " ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██  ",
    " ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒ ",
    " ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░ ",
    " ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░ ",
    "    ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░    ",
    "          ░    ░  ░    ░ ░        ░   ░         ░    ",
    "                                 ░                   ",
    "                                                     ",
    "                █████╗  ██╗ ██████████████╗          ",
    "               ██╔══██╗ ╚═╝ ╚═██╔═██╔═██╔═╝          ",
    "              ██╔╝  ██║ ██╗   ██║ ██║ ██║            ",
    "              ████████║ ██║   ██║ ██║ ██║            ",
    "              ██╔═══██║ ██║ ██████████████╗          ",
    "              ╚═╝   ╚═╝ ╚═╝ ╚═════════════╝          ",
  },
  {
    [[=================     ===============     ===============   ========  ========]],
    [[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
    [[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
    [[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
    [[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
    [[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
    [[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
    [[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
    [[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
    [[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
    [[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
    [[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
    [[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
    [[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
    [[||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
    [[||.=='    _-'                                                     `' |  /==.||]],
    [[=='    _-'                        N E O V I M                         \/   `==]],
    [[\   _-'                                                                `-_   /]],
    [[ `''                                                                      ``' ]],
  },

  {
    [[  ／|_       ]],
    [[ (o o /      ]],
    [[  |.   ~.    ]],
    [[  じしf_,)ノ ]],
  },

  {
    "          ▀████▀▄▄              ▄█ ",
    "            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ",
    "    ▄        █          ▀▀▀▀▄  ▄▀  ",
    "   ▄▀ ▀▄      ▀▄              ▀▄▀  ",
    "  ▄▀    █     █▀   ▄█▀▄      ▄█    ",
    "  ▀▄     ▀▄  █     ▀██▀     ██▄█   ",
    "   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ",
    "    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ",
    "   █   █  █      ▄▄           ▄▀   ",
  },

  {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
  },

  {
    [[                               __                ]],
    [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
    [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
    [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
    [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
    [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
  },
}

return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set random color for the header
    math.randomseed(os.time() + math.floor(os.clock() * 1000000))
    local random_ctermfg = math.random(0, 15)
    vim.api.nvim_set_hl(0, "AlphaHeader", { ctermfg = random_ctermfg })

    -- Set random header
    local random_index = math.random(1, #MY_CUSTOM_HEADERS)
    dashboard.section.header.val = MY_CUSTOM_HEADERS[random_index]

    -- Set the highlight group for the header
    dashboard.section.header.opts.hl = "AlphaHeader"

    -- Disable dashboard if opening a file
    if vim.fn.argc() > 0 then
      dashboard.config.opts.noautocmd = true
    end

    -- Setup alpha
    alpha.setup(dashboard.config)
  end,
}
```


### /home/lf/nix/hosts/lf-nix/sops.nix
```nix
{...}: {
  sops = {
    defaultSopsFile = ../../secrets.yaml;
    gnupg.sshKeyPaths = [
      "/home/lf/.ssh/id_ed25519"
    ];
    age.sshKeyPaths = [
      "/home/lf/.ssh/id_ed25519"
    ];
  };
}
```


### /home/lf/nix/pkgs/nvim/lua/plugins/background.lua
```lua
-- ~/.config/nvim/lua/plugins/background.lua
-- Initialize global background settings
vim.g.bg_settings = {
  transparent = false, -- Default transparency state
  opacity = 0.8,      -- Default opacity (matches Ghostty's config)
  blur_enabled = false, -- Default blur state (controlled by Ghostty)
}

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false, -- Ensure it loads with LazyVim's colorscheme
    priority = 1000,
    opts = function(_, opts)
      -- Extend existing Catppuccin opts from colorscheme.lua
      return vim.tbl_deep_extend("force", opts, {
        transparent_background = vim.g.bg_settings.transparent,
      })
    end,
    config = function(_, opts)
      -- Function to send OSC sequences to Ghostty
      local function send_ghostty_osc(code, value)
        local esc = "\x1b]" .. code .. ";" .. value .. "\x1b\\"
        io.stdout:write(esc)
        io.stdout:flush()
      end

      -- Function to update Ghostty background settings
      local function update_ghostty_background()
        if vim.g.bg_settings.transparent then
          -- Set opacity when transparent
          send_ghostty_osc("11", string.format("rgba(0,0,0,%.2f)", vim.g.bg_settings.opacity))
          -- Blur is controlled by Ghostty keybindings, but sync state
          if vim.g.bg_settings.blur_enabled then
            send_ghostty_osc("705", "gaussian")
          else
            send_ghostty_osc("705", "none")
          end
        else
          -- Reset to fully opaque, no blur
          send_ghostty_osc("11", "rgb(0,0,0)")
          send_ghostty_osc("705", "none")
        end
      end

      -- Function to toggle transparency globally
      local function toggle_transparency()
        vim.g.bg_settings.transparent = not vim.g.bg_settings.transparent
        if vim.g.bg_settings.transparent then
          vim.o.background = "dark" -- Ensure dark background for transparency
          vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
          vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
          vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
          vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
        else
          -- Reset to theme's default background
          vim.api.nvim_set_hl(0, "Normal", {})
          vim.api.nvim_set_hl(0, "NormalFloat", {})
          vim.api.nvim_set_hl(0, "SignColumn", {})
          vim.api.nvim_set_hl(0, "LineNr", {})
        end
        -- Update Catppuccin if active
        if vim.g.colors_name and vim.g.colors_name:find("catppuccin") then
          require("catppuccin").setup(vim.tbl_deep_extend("force", opts, {
            transparent_background = vim.g.bg_settings.transparent,
          }))
          vim.cmd.colorscheme("catppuccin")
        end
        update_ghostty_background()
        require("lazy.core.util").notify(
          "Transparency " .. (vim.g.bg_settings.transparent and "enabled" or "disabled"),
          { title = "Background", level = vim.log.levels.INFO }
        )
      end

      -- Apply Catppuccin setup
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")

      -- Set initial background state
      if vim.g.bg_settings.transparent then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
        vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
      end
      update_ghostty_background()

      -- Keybinding for transparency toggle
      vim.keymap.set("n", "<leader>ub", toggle_transparency, { desc = "Toggle Background Transparency", noremap = true, silent = true })
    end,
  },
}
```


### /home/lf/nix/hosts/lf-nix/users.nix
```nix
{
  pkgs,
  username,
  ...
}:
# users.nix
{
  users = {
    mutableUsers = true;
    users."${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "Laurent Flaster";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
        "video"
        "input"
        "audio"
        "docker"
      ];
    };
    defaultUserShell = pkgs.zsh;
  };

  #  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [
    lsd
    bat
    fd
    fzf
    ripgrep
    grip-grab
    repgrep
    ripgrep-all
  ];
  systemd.user.services.install-pre-commit = {
    description = "Install pre-commit hooks for dotfiles";
    wantedBy = ["default.target"];
    script = ''
      ${pkgs.pre-commit}/bin/pre-commit install --install-dir $HOME/NixOS-Hyprland
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      PrivateTmp = false;
      ProtectHome = false;
    };
  };
}
```


### /home/lf/nix/pkgs/nvim/lua/plugins/comment-boxe.lua
```lua
-- lua/plugins/comment-box.lua
return {
  "LudoPinelli/comment-box.nvim",
  event = "VeryLazy", -- Or "BufReadPost", "BufNewFile" if you want it sooner
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<localleader>cb",
      "<Cmd>CBccbox<CR>",
      mode = { "n", "v" },
      desc = "Box: Title", -- Short and descriptive for which-key
    },
    {
      "<localleader>ct",
      "<Cmd>CBllline<CR>",
      mode = { "n", "v" },
      desc = "Box: Titled Line",
    },
    {
      "<localleader>cl",
      "<Cmd>CBline<CR>",
      mode = "n", -- This command is normal mode only in plugin examples
      desc = "Box: Simple Line",
    },
    {
      "<localleader>cm",
      "<Cmd>CBllbox14<CR>",
      mode = { "n", "v" },
      desc = "Box: Marked",
    },
    {
      "<localleader>cd",
      "<Cmd>CBd<CR>",
      mode = { "n", "v" },
      desc = "Box: Delete", -- For removing a comment box
    },
  },
  config = function()
    -- Register <localleader>c prefix for which-key
    local wk = require("which-key")
    wk.add({
      { "<localleader>c", group = "Comment Box" }, -- Group description for <localleader>c
    })
  end,
  -- This plugin doesn't require a .setup() call.
  -- Its commands are globally available once loaded.
  -- ── config = false, -- Explicitly state no config function is needed ──
}
```


### /home/lf/nix/hosts/lf-nix/variables.nix
```nix
{
  # Hyprland Settings
  extraMonitorSettings = "";

  # Waybar Settings
  clock24h = true;

  # Program Options
  browser = "zen-browser"; # Set Default Browser (google-chrome-stable for google-chrome)
  terminal = "kitty"; # Set Default System Terminal
  keyboardLayout = "us";
}
```


### /home/lf/nix/pkgs/nvim/lua/plugins/comment.lua
```lua
return {
  "numToStr/Comment.nvim",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  event = { "LspAttach" },
  config = function()
    local comment = require("Comment")

    comment.setup({
      ---Add a space b/w comment and the line
      padding = true,
      ---Whether the cursor should stay at its position
      sticky = true,
      ---Lines to be ignored while (un)comment
      ignore = nil,
      ---LHS of toggle mappings in NORMAL mode
      toggler = {
        ---Line-comment toggle keymap
        line = "gcc",
        ---Block-comment toggle keymap
        block = "gbc",
      },
      ---LHS of operator-pending mappings in NORMAL and VISUAL mode
      opleader = {
        ---Line-comment keymap
        line = "gc",
        ---Block-comment keymap
        block = "gb",
      },
      ---LHS of extra mappings
      extra = {
        ---Add comment on the line above
        above = "gcO",
        ---Add comment on the line below
        below = "gco",
        ---Add comment at the end of line
        eol = "gcA",
      },
      ---Enable keybindings
      ---NOTE: If given `false` then the plugin won't create any mappings
      mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
      },
      ---Function to call before (un)comment
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      ---Function to call after (un)comment
      post_hook = nil,
    })
  end,
}
```


### /home/lf/nix/hosts/viech/config.nix
```nix
{ 
  config,
  pkgs,
  host,
  username,
  options,
 # lib,
  inputs,
 # system,
  ...}: let
  
  inherit (import ./variables.nix) keyboardLayout;

  in {
  imports = [
    ./hardware.nix
    ./users.nix
    ./packages-fonts.nix
    ../../modules/intel-drivers.nix
    ../../modules/vm-guest-services.nix
    ../../modules/local-hardware-clock.nix
    "${inputs.nix-mineral}/nix-mineral.nix"
    # ./disko.nix
  ];

  # BOOT related stuff
  boot = {
    #kernelPackages = pkgs.linuxPackages_zen; # Performance geared
    kernelPackages = pkgs.linuxPackages_latest; # Best Balance
    #kernelPackages = pkgs.linuxPackages_lts # Most Stable 

    kernelParams = [
      "systemd.mask=systemd-vconsole-setup.service"
      "systemd.mask=dev-tpmrm0.device" #this is to mask that stupid 1.5 mins systemd bug
      "nowatchdog" 
      "modprobe.blacklist=sp5100_tco" #watchdog for AMD
      "modprobe.blacklist=iTCO_wdt" #watchdog for Intel
 	  ];

    initrd = { 
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
      kernelModules = [ ];
    };

    # Needed For Some Steam Games
    #kernel.sysctl = {
    #  "vm.max_map_count" = 2147483642;
    #};

    ## BOOT LOADERS: NOTE USE ONLY 1. either systemd or grub  
    # Bootloader SystemD
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 5;    
  			
    # Make /tmp a tmpfs
    tmp = {
      useTmpfs = false;
      tmpfsSize = "30%";
      };
    
    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
      };
    
    plymouth.enable = true;
  };

    vm.guest-services.enable = false;
    local.hardware-clock.enable = false;

  # networking
  networking = {
    networkmanager.enable = true;
    hostName = "${host}";
    timeServers = options.networking.timeServers.default ++ [
       "pool.ntp.org" ];
  }; 

  # Set your time zone.
  # services.automatic-timezoned.enable = true; #based on IP location
  
  #https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  time.timeZone = "Asia/Jerusalem"; # Set local timezone

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "he_IL.UTF-8";
    LC_IDENTIFICATION = "he_IL.UTF-8";
    LC_MEASUREMENT = "he_IL.UTF-8";
    LC_MONETARY = "he_IL.UTF-8";
    LC_NAME = "he_IL.UTF-8";
    LC_NUMERIC = "he_IL.UTF-8";
    LC_PAPER = "he_IL.UTF-8";
    LC_TELEPHONE = "he_IL.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


  # Services to start
  services = {
    xserver = {
      enable = false;
      xkb = {
        layout = "${keyboardLayout}";
         variant = "";
      };
    };
    
    greetd = {
      enable = true;
      vt = 1;
      settings = {
        default_session = {
          user = username;
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet
          --time --cmd Hyprland";
        };
      };
    };

    
    smartd = {
      enable = false;
      autodetect = true;
    };
    
    gvfs.enable = true;
    tumbler.enable = true;

      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        wireplumber.enable = true;
        extraConfig = {
           pipewire = {
             "context.properties" = {
               "default.clock.rate"          = 48000;
               "default.clock.allowed-rates" = [ 44100 48000
                88200 96000 176400 192000 352800 384000 705600 
                768000 ];
               "default.clock.quantum"       = 1024;
               "default.clock.min-quantum"   = 1024;
               "default.clock.max-quantum"   = 1024;
             };
           };
          };
          wireplumber.extraConfig = {
                "51-disable-suspend" = {
                  "monitor.session.rule.suspend-node.disabled" = true;
                };
              };
            };
	



    #pulseaudio.enable = false; #unstable
    udev.enable = true;
    envfs.enable = true;
    dbus.enable = true;

    fstrim = {
      enable = true;
      interval = "weekly";
      };
  
    libinput.enable = true;

    rpcbind.enable = false;
    nfs.server.enable = false;
  
    openssh.enable = true;
    flatpak.enable = false;
	
    blueman.enable = true;
  	
    #hardware.openrgb.enable = true;
    #hardware.openrgb.motherboard = "amd";

    fwupd.enable = false;
    upower.enable = true; 
    gnome.gnome-keyring.enable = true;
    
    #printing = {
    #  enable = false;
    #  drivers = [
        # pkgs.hplipWithPlugin
    #  ];
    #};
    
    #avahi = {
    #  enable = true;
    #  nssmdns4 = true;
    #  openFirewall = true;
    #};
    
    #ipp-usb.enable = true;
    
    syncthing = {
      enable = true;
      user = "${username}";
      dataDir = "/home/${username}";
      configDir = "/home/${username}/.config/syncthing";
    };
  };

  systemd.services = {
#    # Service to clone your private GitLab repository
#    initial-clone-gitlab = {
#      description = "Initial clone of private GitLab repository";
#      wants = [ "network-online.target" ];
#      after = [ "network-online.target" ];
#      # ADD THIS BLOCK: Make commands available to the script
#      path = [
#        pkgs.gitFull      # Provides 'git'
#        pkgs.util-linux   # Provides 'runuser'
#      ];
#      script = ''
#        if [ ! -d "/home/${username}/git/laurent.flaster" ]; then
#          mkdir -p /home/${username}/git
#          chown ${username} /home/${username}/git
#          runuser -u ${username} -- git clone https://git.infinitylabs.co.il/ilrd/ramat-gan/ai3/laurent.flaster.git /home/${username}/git/laurent.flaster
#        fi
#      '';
#      serviceConfig = {
#        Type = "oneshot";
#        RemainAfterExit = true;
#        User = "root";
#      };
#    };

    # Service to clone your Obsidian Brain repository
    initial-clone-brain = {
      description = "Initial clone of Obsidian Brain repository";
      wants = [ "network-online.target" ];
      after = [ "network-online.target" ];
      # ADD THIS BLOCK: Make commands available to the script
      path = [
        pkgs.gitFull      # Provides 'git'
        pkgs.util-linux   # Provides 'runuser'
      ];
      script = ''
        if [ ! -d "/home/${username}/Obsidian/brain" ]; then
          mkdir -p /home/${username}/Obsidian
          chown ${username} /home/${username}/Obsidian
          runuser -u ${username} -- git clone https://github.com/batou069/brain.git /home/${username}/Obsidian/brain
        fi
      '';
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        User = "root";
        PrivateTmp = false;
        ProtectHome = false;
      };
    };
};
  # zram
  zramSwap = {
	  enable = true;
	  priority = 100;
	  memoryPercent = 30;
	  swapDevices = 1;
    algorithm = "zstd";
    };

  powerManagement = {
  	enable = true;
	  cpuFreqGovernor = "schedutil";
  };

  #hardware.sane = {
  #  enable = true;
  #  extraBackends = [ pkgs.sane-airscan ];
  #  disabledDefaultBackends = [ "escl" ];
  #};

  # Extra Logitech Support
  hardware = { 
     logitech.wireless.enable = true;
     logitech.wireless.enableGraphical = true;
  }; 

#  hardware.graphics = {
#    enable = true;
#  };

   hardware.graphics = {
    enable = true;
    enable32Bit = true;
   };

  # Bluetooth
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
	  Enable = "Source,Sink,Media,Socket";
	  Experimental = true;
	};
      };
    };
  };

  # Security / Polkit
  security = { 
    rtkit.enable = true;
    polkit.enable = true;
    polkit.extraConfig = ''
     polkit.addRule(function(action, subject) {
       if (
         subject.isInGroup("users")
           && (
             action.id == "org.freedesktop.login1.reboot" ||
             action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
             action.id == "org.freedesktop.login1.power-off" ||
             action.id == "org.freedesktop.login1.power-off-multiple-sessions"
           )
         )
       {
         return polkit.Result.YES;
       }
    })
  '';
 };
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  # Cachix, Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };

  # Virtualization / Containers
  virtualisation.libvirtd.enable = false;
  virtualisation.podman = {
    enable = false;
    dockerCompat = false;
    defaultNetwork.settings.dns_enabled = false;
  };

virtualisation.docker = {
  enable = true;
  rootless.enable = false;
  autoPrune.enable = true;
  enableOnBoot = true;

};

  console.keyMap = "${keyboardLayout}";

  # For Electron apps to use wayland
	environment.sessionVariables = {
	  NIXOS_OZONE_WL = "1"; # Enable Wayland Ozone platform for Electron apps
	  ELECTRON_OZONE_PLATFORM_HINT = "wayland"; # Or "AUTO"
	  # You might also try:
	  # ELECTRON_ENABLE_WAYLAND = "1";
	};

   programs = {
   # Zsh configuration
     zsh = {
     	enable = true;
 	enableCompletion = true;
         ohMyZsh.enable = false;
       
         autosuggestions.enable = false;
         syntaxHighlighting.enable = false;
         promptInit = "";
       };
    };
 
  environment.variables.FZF_SHELL_DIR = "${pkgs.fzf}/share/fzf";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
```


### /home/lf/nix/pkgs/nvim/lua/plugins/cssview.lua
```lua
return {
  "hat0uma/csvview.nvim",
  ---@module "csvview"
  ---@type CsvView.Options
  opts = {
    parser = { comments = { "#", "//" } },
    keymaps = {
      -- Text objects for selecting fields
      textobject_field_inner = { "if", mode = { "o", "x" } },
      textobject_field_outer = { "af", mode = { "o", "x" } },
      -- Excel-like navigation:
      -- Use <Tab> and <S-Tab> to move horizontally between fields.
      -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
      -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
      jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
      jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
      jump_next_row = { "<Enter>", mode = { "n", "v" } },
      jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
    },
  },
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
}
```


### /home/lf/nix/assets/Thunar/uca.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<actions>
<action>
	<icon>audacious</icon>
	<name>Add to audacious playlist</name>
	<submenu></submenu>
	<unique-id>1681893052016505-1</unique-id>
	<command>audacious -e %U</command>
	<description></description>
	<range>*</range>
	<patterns>*</patterns>
	<audio-files/>
</action>
<action>
	<icon>utilities-terminal</icon>
	<name>Open Terminal Here</name>
	<submenu></submenu>
	<unique-id>1703572977408169-1</unique-id>
	<command>exo-open --working-directory %f --launch TerminalEmulator</command>
	<description>Launch TerminalEmulator</description>
	<range></range>
	<patterns>*</patterns>
	<startup-notify/>
	<directories/>
</action>
<action>
	<icon>checkbox</icon>
	<name>Check sha1sum</name>
	<submenu></submenu>
	<unique-id>1526633271260079-26</unique-id>
	<command>yad --info --title=&quot;Check sha1 for %n&quot; --text=&quot;$(sha1sum %f)&quot;</command>
	<description>Check sha1sum</description>
	<range></range>
	<patterns>*.iso;*.ISO</patterns>
	<other-files/>
</action>
<action>
	<icon>checkbox</icon>
	<name>Check sha256sum</name>
	<submenu></submenu>
	<unique-id>1577688162350307-1</unique-id>
	<command>yad --info --title=&quot;Check sha256 for %n&quot; --text=&quot;$(sha256sum %f)&quot;</command>
	<description>Check sha256sum</description>
	<range></range>
	<patterns>*.iso;*.ISO</patterns>
	<other-files/>
</action>
<action>
	<icon>checkbox</icon>
	<name>Check md5sum</name>
	<submenu></submenu>
	<unique-id>1526736788575383-2</unique-id>
	<command>yad --info --title=&quot;Check md5 for %n&quot; --text=&quot;$(md5sum %f)&quot;</command>
	<description>Check md5sum</description>
	<range></range>
	<patterns>*.iso;*.ISO;*.tar.gz;*.TAR.GZ;*.zip;*.ZIP</patterns>
	<other-files/>
</action>
</actions>
```


### /home/lf/nix/hosts/viech/hardware.nix
```nix
# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/15b1dbc5-5ead-41c6-863d-b8b6a78435df";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/FBE6-0ED2";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/f18be78c-c354-4328-a826-acb28a1b0d95"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
```


### /home/lf/nix/pkgs/nvim/lua/plugins/example.lua
```lua
-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  -- disable trouble
  { "folke/trouble.nvim", enabled = false },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },

  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },

  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return "😄"
        end,
      })
    end,
  },

  -- or you can return new options to override all the defaults
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        --[[add your custom lualine config here]]
      }
    end,
  },

  -- use mini.starter instead of alpha
  { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },
}
```


### /home/lf/nix/hosts/viech/home/bat.nix
```nix
{
  pkgs,
  ...
} : {  
  programs.bat = {
  enable = true;
  themes = {
    dracula = {
      src = pkgs.fetchFromGitHub {
        owner = "dracula";
        repo = "sublime"; # Bat uses sublime syntax for its themes
        rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
        sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
      };
      file = "Dracula.tmTheme";
      };
    };
  };
}
```


### /home/lf/nix/pkgs/nvim/lua/plugins/golf.lua
```lua
return { "vuciv/golf" }
```


### /home/lf/nix/hosts/viech/home/cli.nix
```nix
{
  lib,
  config,
  pkgs,
  ...
}:
{
  programs = {
    micro = {
      enable = true;
      settings = {
        clipboard = "internal";
        colorscheme = "one-dark";
        diffgutter = true;
        indentchar = "space";
        scrollbar = true;
      };
    };
 
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      history = {
        append = true;
        share = true;
        findNoDups = true;
        saveNoDups = true;
        ignoreAllDups = true;
        ignoreDups = true;
        ignoreSpace = true;
        path = "${config.xdg.dataHome}/.zsh_history";
        size = 100000;
        save = 100000;
        extended = true;
      };
      autocd = true;
      defaultKeymap = "viins";
      localVariables = {
        
      };
      zsh-abbr.globalAbbreviations = {
        C = "| wl-copy";
        G = "| rg ";
        L = "| less -R";
      };
      shellAliases = {
        nix-update="sudo nixos-rebuild switch --flake ~/NixOS-Hyprland#lf-nix";
        nix-build="nixos-rebuild build --flake ~/NixOS-Hyprland#lf-nix";
        nix-gc="nix-collect-garbage";
        nix-gcd="nix-collect-garbage -d";
        c="clear";
        p="python";
        py="python";
        e="exit";
        btc="curl rate.sx";
        # paths="echo -e ${PATH//:/\\n}";
        d="docker";
        dc="docker compose";
        dcu="docker compose up";
        dcd="docker compose down";
        dcud="docker compose up -d";
        dps="docker ps";
        dpsa="docker ps -a";
        drfa="'docker rm -f $(docker ps -aq)'";
        tai="tmux attach -t ai3";
        t="tmux";
        ld="lazydocker";
        lg="lazygit";
        treesize="ncdu";
        lastmod="find . -type f -not -path '*/\.*' -exec ls -lrt {} +";
        zf="z '$(zoxide query -l | fzf --preview 'ls --color {}' --preview-window '70%:wrap' --border-label='Dir Jump')'";
        gv="git grep --line-number . | fzf --delimiter : --nth 3.. --bind 'enter:become(nvim {1} +{2})' --border-label='Git Grep'";
        dfz="docker ps -a | fzf --multi --header 'Select container' --preview 'docker inspect {1}' --preview-window '40%:wrap' --border-label='Docker Select' | awk '{print \$1}' | xargs -I {} docker start {}";
        v="fzf --preview --border-label='File Picker' 'bat {}' --preview-window '70%:wrap' --multi --bind 'enter:become(nvim {+})'";
        mans="man -k . | fzf --border-label='Man Pages' | awk '{print \$1}' | xargs -r man";
        ns="nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --preview-window 'right:40%:wrap' --scheme history";
        ".."="cd ..";
        "..."="cd ../..";

      };
      syntaxHighlighting = {
        enable = true;
      };

      initContent = ''
        export PATH="$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:/run/current-system/sw/bin:$PATH"
        yt() {fabric -y "$1" --transcript}

        mkcd() { mkdir -p "$1" && cd "$1" }
        rgn() { rg --line-number --no-heading "$@" | awk -F: '{print $1 " [" $2 "]"}' | fzf --border-label 'Ripgrep Search' --delimiter ' \[' --nth 1 --preview 'bat --style=plain --color=always {1} --line-range $(({2}-5)): --highlight-line {2}' --preview-window 'right,70%,border-left' --border-label 'Ripgrep Search' --bind 'enter:become(nvim {1} +{2})' }
        rga-fzf() {
          RG_PREFIX="rga --files-with-matches"
          local file
          file="$(
              FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
                  fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
                      --phony -q "$1" \
                      --bind "change:reload:$RG_PREFIX {q}" \
                      --preview-window="70%:wrap"
              )" &&
        echo "opening $file" &&
        xdg-open "$file"
        }


#        eval "$(starship init zsh)"
      '';
    };

    kitty = {
      enable = true;
      font = {
        name = "Maple Mono NF";
        size = 14;
      };
    };
    
    eza = {
      enable = true;
      extraOptions = [
        "--classify"
        "--color-scale"
        "--git"
        "--group-directories-first"
      ];
    };

    htop = {
      enable = true;
      settings =
        {
          tree_view = 1;
          hide_kernel_threads = 1;
          hide_userland_threads = 1;
          shadow_other_users = 1;
          show_thread_names = 1;
          show_program_path = 0;
          highlight_base_name = 1;
          header_layout = "two_67_33";
          color_scheme = 6;
        }
        // (with config.lib.htop; leftMeters [ (bar "AllCPUs4") ])
        // (
          with config.lib.htop;
          rightMeters [
            (bar "Memory")
            (bar "Swap")
            (bar "DiskIO")
            (bar "NetworkIO")
            (text "Systemd")
            (text "Tasks")
            (text "LoadAverage")
          ]
        );
    };

    zellij = {
      enable = true;
      enableZshIntegration = false;
      settings = {
        theme = "one-half-dark";
        themes.one-half-dark = {
          bg = [
            40
            44
            52
          ];
          gray = [
            40
            44
            52
          ];
          red = [
            227
            63
            76
          ];
          green = [
            152
            195
            121
          ];
          yellow = [
            229
            192
            123
          ];
          blue = [
            97
            175
            239
          ];
          magenta = [
            198
            120
            221
          ];
          orange = [
            216
            133
            76
          ];
          fg = [
            220
            223
            228
          ];
          cyan = [
            86
            182
            194
          ];
          black = [
            27
            29
            35
          ];
          white = [
            233
            225
            254
          ];
        };
      };
    };

  zoxide = {
    enable = true;
    enableZshIntegration = true;
    };
    
  lsd = {
    enable = true;
    enableZshIntegration= true;
    package = pkgs.lsd;
    settings = {
      date = "relative"; # Show relative dates
      icons = {
        when = "auto"; # Auto-detect icon support
        theme = "fancy"; # Use fancy icons
      };
    };
  };

  fzf = {
      enable = true;
      package = pkgs.fzf;
      enableZshIntegration = true;
      defaultCommand = "fd --type f --hidden --follow --exclude .git"; # Matches _fzf_compgen_path
      defaultOptions = [
        "--preview='bat --style=numbers --color=always --line-range :500 {}'"
        "--preview-window 'right:70%:wrap'"
        "--border-label='File Picker'"
        "--layout=reverse"
        "--border=none"
        "--info='hidden'"
        "--header=''"
        "--prompt='/ '"
        "-i"
        "--no-bold"
        "--no-hscroll"
        #   "--bind='enter:execute(nvim {})'"
      ];
      fileWidgetCommand = "fd --type f --hidden --follow --exclude .git"; # Matches _fzf_compgen_path
      fileWidgetOptions = [
        "--preview 'bat --color=always {}'"
        "--preview-window '70%:wrap'"
        "--border-label='File Picker'"
      ];
      changeDirWidgetCommand = "fd --type d --hidden --follow --exclude .git"; # Matches _fzf_compgen_dir
      changeDirWidgetOptions = [
        "--preview 'lsd -a --tree --directory-only --color=always {}'"
        "--preview-window '70%:wrap'"
        "--border-label='Dir Jump'"
      ];
      historyWidgetOptions = [
        "--border-label='History Search'"
      ];
      colors = {
          fg = "#C6D0F5";
          "fg+" = "#C6D0F5";
          bg = "#303446";
          "bg+" = "#51576D";
          hl = "#E78284";
          "hl+" = "#E78284";
          info = "#CA9EE6";
          marker = "#BABBF1";
          prompt = "#CA9EE6";
          spinner = "#F2D5CF";
          pointer = "#F2D5CF";
          header = "#E78284";
          gutter = "#262626";
          border = "#414559";
          separator = "#4b4646";
          scrollbar = "#a22b2b";
          preview-bg = "#414559";
          preview-border = "#4b4646";
          label = "#C6D0F5";
          query = "#d9d9d9";
      };
    };

    bat = {
      enable = true;
      themes = {
        dracula = {
         src = pkgs.fetchFromGitHub {
           owner = "dracula";
           repo = "sublime"; # Bat uses sublime syntax for its themes
           rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
           sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
           };
           file = "Dracula.tmTheme";
           };
         };
        extraPackages = with pkgs.bat-extras; [
          batdiff
          batman
          prettybat
          batwatch
        ]
        ;
    };

    starship = {
     enable = true;
     enableZshIntegration = true;
     settings =
       let
         darkgray = "242";
       in
       {
         format = lib.concatStrings [
           "$username"
           "($hostname )"
           "$directory"
           "($git_branch )"
           "($git_state )"
           "($git_status )"
           "($git_metrics )"
           "($cmd_duration )"
           "$line_break"
           "($python )"
           "($nix_shell )"
           "($direnv )"
           "$character"
         ];

         directory = {
           style = "blue";
           read_only = " !";
         };

         character = {
           success_symbol = "[❯](purple)";
           error_symbol = "[❯](red)";
           vicmd_symbol = "[❮](green)";
         };

         git_branch = {
           format = "[$branch]($style)";
           style = darkgray;
         };

         git_status = {
           format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted )](218)($ahead_behind$stashed)]($style)";
           style = "cyan";
           conflicted = "​";
           untracked = "​";
           modified = "​";
           staged = "​";
           renamed = "​";
           deleted = "​";
           stashed = "≡";
         };

         git_state = {
           format = "[$state( $progress_current/$progress_total)]($style)";
           style = "dimmed";
           rebase = "rebase";
           merge = "merge";
           revert = "revert";
           cherry_pick = "pick";
           bisect = "bisect";
           am = "am";
           am_or_rebase = "am/rebase";
         };

         git_metrics.disabled = false;

         cmd_duration = {
           format = "[$duration]($style)";
           style = "yellow";
         };

         python = {
           format = "[$virtualenv]($style)";
           style = darkgray;
         };

         nix_shell = {
           format = "❄️";
           style = darkgray;
           heuristic = true;
         };

         direnv = {
           format = "[($loaded/$allowed)]($style)";
           style = darkgray;
           disabled = false;
           loaded_msg = "";
           allowed_msg = "";
         };

         username = {
           format = "[$user]($style)";
           style_root = "yellow italic";
           style_user = darkgray;
         };

         hostname = {
           format = "@[$hostname]($style)";
           style = darkgray;
         };
       };
   };

    # for nushell wrapper to pick up HM things
    #bash.enable = true;
    #fish.enable = true; # only for nushell completions really
    carapace = {
      enable = true;
      enableZshIntegration = true;
      };
    


    nushell = {
      enable = true;

    };

    man.enable = lib.mkDefault false;

    

    ripgrep = {
      enable = true;
      arguments = [
        "--smart-case"
        "--pretty"
      ];
    };
  };

  manual = {
    html.enable = true;
    manpages.enable = true;
};
}
```


### /home/lf/nix/pkgs/nvim/lua/plugins/leetcode.lua
```lua
return {
    "kawre/leetcode.nvim",
    cmd = "Leet",
    build = "TSUpdate html", -- if you have `nvim-treesitter` installed
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "ibhagwan/fzf-lua",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        ---@type lc.lang
        lang = "python",
        plugins = {
            non_standalone = true,
        },    
    },
}
```


### /home/lf/nix/hosts/viech/home/firefox/default.nix
```nix
{
  programs.firefox = {
    enable = true;

    profiles = {
      personal = import ./personal;
    };

    preferences = {
      "browser.startup.page" = 3;
      "browser.urlbar.trimURLs" = false; # Don't trim www. and .com
      "extensions.pocket.enabled" = false; # Disable Pocket
      "media.autoplay.default" = 5; # Block autoplay by default
    };
    
    policies = {
      DisablePocket = true;
      DisplayBookmarksToolbar = true;
      DisableFirefoxStudies = true;
      DisableTelemetry = true;
      PasswordManagerEnabled = false;
      FirefoxHome = {
        Search = true;
        Pocket = false;
        Snippets = false;
        TopSites = false;
        Highlights = false;
        SponsoredPocket = false;
        SponsoredTopSites = false;
      };
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      languagePacks = ["en-US" "de"];

      ExtensionSettings = {
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };
        "firefox@ghostery.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ghostery/latest.xpi";
          installation_mode = "force_installed";
        };
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "sponsorBlocker@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          installation_mode = "force_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };

  bowl.persist.entries = [
    {path = ".mozilla/firefox";}
  ];
}
```


### /home/lf/nix/pkgs/nvim/lua/plugins/mini-ai-surround.lua
```lua
return { -- Collection of various small independent plugins/modules
  "echasnovski/mini.nvim",
  config = function()
    -- Better Around/Inside textobjects
    --  print "ssssrs"
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require("mini.ai").setup({ n_lines = 500 })

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require("mini.surround").setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    local statusline = require("mini.statusline")
    -- set use_icons to true if you have a Nerd Font
    statusline.setup({ use_icons = vim.g.have_nerd_font })

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return "%2l:%-2v"
    end

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
```


### /home/lf/nix/hosts/viech/home/firefox/personal/bookmarks.nix
```nix
 [
  {
    "name" = "Bookmarks";
    "bookmarks" = [
      {
        "name" = "Nutrition Seminars and Workshops";
        "url" = "https://lesliebeck.com/nutrition-services/nutrition-seminars-and-workshops";
      }
      {
        "name" = "10 Writing Ideas Concerning Women";
        "url" = "https://www.thoughtco.com/writing-ideas-concerning-women-31733";
      }
      {
        "name" = "Body, Mind, and Spirit | The Pioneer Woman";
        "url" = "https://thepioneerwoman.com/confessions/body-mind-and-spirit/";
      }
      {
        "name" = "5 Rules For The Spiritually Empowered Woman";
        "url" = "https://www.mindbodygreen.com/0-7694/5-rules-for-the-spiritually-empowered-woman.html";
      }
      {
        "name" = "Balancing Body, Mind and Spirit | Women's Radio Network";
        "url" = "http://www.womensradio.com/2019/05/balancing-body-mind-and-spirit/";
      }
      {
        "name" = "What happens to a woman’s body when she's raising kids, working, and trying to have it all - Business Insider";
        "url" = "https://www.businessinsider.com/nisha-jackson-womans-body-when-shes-raising-kids-working-have-it-all-2019-4";
      }
      {
        "name" = "Weight Training for Women = The Ultimate Strength Training Plan";
        "url" = "https://www.womenshealthmag.com/health/a19921596/weight-lifting-training-program/";
      }
      {
        "name" = "Women's Empowerment Seminar";
        "url" = "https://www.kravmaga.com/saam_2019/";
      }
      {
        "name" = "Seminars • MennoHenselmans.com";
        "url" = "https://mennohenselmans.com/seminar/";
      }
      {
        "name" = "Composerize";
        "url" = "https://www.composerize.com/";
      }
    ];
  }
  {
    "name" = "Bookmarks Toolbar";
    "toolbar" = true;
    "bookmarks" = [
      {
        "name" = "AI";
        "bookmarks" = [
          {
            "name" = "OpenAI tokenizer";
            "url" = "https://platform.openai.com/tokenizer";
          }
          {
            "name" = "Gemini";
            "url" = "https://gemini.google.com/app/250fbd46aa83c4cc";
          }
          {
            "name" = "Perplexity";
            "url" = "https://www.perplexity.ai/";
          }
          {
            "name" = "Chat Playground - OpenAI API";
            "url" = "https://platform.openai.com/playground/chat?models=gpt-4o";
          }
          {
            "name" = "Facebook";
            "url" = "https://www.facebook.com/ilja.sichrovsky";
          }
          {
            "name" = "YoutubeBuddy · Streamlit";
            "url" = "https://youtubebuddy.streamlit.app/";
          }
          {
            "name" = "Complete List of Prompts & Styles for Suno AI Music (2024) | by Travis Nicholson | Medium";
            "url" = "https://travisnicholson.medium.com/complete-list-of-prompts-styles-for-suno-ai-music-2024-33ecee85f180";
          }
          {
            "name" = "Untitled prompt | Google AI Studio";
            "url" = "https://aistudio.google.com/prompts/new_chat";
          }
        ];
      }
      {
        "name" = "$$$";
        "bookmarks" = [
          {
            "name" = "Trading";
            "bookmarks" = [
              {
                "name" = "IBI Trade (US)";
                "url" = "https://ibi.viewtrade.com/";
              }
              {
                "name" = "IBI Spark (IL)";
                "url" = "https://sparkibi.ordernet.co.il/#/auth";
              }
              {
                "name" = "Tradovate - Platform Knowledge Videos";
                "url" = "https://www.tradovate.com/videos/?utm_term=demo&utm_campaign=Demo%20to%20Customer%202019&utm_medium=Email&_hsmi=103430268&utm_content=Demo%20to%20Customer%20%233%20%E2%80%94%20Features&utm_source=email";
              }
              {
                "name" = "NextGen IBI";
                "url" = "https://ibi.orbisfn.io/login";
              }
              {
                "name" = "Tiger Brokers _ Hong Kong / U.S. Stock Market Quotes";
                "url" = "https://www.itiger.com/sg";
              }
              {
                "name" = "Interactive Brokers";
                "url" = "https://www.interactivebrokers.com/";
              }
              {
                "name" = "Swing Alerts | ClickCapital";
                "url" = "https://www.clickcapital.io/alerts-open-trades";
              }
              {
                "name" = "Stock Picks | ClickCapital";
                "url" = "https://www.clickcapital.io/stock-picks-members";
              }
            ];
          }
          {
            "name" = "Tools";
            "bookmarks" = [
              {
                "name" = "Yahoo Finance - Stock Market Live, Quotes, Business & Finance News";
                "url" = "https://finance.yahoo.com/";
              }
              {
                "name" = "ETF Screener | etf.com";
                "url" = "https://www.etf.com/etfanalytics/etf-screener";
              }
              {
                "name" = "ETF Tools - stockanalysis.com";
                "url" = "https://stockanalysis.com/etf/screener/";
              }
              {
                "name" = "ETF Research Center";
                "url" = "https://www.etfrc.com/index.php";
              }
              {
                "name" = "ETF Database = The Original & Comprehensive Guide to ETFs";
                "url" = "https://etfdb.com/";
              }
              {
                "name" = "SweepCast | Unusual Options Activity for Retail Traders - Follow Smart Money";
                "url" = "https://www.sweepcast.com/";
              }
            ];
          }
          {
            "name" = "Knowledge";
            "bookmarks" = [
              {
                "name" = "PineScript";
                "bookmarks" = [
                  {
                    "name" = "Pine Script™ v5 User Manual";
                    "url" = "https://www.tradingview.com/pine-script-docs/en/v5/Introduction.html";
                  }
                ]
              }
              {
                "name" = "Options";
                "bookmarks" = [
                  {
                    "name" = "Free Options Trading Courses | Option Alpha";
                    "url" = "https://optionalpha.com/courses";
                  }
                  {
                    "name" = "Learn to Trade & Invest = Insights, Resources";
                    "url" = "https://tastytrade.com/learn/";
                  }
                  {
                    "name" = "Introduction to Options - CME Group";
                    "url" = "https://www.cmegroup.com/education/courses/introduction-to-options.html";
                  }
                  {
                    "name" = "Option Strategies - CME Group";
                    "url" = "https://www.cmegroup.com/education/courses/option-strategies.html";
                  }
                  {
                    "name" = "Tools for Option Analysis - CME Group";
                    "url" = "https://www.cmegroup.com/education/courses/tools-for-option-analysis.html";
                  }
                ];
              }
              {
                "name" = "Bloomberg for Education";
                "url" = "https://portal.bloombergforeducation.com/";
              }
              {
                "name" = "Fixed Income";
                "bookmarks" = [
                  {
                    "name" = "The Basics of Treasuries Basis - CME Group";
                    "url" = "https://www.cmegroup.com/education/courses/introduction-to-treasuries/the-basics-of-treasuries-basis.html";
                  }
                ];
              }
              {
                "name" = "Analysis";
                "bookmarks" = [
                  {
                    "name" = "Technical Analysis - CME Group";
                    "url" = "https://www.cmegroup.com/education/courses/technical-analysis.html";
                  }
                  {
                    "name" = "Trading and Analysis - CME Group";
                    "url" = "https://www.cmegroup.com/education/courses/trading-and-analysis.html";
                  }
                ];
              }
              {
                "name" = "Learn about Key Economic Events - CME Group";
                "url" = "https://www.cmegroup.com/education/courses/learn-about-key-economic-events.html";
              }
              {
                "name" = "Trade and Risk Management - CME Group";
                "url" = "https://www.cmegroup.com/education/courses/trade-and-risk-management.html";
              }
              {
                "name" = "Introduction to Equity Index Products - CME Group";
                "url" = "https://www.cmegroup.com/education/courses/introduction-to-equity-index-products.html";
              }
              {
                "name" = "Futures vs. ETFs - CME Group";
                "url" = "https://www.cmegroup.com/education/courses/futures-vs-etfs.html";
              }
              {
                "name" = "Reddit";
                "bookmarks" = [
                  {
                    "name" = "Reddit - Dive into anything";
                    "url" = "https://www.reddit.com/r/RealDayTrading/wiki/index/";
                  }
                  {
                    "name" = "r/RealDayTrading";
                    "bookmarks" = [
                      {
                        "name" = "(5) Adding a Sector List and the Top 10 for each sector to a Trading View watchlist  = RealDayTrading";
                        "url" = "https://www.reddit.com/r/RealDayTrading/comments/18ap05y/adding_a_sector_list_and_the_top_10_for_each/";
                      }
                      {
                        "name" = "Sign in to TC2000®";
                        "url" = "https://www.tc2000.com/sign-in?webplatform=true&returnURL=https://webplatform.tc2000.com/RASHTML5Gateway/";
                      }
                      {
                        "name" = "(5) Sector scanner for Trading View  = RealDayTrading";
                        "url" = "https://www.reddit.com/r/RealDayTrading/comments/x8v8cd/sector_scanner_for_trading_view/";
                      }
                      {
                        "name" = "> Sector Relative Strength — Indicator by atlas54000 — TradingView";
                        "url" = "https://www.tradingview.com/script/fcSCAIv5-Sector-Relative-Strength/";
                      }
                      {
                        "name" = "(5) I \"Shorted Stupid\" and I Got Burned!  = RealDayTrading";
                        "url" = "https://www.reddit.com/r/RealDayTrading/comments/y24905/i_shorted_stupid_and_i_got_burned/";
                      }
                      {
                        "name" = "> (5) Bearish Trend Days. How To Spot Them and How To Trade Them  = RealDayTrading";
                        "url" = "https://www.reddit.com/r/RealDayTrading/comments/xy8756/bearish_trend_days_how_to_spot_them_and_how_to/";
                      }
                      {
                        "name" = ">> (10) Bearish Trend Days - How To Trade Them - YouTube";
                        "url" = "https://www.youtube.com/watch?v=kPfWxS12yUY";
                      }
                      {
                        "name" = "> (10) Why This Gap and Go Pattern Failed - YouTube";
                        "url" = "https://www.youtube.com/watch?v=FmhUYeGCGgU";
                      }
                      {
                        "name" = "(4) Simple RS Strategy using trendline (Great for newbies)  = RealDayTrading";
                        "url" = "https://www.reddit.com/r/RealDayTrading/comments/ty0tjw/simple_rs_strategy_using_trendline_great_for/";
                      }
                      {
                        "name" = "(5) A Tool For Compiling Your Market Rebound Picks  = RealDayTrading";
                        "url" = "https://www.reddit.com/r/RealDayTrading/comments/v5kjav/a_tool_for_compiling_your_market_rebound_picks/";
                      }
                      {
                        "name" = "(5) Analyzed 450 Trades - This might be helpful  = RealDayTrading";
                        "url" = "https://www.reddit.com/r/RealDayTrading/comments/t7li41/analyzed_450_trades_this_might_be_helpful/";
                      }
                      {
                        "name" = "(5) Need help with identifying institutional support.  = RealDayTrading";
                        "url" = "https://www.reddit.com/r/RealDayTrading/comments/16zzjun/need_help_with_identifying_institutional_support/";
                      }
                      {
                        "name" = "(5) Update to relative strength stock and sector script post  = RealDayTrading";
                        "url" = "https://www.reddit.com/r/RealDayTrading/comments/weuik4/update_to_relative_strength_stock_and_sector/";
                      }
                      {
                        "name" = "(5) Real Relative Strength to SECTOR Indicator + Auto Sector Selection [TOS/TV]  = RealDayTrading";
                        "url" = "https://www.reddit.com/r/RealDayTrading/comments/x9dwv0/real_relative_strength_to_sector_indicator_auto/";
                      }
                      {
                        "name" = "(5) Strong sector or strong stock?  = RealDayTrading";
                        "url" = "https://www.reddit.com/r/RealDayTrading/comments/10n9i59/strong_sector_or_strong_stock/";
                      }
                      {
                        "name" = "(5) Sector / Industry Strength Comparison on Tradingview  = RealDayTrading";
                        "url" = "https://www.reddit.com/r/RealDayTrading/comments/tiprot/sector_industry_strength_comparison_on_tradingview/";
                      }
                      {
                        "name" = "(5) (Expanded to *Most* Stocks) Real Relative Strength to SECTOR Indicator + Auto Sector Selection [TOS]  = RealDayTrading";
                        "url" = "https://www.reddit.com/r/RealDayTrading/comments/z02d6b/expanded_to_most_stocks_real_relative_strength_to/";
                      }
                      {
                        "name" = "(5) Stacked Stock/Sector/Market RS/RW Arrows for TradingView  = RealDayTrading";
                        "url" = "https://www.reddit.com/r/RealDayTrading/comments/z9u03i/stacked_stocksectormarket_rsrw_arrows_for/";
                      }
                      {
                        "name" = "(5) Question About Sector Performance  = RealDayTrading";
                        "url" = "https://www.reddit.com/r/RealDayTrading/comments/170uagf/question_about_sector_performance/";
                      }
                      {
                        "name" = "(5) Relative Strength to stock and sector indicator for TOS  = RealDayTrading";
                        "url" = "https://www.reddit.com/r/RealDayTrading/comments/wb3x7c/relative_strength_to_stock_and_sector_indicator/";
                      }
                      {
                        "name" = "(5) Sector / Industry Strength Comparison on Tradingview  = RealDayTrading";
                        "url" = "https://www.reddit.com/r/RealDayTrading/comments/tiprot/sector_industry_strength_comparison_on_tradingview/";
                      }
                      {
                        "name" = "(5) I \"Shorted Stupid\" and I Got Burned!  = RealDayTrading";
                        "url" = "https://www.reddit.com/r/RealDayTrading/comments/y24905/i_shorted_stupid_and_i_got_burned/";
                      }
                      {
                        "name" = "(5) A very handy way to pull financial data  = RealDayTrading";
                        "url" = "https://www.reddit.com/r/RealDayTrading/comments/11widn4/a_very_handy_way_to_pull_financial_data/";
                      }
                      {
                        "name" = "> Download | OpenBB Terminal";
                        "url" = "https://my.openbb.co/app/terminal/download";
                      }
                      {
                        "name" = "Real Relative Strength to SECTOR Indicator + Auto Sector Selection [TOS/TV]  = RealDayTrading";
                        "url" = "https://www.reddit.com/r/RealDayTrading/comments/x9dwv0/real_relative_strength_to_sector_indicator_auto/";
                      }
                    ];
                  }
                ]
              }
              {
                "name" = "Tools";
                "bookmarks" = [
                  {
                    "name" = "OpenBB Terminal Docs";
                    "url" = "https://docs.openbb.co/terminal";
                  }
                  {
                    "name" = "Order Types and Algos | Interactive Brokers LLC";
                    "url" = "https://www.interactivebrokers.com/en/trading/ordertypes.php";
                  }
                  {
                    "name" = "Basic Economics | Trading Course | Traders' Academy | IBKR Campus";
                    "url" = "https://ibkrcampus.com/trading-course/introduction-to-microeconomics/?src=_X_MAILING_ID&eid=_X_EID&blst=NL-TI_cps_artclbtn";
                  }
                  {
                    "name" = "Getting Started with TWS | Trading Lesson | Traders' Academy | IBKR Campus";
                    "url" = "https://ibkrcampus.com/trading-lessons/getting-started-with-tws/";
                  }
                  {
                    "name" = "בית פרטי/ קוטג', פרדס חנה כרכור | אלפי מודעות חדשות בכל יום!";
                    "url" = "https://www.yad2.co.il/realestate/item/qi61ryus?ad-location=Main+feed+listings&opened-from=Feed+view&component-type=main_feed&index=19&color-type=Grey";
                  }
                  {
                    "name" = "(1) Veena Krishnamurthy | LinkedIn";
                    "url" = "https://www.linkedin.com/in/veena-krishnamurthy/";
                  }
                ];
              }
              {
                "name" = "GitHub - wilsonfreitas/awesome-quant = A curated list of insanely awesome libraries, packages and resources for Quants (Quantitative Finance)";
                "url" = "https://github.com/wilsonfreitas/awesome-quant";
              }
              {
                "name" = "OCC - Investor Education";
                "url" = "https://www.theocc.com/company-information/investor-education";
              }
            ];
          }
          {
            "name" = "Platforms";
            "bookmarks" = [
              {
                "name" = "koyfin";
                "url" = "https://app.koyfin.com/home";
              }
            ];
          }
          {
            "name" = "Research";
            "bookmarks" = [
              {
                "name" = "Sectors";
                "bookmarks" = [
                  {
                    "name" = "Select Sector SPDR ETFs - Sector Spiders ETFs | SPDR S&P Stock";
                    "url" = "https://www.sectorspdrs.com/";
                  }
                ]
              }
            ];
          }
          {
            "name" = "Investopedia Stock Simulator";
            "url" = "https://www.investopedia.com/simulator/portfolio";
          }
          {
            "name" = "מדריכים וכלים של פעמונים - paamonim";
            "url" = "https://www.paamonim.org/he/%D7%9B%D7%9C%D7%99%D7%9D-%D7%95%D7%9E%D7%97%D7%A9%D7%91%D7%95%D7%A0%D7%99%D7%9D/";
          }
          {
            "name" = "TipRanks";
            "url" = "https://www.tipranks.com/dashboard";
          }
          {
            "name" = "(18) TWS Trading Tutorial | Order Types, Presets & Routing - YouTube and more (2024.03.10)";
            "bookmarks" = [
              {
                "name" = "(18) TWS Trading Tutorial | Order Types, Presets & Routing - YouTube";
                "url" = "https://www.youtube.com/watch?v=AMCNNNlK8D0&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=102&t=62s";
              }
              {
                "name" = "> (18) How to use Adjustable Stop and Scale Target Orders in TWS - YouTube";
                "url" = "https://www.youtube.com/watch?v=RYykmLiGbMU&t=493s";
              }
              {
                "name" = "> (18) How to use a Bracket Order in TWS (Stop-loss/Take Profit) - YouTube";
                "url" = "https://www.youtube.com/watch?v=b-x_cwH99C4&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=63";
              }
              {
                "name" = "> (18) How to Properly Use Margin with Interactive Brokers - YouTube";
                "url" = "https://www.youtube.com/watch?v=Y-MmaJKQHAk&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=85";
              }
              {
                "name" = "> (18) Interactive Brokers TWS Platform = How to trade directly from the Charts! - YouTube";
                "url" = "https://www.youtube.com/watch?v=SGSxig40mgY&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=101&t=390s";
              }
              {
                "name" = "> (18) How to FIX Your IBKR TWS Charts in 2 Minutes - YouTube";
                "url" = "https://www.youtube.com/watch?v=hrO3KoXs5MU&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=100";
              }
              {
                "name" = ">> (18) Step-by-Step TWS CHART Settings - (Interactive Brokers Tutorial) - YouTube";
                "url" = "https://www.youtube.com/watch?v=F1d8r-MWjfM&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=111";
              }
              {
                "name" = "> (18) 10 Tips & Tricks To Master Interactive Brokers - YouTube";
                "url" = "https://www.youtube.com/watch?v=HR0S-0sgb7o&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=108";
              }
              {
                "name" = ">> (18) Interactive Brokers Platform Tutorial for Day Trading 2023 (Level II, Hotkeys, Indicators etc) - YouTube";
                "url" = "https://www.youtube.com/watch?v=UWTWz2GZq30&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=106&t=866s";
              }
              {
                "name" = ">> (18) How to Set Up TWS layout/Interactive Brokers - YouTube";
                "url" = "https://www.youtube.com/watch?v=mYVnhTe2ce0&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=74";
              }
            ];
          }
        ];
      }
    ];
  }
]
```


### /home/lf/nix/hosts/viech/home/firefox/personal/default.nix
```nix
{
  bookmarks = import ./bookmarks.nix;
  settings = {

### /home/lf/nix/pkgs/nvim/lua/plugins/obsidian.lua
```lua
return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
    "browser.startup.homepage" = "https://nixos.org";
  };
}
```
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
    -- see below for full list of optional dependencies 👇
  },
  opts = {
    conccealleve = 1,
    workspaces = {
      {
        name = "personal",
        path = "~/Obsidian/Laurent",
      },
      {
        name = "work",
        path = "~/Obsidian/Brain/Vault",
      },
    },
  },


  log_level = vim.log.levels.INFO,

  daily_notes = {
    -- Optional, if you keep daily notes in a separate directory.
    folder = "Tracking/Daily",
    -- Optional, if you want to change the date format for the ID of daily notes.
    date_format = "YYYY-MM-DD",
    -- Optional, default tags to add to each new daily note created.
    default_tags = { "daily-notes" },
    -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
    template = nil,
  },

  completion = {
    nvim_cmp = true,
    min_chars = 2,
  },

  mappings = {},

  new_notes_location = "WIP",

  -- Optional, customize how wiki links are formatted. You can set this to one of:
  --  * "use_alias_only", e.g. '[[Foo Bar]]'
  --  * "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
  --  * "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
  --  * "use_path_only", e.g. '[[foo-bar.md]]'
  -- Or you can set it to a function that takes a table of options and returns a string, like this:
  wiki_link_func = function(opts)
    return require("obsidian.util").wiki_link_id_prefix(opts)
  end,

  -- Optional, customize how markdown links are formatted.
  markdown_link_func = function(opts)
    return require("obsidian.util").markdown_link(opts)
  end,

  -- Either 'wiki' or 'markdown'.
  preferred_link_style = "wiki",

  -- Optional, for templates (see below).
  templates = {
    folder = "templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
    -- A map for custom variables, the key should be the variable and the value a function
    substitutions = {},
  },

  -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
  -- URL it will be ignored but you can customize this behavior here.
  ---@param url string
  follow_url_func = function(url)
    -- Open the URL in the default web browser.
    vim.fn.jobstart({ "xdg-open", url }) -- linux
    vim.ui.open(url) -- need Neovim 0.10.0+
  end,

  -- Optional, by default when you use `:ObsidianFollowLink` on a link to an image
  -- file it will be ignored but you can customize this behavior here.
  ---@param img string
  follow_img_func = function(img)
    vim.fn.jobstart({ "xdg-open", url }) -- linux
  end,

  -- Optional, set to true if you use the Obsidian Advanced URI plugin.
  -- https://github.com/Vinzent03/obsidian-advanced-uri
  use_advanced_uri = true,

  -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
  open_app_foreground = false,

  picker = {
    -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
    name = "telescope.nvim",
    -- Optional, configure key mappings for the picker. These are the defaults.
    -- Not all pickers support all mappings.
    note_mappings = {
      -- Create a new note from your query.
      new = "<C-x>",
      -- Insert a link to the selected note.
      insert_link = "<C-l>",
    },
    tag_mappings = {
      -- Add tag(s) to current note.
      tag_note = "<C-x>",
      -- Insert a tag at the current location.
      insert_tag = "<C-l>",
    },
  },

  -- Optional, sort search results by "path", "modified", "accessed", or "created".
  -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
  -- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
  sort_by = "modified",
  sort_reversed = true,

  -- Set the maximum number of lines to read from notes on disk when performing certain searches.
  search_max_lines = 1000,

  -- Optional, determines how certain commands open notes. The valid options are:
  -- 1. "current" (the default) - to always open in the current window
  -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
  -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
  open_notes_in = "current",

  -- Optional, define your own callbacks to further customize behavior.
  callbacks = {
    -- Runs at the end of `require("obsidian").setup()`.
    ---@param client obsidian.Client
    post_setup = function(client) end,

    -- Runs anytime you enter the buffer for a note.
    ---@param client obsidian.Client
    ---@param note obsidian.Note
    enter_note = function(client, note) end,

    -- Runs anytime you leave the buffer for a note.
    ---@param client obsidian.Client
    ---@param note obsidian.Note
    leave_note = function(client, note) end,

    -- Runs right before writing the buffer for a note.
    ---@param client obsidian.Client
    ---@param note obsidian.Note
    pre_write_note = function(client, note) end,

    -- Runs anytime the workspace is set/changed.
    ---@param client obsidian.Client
    ---@param workspace obsidian.Workspace
    post_set_workspace = function(client, workspace) end,
  },

  -- Optional, configure additional syntax highlighting / extmarks.
  -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
  ui = {
    enable = true, -- set to false to disable all additional syntax features
    update_debounce = 200, -- update delay after a text change (in milliseconds)
    max_file_length = 5000, -- disable UI features for files with more than this many lines
    -- Define how various check-boxes are displayed
    checkboxes = {
      -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
      [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
      ["x"] = { char = "", hl_group = "ObsidianDone" },
      [">"] = { char = "", hl_group = "ObsidianRightArrow" },
      ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
      ["!"] = { char = "", hl_group = "ObsidianImportant" },
      -- Replace the above with this if you don't have a patched font:
      -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
      -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

      -- You can also add more custom ones...
    },
    -- Use bullet marks for non-checkbox lists.
    bullets = { char = "•", hl_group = "ObsidianBullet" },
    external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    -- Replace the above with this if you don't have a patched font:
    -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
    reference_text = { hl_group = "ObsidianRefText" },
    highlight_text = { hl_group = "ObsidianHighlightText" },
    tags = { hl_group = "ObsidianTag" },
    block_ids = { hl_group = "ObsidianBlockID" },
    hl_groups = {
      -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
      ObsidianTodo = { bold = true, fg = "#f78c6c" },
      ObsidianDone = { bold = true, fg = "#89ddff" },
      ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
      ObsidianTilde = { bold = true, fg = "#ff5370" },
      ObsidianImportant = { bold = true, fg = "#d73128" },
      ObsidianBullet = { bold = true, fg = "#89ddff" },
      ObsidianRefText = { underline = true, fg = "#c792ea" },
      ObsidianExtLinkIcon = { fg = "#c792ea" },
      ObsidianTag = { italic = true, fg = "#89ddff" },
      ObsidianBlockID = { italic = true, fg = "#89ddff" },
      ObsidianHighlightText = { bg = "#75662e" },
    },
  },

  -- Specify how to handle attachments.
  attachments = {
    img_folder = "00_Meta/Attachments",
    ---@return string
    img_name_func = function()
      -- Prefix image names with timestamp.
      return string.format("%s-", os.time())
    end,
    ---@param client obsidian.Client
    ---@param path obsidian.Path
    ---@return string
    img_text_func = function(client, path)
      path = client:vault_relative_path(path) or path
      return string.format("![%s](%s)", path.name, path)
    end,
  },
}
```


### /home/lf/nix/pkgs/nvim/lua/plugins/rainbow-delimiters.lua
```lua
return {
	"HiPhish/rainbow-delimiters.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("rainbow-delimiters.setup").setup({
			highlight = {
				"RainbowDelimiter1",
				"RainbowDelimiter2",
				"RainbowDelimiter3",
				"RainbowDelimiter4",
				"RainbowDelimiter5",
				"RainbowDelimiter6",
				"RainbowDelimiter7",
			},
		})
	end,
}
```


### /home/lf/nix/hosts/viech/home/fzf.nix
```nix
{
  pkgs,
  ...
}: {
  programs.fzf = {
    enable = true;
    package = pkgs.fzf;
    enableZshIntegration = true;
    defaultCommand = "fd --type f --hidden --follow --exclude .git"; # Matches _fzf_compgen_path
    defaultOptions = [
      "--preview='bat --style=numbers --color=always --line-range :500 {}'"
      "--preview-window 'right:70%:wrap'"
      "--border-label='File Picker'"
      "--layout=reverse"
      "--border=none"
      "--info='hidden'"
      "--header=''"
      "--prompt='/ '"
      "-i"
      "--no-bold"
      "--bind='enter:execute(nvim {})'"
    ];
    fileWidgetCommand = "fd --type f --hidden --follow --exclude .git"; # Matches _fzf_compgen_path
    fileWidgetOptions = [
      "--preview 'bat --color=always {}'"
      "--preview-window '70%:wrap'"
      "--border-label='File Picker'"
    ];
    changeDirWidgetCommand = "fd --type d --hidden --follow --exclude .git"; # Matches _fzf_compgen_dir
    changeDirWidgetOptions = [
      "--preview 'lsd -a --tree --directory-only --color=always {}'"
      "--preview-window '70%:wrap'"
      "--border-label='Dir Jump'"
    ];
    historyWidgetOptions = [
      "--border-label='History Search'"
    ];
    colors = {
        fg = "#C6D0F5";
        "fg+" = "#C6D0F5";
        bg = "#303446";
        "bg+" = "#51576D";
        hl = "#E78284";
        "hl+" = "#E78284";
        info = "#CA9EE6";
        marker = "#BABBF1";
        prompt = "#CA9EE6";
        spinner = "#F2D5CF";
        pointer = "#F2D5CF";
        header = "#E78284";
        gutter = "#262626";
        border = "#414559";
        separator = "#4b4646";
        scrollbar = "#a22b2b";
        preview-bg = "#414559";
        preview-border = "#4b4646";
        label = "#C6D0F5";
        query = "#d9d9d9";
    };
  };

  # home.packages = with pkgs; [
  #   zinit # For managing fzf-tab and fzf-zsh-plugin
  # ];

  # # Manage custom fzf configurations in ~/.config/zsh/fzf.zsh
  # home.file.".config/zsh/fzf.zsh".text = ''
  #   # fzf-tab Zsh plugin
  #   source ${pkgs.fetchFromGitHub {
  #     owner = "Aloxaf";
  #     repo = "fzf-tab";
  #     rev = "v1.1.2"; # Pin to a specific version
  #     sha256 = "sha256-9p2B4eO8uV6j6gUqIuG4gN6P4I24Y3o1L4e6V4Vq8I=";
  #   }}/fzf-tab.zsh

  #   # unixorn/fzf-zsh-plugin
  #   source ${pkgs.fetchFromGitHub {
  #     owner = "unixorn";
  #     repo = "fzf-zsh-plugin";
  #     rev = "v1.0.0"; # Pin to a specific version
  #     sha256 = "sha256-0gP1K9P+9z9z9z9z9z9z9z9z9z9z9z9z9z9z9z9z9z="; # Replace with actual hash
  #   }}/fzf-zsh-plugin.zsh

  #   # fzf-tab zstyle configurations
  #   zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'lsd -a --color=always $realpath'
  #   zstyle ':fzf-tab:*' fzf-bindings 'space:accept'
  #   zstyle ':fzf-tab:*' print-query ctrl-c
  #   zstyle ':fzf-tab:*' single-group color header
  #   zstyle ':fzf-tab:complete:(cat|nvim|cp|rm|bat):*' fzf-preview 'bat --color=always -- "$realpath" 2>/dev/null || lsd -a --color=always -- "$realpath"'
  #   zstyle ':fzf-tab:complete:nvim:*' fzf-flags --preview-window=right:65%
  #   zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
  #   zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

  #   # Aliases
  #   alias zf='z "$(zoxide query -l | fzf --preview "ls --color {}" --preview-window "70%:wrap" --border-label="Dir Jump")"'
  #   alias gv="git grep --line-number . | fzf --delimiter : --nth 3.. --bind 'enter:become(nvim {1} +{2})' --border-label='Git Grep'"
  #   alias dfz='docker ps -a | fzf --multi --header "Select container" --preview "docker inspect {1}" --preview-window "40%:wrap" --border-label="Docker Select" | awk "{print \$1}" | xargs -I {} docker start {}'
  #   alias of='fd .md $HOME/Obsidian/ | sed "s|$HOME/Obsidian/||" | fzf --preview "bat --color=always $HOME/Obsidian/{1}" --preview-window "50%:wrap" --border-label="Obsidian Files" --bind "enter:become(nvim $HOME/Obsidian/{1})"'
  #   alias rgf='rg --line-number --no-heading . | fzf --delimiter : --preview "bat --color=always {1} --highlight-line {2}" --preview-window "70%:wrap" --border-label="Ripgrep Files" --bind "enter:become(nvim {1} +{2})"'
  #   alias v='fzf --preview --border-label="Open in Vim" "bat --color always {}" --preview-window "70%:wrap" --multi --bind "enter:become(vim {+})"'
  #   alias mans='man -k . | fzf --border-label="Man Pages" | awk "{print \$1}" | xargs -r man'

  #   # Functions
  #   _fzf_compgen_path() {
  #     fd --hidden --follow --exclude ".git" . "$1"
  #   }

  #   _fzf_compgen_dir() {
  #     fd --type d --hidden --follow --exclude ".git" . "$1"
  #   }

  #   rga-fzf() {
  #     RG_PREFIX="rga --files-with-matches"
  #     local file
  #     file="$(
  #       FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
  #         fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
  #           --phony -q "$1" \
  #           --bind "change:reload:$RG_PREFIX {q}" \
  #           --preview-window="70%:wrap"
  #     )" &&
  #     echo "opening $file" &&
  #     xdg-open "$file"
  #   }

  #   _fzf_docker_select_container() {
  #     docker ps --format "{{.Names}}" | fzf --height=20% --layout=reverse --prompt="Select Container > "
  #   }

  #   dfd() {
  #     local container
  #     container=$(_fzf_docker_select_container)
  #     [ -z "$container" ] && return 1
  #     local finder_cmd="fd . /"
  #     docker exec "$container" which fd >/dev/null 2>&1 || finder_cmd="find / -mindepth 1"
  #     local previewer_cmd="bat --color=always --plain {}"
  #     docker exec "$container" which bat >/dev/null 2>&1 || previewer_cmd="cat {}"
  #     docker exec "$container" sh -c "$finder_cmd 2>/dev/null" | fzf \
  #       --prompt "Finding files in '$container' > " \
  #       --preview "docker exec '$container' sh -c \"$previewer_cmd\"" \
  #       --preview-window "right:60%:wrap"
  #   }

  #   drg() {
  #     if [ -z "$1" ]; then
  #       echo "Usage: drg <search_pattern>"
  #       return 1
  #     fi
  #     local container
  #     container=$(_fzf_docker_select_container)
  #     [ -z "$container" ] && return 1
  #     local searcher_cmd="rg --line-number --no-heading --color=always '$1' /"
  #     docker exec "$container" which rg >/dev/null 2>&1 || searcher_cmd="grep -I -RHn '$1' /"
  #     local previewer_cmd="bat --color=always --highlight-line {2} {1}"
  #     docker exec "$container" which bat >/dev/null 2>&1 || previewer_cmd="cat {1}"
  #     docker exec "$container" sh -c "$searcher_cmd 2>/dev/null" | fzf \
  #       --prompt "Searching for '$1' in '$container' > " \
  #       --delimiter ":" \
  #       --preview "docker exec '$container' sh -c \"$previewer_cmd\"" \
  #       --preview-window "right:60%:wrap"
  #   }

  #   dfx() {
  #     local container
  #     container=$(_fzf_docker_select_container)
  #     [ -z "$container" ] && return 1
  #     local finder_cmd="fd --extension json --extension yml --extension yaml . /"
  #     docker exec "$container" which fd >/dev/null 2>&1 || finder_cmd="find / -mindepth 1 -name '*.json' -o -name '*.yml' -o -name '*.yaml'"
  #     docker exec "$container" sh -c "$finder_cmd 2>/dev/null" | fzf \
  #       --prompt "Select a JSON/YAML file in '$container' > " \
  #       --bind "enter:become(docker exec '$container' cat {} | fx)"
  #   }

  #   dsh() {
  #     local container
  #     container=$(_fzf_docker_select_container)
  #     [ -z "$container" ] && return 1
  #     local rootfs
  #     rootfs=$(docker inspect -f '{{.GraphDriver.Data.MergedDir}}' "$container")
  #     if [ -z "$rootfs" ]; then
  #       echo "Error: Could not find root filesystem for container '$container'." >&2
  #       return 1
  #     fi
  #     local pid
  #     pid=$(docker inspect -f '{{.State.Pid}}' "$container")
  #     sudo nsenter -t "$pid" -n --wd="$rootfs" chroot "$rootfs" "$SHELL"
  #     echo "Exited container '$container'."
  #   }
  # '';
}
```


### /home/lf/nix/pkgs/nvim/lua/plugins/treesj.lua
```lua
return {
  "Wansmer/treesj",

### /home/lf/nix/hosts/viech/home/lsd.nix
```nix
{
  pkgs,
  ...
}: {
  programs.lsd = {
    enable = true;
  keys = { "<space>m", "<space>j", "<space>h" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    enableZshIntegration= true;
    package = pkgs.lsd;
    settings = {
      date = "relative"; # Show relative dates
      icons = {
    require("treesj").setup({--[[ your config ]]
    })
  end,
}
```
        when = "auto"; # Auto-detect icon support
        theme = "fancy"; # Use fancy icons
      };
    };
  };
}
```



### /home/lf/nix/pkgs/nvim/lua/plugins/yanky.lua
```lua
-- plugins/yanky.lua
return {
  "gbprod/yanky.nvim",

### /home/lf/nix/hosts/viech/home/vscode.nix
```nix
{
  pkgs,
  ...
}: {
    programs.vscode = {
    enable = true;
  dependencies = {
    { "nvim-telescope/telescope.nvim" }, -- Required for yank_history picker
  },
  opts = {
    ring = {
    package = pkgs.vscode;

    # Define your VS Code settings here
    profiles.default = {
      userSettings = {
      history_length = 100,
      storage = "shada",
      sync_with_numbered_registers = true,
      cancel_event = "update",
        "editor.fontFamily" = "FantasqueSansM Nerd Font Mono Italic";
        "editor.fontVariations" = "Medium Italic";
      ignore_registers = { "_" },
      update_register_on_cycle = false,
    },
    picker = {
      select = {
        "editor.fontLigatures" = "'calt', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'zero', 'onum'";
        #"editor.fontLigatures" = true;
        action = nil, -- Default put action
      },
      telescope = {
        use_default_mappings = true, -- Use default Telescope mappings
        "editor.tabSize" = 2;
        "[docker-compose]" = {
          "editor.defaultFormatter" = "KilianJPopp.docker-compose-support";
        mappings = nil,
      },
    },
    system_clipboard = {
      sync_with_ring = true,
    },
    highlight = {
      on_put = true,
          "editor.formatOnSave" = true;
        };
        "docker-compose.format.enabled" = true;
      on_yank = true,
      timer = 300, -- 300ms highlight duration
    },
    preserve_cursor_position = {
      enabled = true,
        "nix.serverPath" = "nixd";
        "nix.enableLanguageServer" = true;
        "nix.serverSettings" = {
    },
    textobj = {
      enabled = true, -- Enable text object for last put
    },
  },
  keys = {
          "nixd.formatting.command" = ["alejandra"];
        };
        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
    -- Yank and history navigation
    { "<leader>p", "<cmd>Telescope yank_history<cr>", mode = { "n", "x" }, desc = "Open Yank History" },
          "editor.formatOnSave" = true;
        };
        "git.openRepositoryInParentFolders" = "always";
        "workbench.iconTheme" = "vscode-icons";
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
        "vsicons.dontShowNewVersionMessage" = true;
        "workbench.colorTheme" = "Catppuccin Mocha";
    { "<c-p>", "<Plug>(YankyPreviousEntry)", mode = { "n" }, desc = "Previous yank history" },
    { "<c-n>", "<Plug>(YankyNextEntry)", mode = { "n" }, desc = "Next yank history" },
    -- Basic puts
        "python.defaultInterpreterPath" = "${pkgs.python312}/bin/python3";
      };
      languageSnippets = {
        python = {
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put after cursor" },
          "AI3 Header" = {
            "body" = [
              "\"\"\""
              "Title = \${1: 'Enter a Title'}"
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put before cursor" },
              "\${2|Exercise,Quiz|} = $3"
              "Description = \${4: 'And now a description'}"
              ""
              "Author = Laurent Flaster"
              "Reviewer = \${6: 'Lucky who?'}"
              ""
              "Infinity Labs R&D AI3"
              "\"\"\""
    { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put after selection" },
    { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put before selection" },
    -- Linewise puts
              ""
              "\${7: import} $0"
            ];
            "description" = ["Insert AI3 Doc string."];
    { "]p", "<Plug>(YankyPutIndentAfterLinewise)", mode = { "n" }, desc = "Put indented after (linewise)" },
            "prefix" = ["ai3"];
          };
        };
      };
      extensions = with pkgs.vscode-extensions; [
    { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", mode = { "n" }, desc = "Put indented before (linewise)" },
        vscode-icons-team.vscode-icons
        github.copilot
        github.copilot-chat
        ms-python.python
        ms-python.debugpy
    { "]P", "<Plug>(YankyPutIndentAfterLinewise)", mode = { "n" }, desc = "Put indented after (linewise)" },
        charliermarsh.ruff
        # ms-python.pylint
        ms-python.vscode-pylance
        ms-python.mypy-type-checker
    { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", mode = { "n" }, desc = "Put indented before (linewise)" },
    -- Indent shift puts
        jnoortheen.nix-ide
        kamadorueda.alejandra
        jeff-hykin.better-nix-syntax
        sumneko.lua
        ms-toolsai.jupyter
    { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", mode = { "n" }, desc = "Put and indent right" },
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.jupyter-keymap
        ms-azuretools.vscode-docker
    { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", mode = { "n" }, desc = "Put and indent left" },
        bungcip.better-toml
        zainchen.json
        vscodevim.vim
        visualstudioexptteam.intellicode-api-usage-examples
        tekumara.typos-vscode
        rubymaniac.vscode-paste-and-indent
        richie5um2.snake-trail
        naumovs.color-highlight
    { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", mode = { "n" }, desc = "Put before and indent right" },
    { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", mode = { "n" }, desc = "Put before and indent left" },
        mongodb.mongodb-vscode
        mishkinf.goto-next-previous-member
        catppuccin.catppuccin-vsc
    -- Filter puts
    { "=p", "<Plug>(YankyPutAfterFilter)", mode = { "n" }, desc = "Put after with reindent" },
        njpwerner.autodocstring
      ];
    };
  };
}
```
    { "=P", "<Plug>(YankyPutBeforeFilter)", mode = { "n" }, desc = "Put before with reindent" },
    -- Text object for last put
    {
      "iy",
      function()
        require("yanky.textobj").last_put()
      end,
      mode = { "o", "x" },
      desc = "Select last put text",

    },
  },
  config = function(_, opts)
    require("yanky").setup(opts)
    -- Load Telescope yank_history extension
    pcall(require("telescope").load_extension, "yank_history")
  end,
}
```


### /home/lf/nix/hosts/viech/home/zed/default.nix
```nix
{pkgs, ...} @ args: {
  programs.zed-editor = {
    enable = true;
    extraPackages = with pkgs; [
      nil
      nixd
      package-version-server
      rust-analyzer
    ];

    userSettings = import ./settings.nix args;
    extensions = [
      # Languages
      "nix"

      # Styles
      "rose-pine-theme"
    ];
  };

  bowl.persist.entries = [
    {path = ".cache/zed";}
    {path = ".local/share/zed";}
  ];
}
```


### /home/lf/nix/hosts/viech/home/zed/settings.nix
```nix
{
  lib,
  pkgs,
  osConfig,
  config,
  ...
}: let
  inherit (lib) getExe mkForce;

  inherit (osConfig.bowl.users.${config.home.username}) shell;
in {
  theme = mkForce "Rosé Pine Moon";

  telemetry.metrics = false;
  inlay_hints.enabled = true;

  diagnostics = {
    inline.enabled = true;
  };

  terminal.shell.program = getExe shell;

  languages = {
    Nix = {
      formatter.external = {
        command = getExe pkgs.alejandra;
        args = ["--quiet" "--"];
      };
    };
  };
}
```


### /home/lf/nix/keys.txt
```text
# created: 2025-06-29T17:21:51+03:00
# public key: age1anx3dfzwps6elvqvulknu548640y7m9a60j4glvzlk3r2jvs4vmsca2avr
AGE-SECRET-KEY-1Q4GNV2S49SQA372LW8AMC0GX6NPMA8V4LM7KH4U45LYGFV2H3UDQ9359NW
```


### /home/lf/nix/hosts/viech/users.nix
```nix
{
  pkgs,
  username,
  ...
}:
# users.nix
{
  users = {
    mutableUsers = true;
    users."${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "Laurent Flaster";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
        "video"
        "input"
        "audio"
        "docker"
      ];
    };
    defaultUserShell = pkgs.zsh;
  };

  #  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [
    lsd
    bat
    fd
    fzf
    ripgrep
    grip-grab
    repgrep
    ripgrep-all
  ];
  systemd.user.services.install-pre-commit = {
    description = "Install pre-commit hooks for dotfiles";
    wantedBy = ["default.target"];
    script = ''
      ${pkgs.pre-commit}/bin/pre-commit install --install-dir $HOME/NixOS-Hyprland
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      PrivateTmp = false;
      ProtectHome = false;
    };
  };
}
```


### /home/lf/nix/modules/amd-drivers.nix
```nix
# 💫 https://github.com/JaKooLit 💫 #

{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.drivers.amdgpu;
in
{
  options.drivers.amdgpu = {
    enable = mkEnableOption "Enable AMD Drivers";
  };

  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
    services.xserver.videoDrivers = [ "amdgpu" ];
  
    # OpenGL
    hardware.graphics = {
      extraPackages = with pkgs; [
        libva
			  libva-utils
        ];
    };
  };
}
```


### /home/lf/nix/modules/home-manager.nix
```nix
{ inputs, username, system, ... }: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      extraSpecialArgs = { inherit inputs username system; };
      users.${username} = {
        imports = [ ../hosts/lf-nix/home.nix ];
      };
    };
  }
```


### /home/lf/nix/modules/local-hardware-clock.nix
```nix
# 💫 https://github.com/JaKooLit 💫 #

{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.local.hardware-clock;
in
{
  options.local.hardware-clock = {
    enable = mkEnableOption "Change Hardware Clock To Local Time";
  };

  config = mkIf cfg.enable { time.hardwareClockInLocalTime = true; };
}
```


### /home/lf/nix/modules/nvidia-drivers.nix
```nix
# 💫 https://github.com/JaKooLit 💫 #

{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.drivers.nvidia;
in
{
  options.drivers.nvidia = {
    enable = mkEnableOption "Enable Nvidia Drivers";
  };

  config = mkIf cfg.enable {
    services.xserver.videoDrivers = [ "nvidia" ];
    
  hardware.graphics = {
  	enable = true;
  	enable32Bit = true;
	  extraPackages = with pkgs; [
	    vaapiVdpau
  	  libvdpau
  	  libvdpau-va-gl 
  	  nvidia-vaapi-driver
  	  vdpauinfo
	    libva
 		  libva-utils	
    	];
  	};

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;
      
    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
      
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;
      
    #dynamicBoost.enable = true; # Dynamic Boost

    nvidiaPersistenced = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;
      
    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
      
    nvidiaSettings = true;
      
    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };
}
```


### /home/lf/nix/modules/nvidia-prime-drivers.nix
```nix
# 💫 https://github.com/JaKooLit 💫 #

{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.drivers.nvidia-prime;
in
{
  options.drivers.nvidia-prime = {
    enable = mkEnableOption "Enable Nvidia Prime Hybrid GPU Offload";
    intelBusID = mkOption {
      type = types.str;
      default = "PCI:1:0:0";
    };
    nvidiaBusID = mkOption {
      type = types.str;
      default = "PCI:0:2:0";
    };
  };

  config = mkIf cfg.enable {
    hardware.nvidia = {
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        # Make sure to use the correct Bus ID values for your system!
        intelBusId = "${cfg.intelBusID}";
        nvidiaBusId = "${cfg.nvidiaBusID}";
      };
    };
  };
}
```


### /home/lf/nix/modules/vm-guest-services.nix
```nix
# 💫 https://github.com/JaKooLit 💫 #

{ lib, pkgs, config, ... }:
with lib;
let
  cfg = config.vm.guest-services;
in
{
  options.vm.guest-services = {
    enable = mkEnableOption "Enable Virtual Machine Guest Services";
  };

  config = mkIf cfg.enable {
    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true;
    services.spice-webdavd.enable = true;
  };
}
```


### /home/lf/nix/pkgs/bat.nix
```nix
{pkgs, ...}: {
  programs.bat = {
    enable = true;
    themes = {
      dracula = {
        src = pkgs.fetchFromGitHub {
          owner = "dracula";
          repo = "sublime"; # Bat uses sublime syntax for its themes
          rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
          sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
        };
        file = "Dracula.tmTheme";
      };
    };
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      prettybat
      batwatch
    ];
  };
}
```


### /home/lf/nix/pkgs/cli.nix
```nix
{
  lib,
  config,
  ...
}: {
  programs = {
    micro = {
      enable = true;
      settings = {
        clipboard = "internal";
        colorscheme = "one-dark";
        diffgutter = true;
        indentchar = "space";
        scrollbar = true;
      };
    };

    kitty = {
      enable = true;
      font = {
        name = "Maple Mono NF Italic";
        size = 14;
      };
    };

    eza = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      extraOptions = [
        "--classify"
        "--color-scale"
        "--git"
        "--group-directories-first"
      ];
    };

    htop = {
      enable = true;
      settings =
        {
          tree_view = 1;
          hide_kernel_threads = 1;
          hide_userland_threads = 1;
          shadow_other_users = 1;
          show_thread_names = 1;
          show_program_path = 0;
          highlight_base_name = 1;
          header_layout = "two_67_33";
          color_scheme = 6;
        }
        // (with config.lib.htop; leftMeters [(bar "AllCPUs4")])
        // (
          with config.lib.htop;
            rightMeters [
              (bar "Memory")
              (bar "Swap")
              (bar "DiskIO")
              (bar "NetworkIO")
              (text "Systemd")
              (text "Tasks")
              (text "LoadAverage")
            ]
        );
    };

    zellij = {
      enable = true;
      enableZshIntegration = false;
      settings = {
        theme = "one-half-dark";
        themes.one-half-dark = {
          bg = [
            40
            44
            52
          ];
          gray = [
            40
            44
            52
          ];
          red = [
            227
            63
            76
          ];
          green = [
            152
            195
            121
          ];
          yellow = [
            229
            192
            123
          ];
          blue = [
            97
            175
            239
          ];
          magenta = [
            198
            120
            221
          ];
          orange = [
            216
            133
            76
          ];
          fg = [
            220
            223
            228
          ];
          cyan = [
            86
            182
            194
          ];
          black = [
            27
            29
            35
          ];
          white = [
            233
            225
            254
          ];
        };
      };
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };

    # for nushell wrapper to pick up HM things
    #bash.enable = true;
    fish.enable = true; # only for nushell completions really
    carapace = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    nushell = {
      enable = true;
    };

    man.enable = lib.mkDefault false;

    ripgrep = {
      enable = true;
      arguments = [
        "--smart-case"
        "--pretty"
      ];
    };
  };

  manual = {
    html.enable = true;
    manpages.enable = true;
  };
}
```


### /home/lf/nix/hosts/viech/home/one-dark.colorscheme
```
[Background]
Color=40,44,52

[BackgroundFaint]
Color=40,44,52

[BackgroundIntense]
Color=40,44,52

[Color0]
Color=40,44,52

[Color0Faint]
Color=40,44,52

[Color0Intense]
Color=40,44,52

[Color1]
Color=224,108,117

[Color1Faint]
Color=224,108,117

[Color1Intense]
Color=224,108,117

[Color2]
Color=152,195,121

[Color2Faint]
Color=152,195,121

[Color2Intense]
Color=152,195,121

[Color3]
Color=229,192,123

[Color3Faint]
Color=229,192,123

[Color3Intense]
Color=229,192,123

[Color4]
Color=97,175,239

[Color4Faint]
Color=97,175,239

[Color4Intense]
Color=97,175,239

[Color5]
Color=198,120,221

[Color5Faint]
Color=198,120,221

[Color5Intense]
Color=198,120,221

[Color6]
Color=86,182,194

[Color6Faint]
Color=86,182,194

[Color6Intense]
Color=86,182,194

[Color7]
Color=220,223,228

[Color7Faint]
Color=220,223,228

[Color7Intense]
Color=220,223,228

[Foreground]
Color=171,178,191

[ForegroundFaint]
Color=92,99,112

[ForegroundIntense]
Color=130,137,151

[General]
Description=One Dark
Opacity=1
Wallpaper=
```


### /home/lf/nix/pkgs/firefox.nix
```nix
{
  pkgs,
  inputs,
  username,
  ...
}
: {
  programs.firefox = {
    enable = true;
    languagePacks = ["en-US" "de" "fr"];
    profiles = {
      personal = {
        extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
          ublock-origin
          privacy-badger
          ghostery
          sponsorblock
          bitwarden
          pushbullet
          tab-session-manager
          stylus
          web-clipper-obsidian
          catppuccin-web-file-icons
          catppuccin-mocha-mauve
        ];
        settings = {
          "browser.startup.homepage" = "https://nixos.org";
        };
      };
      bookmarks = [
        {
          "name" = "Bookmarks";
          "bookmarks" = [
            {
              "name" = "Nutrition Seminars and Workshops";
              "url" = "https://lesliebeck.com/nutrition-services/nutrition-seminars-and-workshops";
            }
            {
              "name" = "10 Writing Ideas Concerning Women";
              "url" = "https://www.thoughtco.com/writing-ideas-concerning-women-31733";
            }
            {
              "name" = "Body, Mind, and Spirit | The Pioneer Woman";
              "url" = "https://thepioneerwoman.com/confessions/body-mind-and-spirit/";
            }
            {
              "name" = "5 Rules For The Spiritually Empowered Woman";
              "url" = "https://www.mindbodygreen.com/0-7694/5-rules-for-the-spiritually-empowered-woman.html";
            }
            {
              "name" = "Balancing Body, Mind and Spirit | Women's Radio Network";
              "url" = "http://www.womensradio.com/2019/05/balancing-body-mind-and-spirit/";
            }
            {
              "name" = "What happens to a woman’s body when she's raising kids, working, and trying to have it all - Business Insider";
              "url" = "https://www.businessinsider.com/nisha-jackson-womans-body-when-shes-raising-kids-working-have-it-all-2019-4";
            }
            {
              "name" = "Weight Training for Women = The Ultimate Strength Training Plan";
              "url" = "https://www.womenshealthmag.com/health/a19921596/weight-lifting-training-program/";
            }
            {
              "name" = "Women's Empowerment Seminar";
              "url" = "https://www.kravmaga.com/saam_2019/";
            }
            {
              "name" = "Seminars • MennoHenselmans.com";
              "url" = "https://mennohenselmans.com/seminar/";
            }
            {
              "name" = "Composerize";
              "url" = "https://www.composerize.com/";
            }
          ];
        }
        {
          "name" = "Bookmarks Toolbar";
          "toolbar" = true;
          "bookmarks" = [
            {
              "name" = "AI";
              "bookmarks" = [
                {
                  "name" = "OpenAI tokenizer";
                  "url" = "https://platform.openai.com/tokenizer";
                }
                {
                  "name" = "Gemini";
                  "url" = "https://gemini.google.com/app/250fbd46aa83c4cc";
                }
                {
                  "name" = "Perplexity";
                  "url" = "https://www.perplexity.ai/";
                }
                {
                  "name" = "Chat Playground - OpenAI API";
                  "url" = "https://platform.openai.com/playground/chat?models=gpt-4o";
                }
                {
                  "name" = "Facebook";
                  "url" = "https://www.facebook.com/ilja.sichrovsky";
                }
                {
                  "name" = "YoutubeBuddy · Streamlit";
                  "url" = "https://youtubebuddy.streamlit.app/";
                }
                {
                  "name" = "Complete List of Prompts & Styles for Suno AI Music (2024) | by Travis Nicholson | Medium";
                  "url" = "https://travisnicholson.medium.com/complete-list-of-prompts-styles-for-suno-ai-music-2024-33ecee85f180";
                }
                {
                  "name" = "Untitled prompt | Google AI Studio";
                  "url" = "https://aistudio.google.com/prompts/new_chat";
                }
              ];
            }
            {
              "name" = "$$$";
              "bookmarks" = [
                {
                  "name" = "Trading";
                  "bookmarks" = [
                    {
                      "name" = "IBI Trade (US)";
                      "url" = "https://ibi.viewtrade.com/";
                    }
                    {
                      "name" = "IBI Spark (IL)";
                      "url" = "https://sparkibi.ordernet.co.il/#/auth";
                    }
                    {
                      "name" = "Tradovate - Platform Knowledge Videos";
                      "url" = "https://www.tradovate.com/videos/?utm_term=demo&utm_campaign=Demo%20to%20Customer%202019&utm_medium=Email&_hsmi=103430268&utm_content=Demo%20to%20Customer%20%233%20%E2%80%94%20Features&utm_source=email";
                    }
                    {
                      "name" = "NextGen IBI";
                      "url" = "https://ibi.orbisfn.io/login";
                    }
                    {
                      "name" = "Tiger Brokers _ Hong Kong / U.S. Stock Market Quotes";
                      "url" = "https://www.itiger.com/sg";
                    }
                    {
                      "name" = "Interactive Brokers";
                      "url" = "https://www.interactivebrokers.com/";
                    }
                    {
                      "name" = "Swing Alerts | ClickCapital";
                      "url" = "https://www.clickcapital.io/alerts-open-trades";
                    }
                    {
                      "name" = "Stock Picks | ClickCapital";
                      "url" = "https://www.clickcapital.io/stock-picks-members";
                    }
                  ];
                }
                {
                  "name" = "Tools";
                  "bookmarks" = [
                    {
                      "name" = "Yahoo Finance - Stock Market Live, Quotes, Business & Finance News";
                      "url" = "https://finance.yahoo.com/";
                    }
                    {
                      "name" = "ETF Screener | etf.com";
                      "url" = "https://www.etf.com/etfanalytics/etf-screener";
                    }
                    {
                      "name" = "ETF Tools - stockanalysis.com";
                      "url" = "https://stockanalysis.com/etf/screener/";
                    }
                    {
                      "name" = "ETF Research Center";
                      "url" = "https://www.etfrc.com/index.php";
                    }
                    {
                      "name" = "ETF Database = The Original & Comprehensive Guide to ETFs";
                      "url" = "https://etfdb.com/";
                    }
                    {
                      "name" = "SweepCast | Unusual Options Activity for Retail Traders - Follow Smart Money";
                      "url" = "https://www.sweepcast.com/";
                    }
                  ];
                }
                {
                  "name" = "Knowledge";
                  "bookmarks" = [
                    {
                      "name" = "PineScript";
                      "bookmarks" = [
                        {
                          "name" = "Pine Script™ v5 User Manual";
                          "url" = "https://www.tradingview.com/pine-script-docs/en/v5/Introduction.html";
                        }
                      ];
                    }
                    {
                      "name" = "Options";
                      "bookmarks" = [
                        {
                          "name" = "Free Options Trading Courses | Option Alpha";
                          "url" = "https://optionalpha.com/courses";
                        }
                        {
                          "name" = "Learn to Trade & Invest = Insights, Resources";
                          "url" = "https://tastytrade.com/learn/";
                        }
                        {
                          "name" = "Introduction to Options - CME Group";
                          "url" = "https://www.cmegroup.com/education/courses/introduction-to-options.html";
                        }
                        {
                          "name" = "Option Strategies - CME Group";
                          "url" = "https://www.cmegroup.com/education/courses/option-strategies.html";
                        }
                        {
                          "name" = "Tools for Option Analysis - CME Group";
                          "url" = "https://www.cmegroup.com/education/courses/tools-for-option-analysis.html";
                        }
                      ];
                    }
                    {
                      "name" = "Bloomberg for Education";
                      "url" = "https://portal.bloombergforeducation.com/";
                    }
                    {
                      "name" = "Fixed Income";
                      "bookmarks" = [
                        {
                          "name" = "The Basics of Treasuries Basis - CME Group";
                          "url" = "https://www.cmegroup.com/education/courses/introduction-to-treasuries/the-basics-of-treasuries-basis.html";
                        }
                      ];
                    }
                    {
                      "name" = "Analysis";
                      "bookmarks" = [
                        {
                          "name" = "Technical Analysis - CME Group";
                          "url" = "https://www.cmegroup.com/education/courses/technical-analysis.html";
                        }
                        {
                          "name" = "Trading and Analysis - CME Group";
                          "url" = "https://www.cmegroup.com/education/courses/trading-and-analysis.html";
                        }
                      ];
                    }
                    {
                      "name" = "Learn about Key Economic Events - CME Group";
                      "url" = "https://www.cmegroup.com/education/courses/learn-about-key-economic-events.html";
                    }
                    {
                      "name" = "Trade and Risk Management - CME Group";
                      "url" = "https://www.cmegroup.com/education/courses/trade-and-risk-management.html";
                    }
                    {
                      "name" = "Introduction to Equity Index Products - CME Group";
                      "url" = "https://www.cmegroup.com/education/courses/introduction-to-equity-index-products.html";
                    }
                    {
                      "name" = "Futures vs. ETFs - CME Group";
                      "url" = "https://www.cmegroup.com/education/courses/futures-vs-etfs.html";
                    }
                    {
                      "name" = "Reddit";
                      "bookmarks" = [
                        {
                          "name" = "Reddit - Dive into anything";
                          "url" = "https://www.reddit.com/r/RealDayTrading/wiki/index/";
                        }
                        {
                          "name" = "r/RealDayTrading";
                          "bookmarks" = [
                            {
                              "name" = "(5) Adding a Sector List and the Top 10 for each sector to a Trading View watchlist  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/18ap05y/adding_a_sector_list_and_the_top_10_for_each/";
                            }
                            {
                              "name" = "Sign in to TC2000®";
                              "url" = "https://www.tc2000.com/sign-in?webplatform=true&returnURL=https://webplatform.tc2000.com/RASHTML5Gateway/";
                            }
                            {
                              "name" = "(5) Sector scanner for Trading View  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/x8v8cd/sector_scanner_for_trading_view/";
                            }
                            {
                              "name" = "> Sector Relative Strength — Indicator by atlas54000 — TradingView";
                              "url" = "https://www.tradingview.com/script/fcSCAIv5-Sector-Relative-Strength/";
                            }
                            {
                              "name" = "(5) I \"Shorted Stupid\" and I Got Burned!  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/y24905/i_shorted_stupid_and_i_got_burned/";
                            }
                            {
                              "name" = "> (5) Bearish Trend Days. How To Spot Them and How To Trade Them  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/xy8756/bearish_trend_days_how_to_spot_them_and_how_to/";
                            }
                            {
                              "name" = ">> (10) Bearish Trend Days - How To Trade Them - YouTube";
                              "url" = "https://www.youtube.com/watch?v=kPfWxS12yUY";
                            }
                            {
                              "name" = "> (10) Why This Gap and Go Pattern Failed - YouTube";
                              "url" = "https://www.youtube.com/watch?v=FmhUYeGCGgU";
                            }
                            {
                              "name" = "(4) Simple RS Strategy using trendline (Great for newbies)  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/ty0tjw/simple_rs_strategy_using_trendline_great_for/";
                            }
                            {
                              "name" = "(5) A Tool For Compiling Your Market Rebound Picks  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/v5kjav/a_tool_for_compiling_your_market_rebound_picks/";
                            }
                            {
                              "name" = "(5) Analyzed 450 Trades - This might be helpful  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/t7li41/analyzed_450_trades_this_might_be_helpful/";
                            }
                            {
                              "name" = "(5) Need help with identifying institutional support.  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/16zzjun/need_help_with_identifying_institutional_support/";
                            }
                            {
                              "name" = "(5) Update to relative strength stock and sector script post  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/weuik4/update_to_relative_strength_stock_and_sector/";
                            }
                            {
                              "name" = "(5) Real Relative Strength to SECTOR Indicator + Auto Sector Selection [TOS/TV]  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/x9dwv0/real_relative_strength_to_sector_indicator_auto/";
                            }
                            {
                              "name" = "(5) Strong sector or strong stock?  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/10n9i59/strong_sector_or_strong_stock/";
                            }
                            {
                              "name" = "(5) Sector / Industry Strength Comparison on Tradingview  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/tiprot/sector_industry_strength_comparison_on_tradingview/";
                            }
                            {
                              "name" = "(5) (Expanded to *Most* Stocks) Real Relative Strength to SECTOR Indicator + Auto Sector Selection [TOS]  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/z02d6b/expanded_to_most_stocks_real_relative_strength_to/";
                            }
                            {
                              "name" = "(5) Stacked Stock/Sector/Market RS/RW Arrows for TradingView  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/z9u03i/stacked_stocksectormarket_rsrw_arrows_for/";
                            }
                            {
                              "name" = "(5) Question About Sector Performance  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/170uagf/question_about_sector_performance/";
                            }
                            {
                              "name" = "(5) Relative Strength to stock and sector indicator for TOS  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/wb3x7c/relative_strength_to_stock_and_sector_indicator/";
                            }
                            {
                              "name" = "(5) Sector / Industry Strength Comparison on Tradingview  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/tiprot/sector_industry_strength_comparison_on_tradingview/";
                            }
                            {
                              "name" = "(5) I \"Shorted Stupid\" and I Got Burned!  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/y24905/i_shorted_stupid_and_i_got_burned/";
                            }
                            {
                              "name" = "(5) A very handy way to pull financial data  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/11widn4/a_very_handy_way_to_pull_financial_data/";
                            }
                            {
                              "name" = "> Download | OpenBB Terminal";
                              "url" = "https://my.openbb.co/app/terminal/download";
                            }
                            {
                              "name" = "Real Relative Strength to SECTOR Indicator + Auto Sector Selection [TOS/TV]  = RealDayTrading";
                              "url" = "https://www.reddit.com/r/RealDayTrading/comments/x9dwv0/real_relative_strength_to_sector_indicator_auto/";
                            }
                          ];
                        }
                      ];
                    }
                    {
                      "name" = "Tools";
                      "bookmarks" = [
                        {
                          "name" = "OpenBB Terminal Docs";
                          "url" = "https://docs.openbb.co/terminal";
                        }
                        {
                          "name" = "Order Types and Algos | Interactive Brokers LLC";
                          "url" = "https://www.interactivebrokers.com/en/trading/ordertypes.php";
                        }
                        {
                          "name" = "Basic Economics | Trading Course | Traders' Academy | IBKR Campus";
                          "url" = "https://ibkrcampus.com/trading-course/introduction-to-microeconomics/?src=_X_MAILING_ID&eid=_X_EID&blst=NL-TI_cps_artclbtn";
                        }
                        {
                          "name" = "Getting Started with TWS | Trading Lesson | Traders' Academy | IBKR Campus";
                          "url" = "https://ibkrcampus.com/trading-lessons/getting-started-with-tws/";
                        }
                        {
                          "name" = "בית פרטי/ קוטג', פרדס חנה כרכור | אלפי מודעות חדשות בכל יום!";
                          "url" = "https://www.yad2.co.il/realestate/item/qi61ryus?ad-location=Main+feed+listings&opened-from=Feed+view&component-type=main_feed&index=19&color-type=Grey";
                        }
                        {
                          "name" = "(1) Veena Krishnamurthy | LinkedIn";
                          "url" = "https://www.linkedin.com/in/veena-krishnamurthy/";
                        }
                      ];
                    }
                    {
                      "name" = "GitHub - wilsonfreitas/awesome-quant = A curated list of insanely awesome libraries, packages and resources for Quants (Quantitative Finance)";
                      "url" = "https://github.com/wilsonfreitas/awesome-quant";
                    }
                    {
                      "name" = "OCC - Investor Education";
                      "url" = "https://www.theocc.com/company-information/investor-education";
                    }
                  ];
                }
                {
                  "name" = "Platforms";
                  "bookmarks" = [
                    {
                      "name" = "koyfin";
                      "url" = "https://app.koyfin.com/home";
                    }
                  ];
                }
                {
                  "name" = "Research";
                  "bookmarks" = [
                    {
                      "name" = "Sectors";
                      "bookmarks" = [
                        {
                          "name" = "Select Sector SPDR ETFs - Sector Spiders ETFs | SPDR S&P Stock";
                          "url" = "https://www.sectorspdrs.com/";
                        }
                      ];
                    }
                  ];
                }
                {
                  "name" = "Investopedia Stock Simulator";
                  "url" = "https://www.investopedia.com/simulator/portfolio";
                }
                {
                  "name" = "מדריכים וכלים של פעמונים - paamonim";
                  "url" = "https://www.paamonim.org/he/%D7%9B%D7%9C%D7%99%D7%9D-%D7%95%D7%9E%D7%97%D7%A9%D7%91%D7%95%D7%A0%D7%99%D7%9D/";
                }
                {
                  "name" = "TipRanks";
                  "url" = "https://www.tipranks.com/dashboard";
                }
                {
                  "name" = "(18) TWS Trading Tutorial | Order Types, Presets & Routing - YouTube and more (2024.03.10)";
                  "bookmarks" = [
                    {
                      "name" = "(18) TWS Trading Tutorial | Order Types, Presets & Routing - YouTube";
                      "url" = "https://www.youtube.com/watch?v=AMCNNNlK8D0&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=102&t=62s";
                    }
                    {
                      "name" = "> (18) How to use Adjustable Stop and Scale Target Orders in TWS - YouTube";
                      "url" = "https://www.youtube.com/watch?v=RYykmLiGbMU&t=493s";
                    }
                    {
                      "name" = "> (18) How to use a Bracket Order in TWS (Stop-loss/Take Profit) - YouTube";
                      "url" = "https://www.youtube.com/watch?v=b-x_cwH99C4&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=63";
                    }
                    {
                      "name" = "> (18) How to Properly Use Margin with Interactive Brokers - YouTube";
                      "url" = "https://www.youtube.com/watch?v=Y-MmaJKQHAk&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=85";
                    }
                    {
                      "name" = "> (18) Interactive Brokers TWS Platform = How to trade directly from the Charts! - YouTube";
                      "url" = "https://www.youtube.com/watch?v=SGSxig40mgY&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=101&t=390s";
                    }
                    {
                      "name" = "> (18) How to FIX Your IBKR TWS Charts in 2 Minutes - YouTube";
                      "url" = "https://www.youtube.com/watch?v=hrO3KoXs5MU&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=100";
                    }
                    {
                      "name" = ">> (18) Step-by-Step TWS CHART Settings - (Interactive Brokers Tutorial) - YouTube";
                      "url" = "https://www.youtube.com/watch?v=F1d8r-MWjfM&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=111";
                    }
                    {
                      "name" = "> (18) 10 Tips & Tricks To Master Interactive Brokers - YouTube";
                      "url" = "https://www.youtube.com/watch?v=HR0S-0sgb7o&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=108";
                    }
                    {
                      "name" = ">> (18) Interactive Brokers Platform Tutorial for Day Trading 2023 (Level II, Hotkeys, Indicators etc) - YouTube";
                      "url" = "https://www.youtube.com/watch?v=UWTWz2GZq30&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=106&t=866s";
                    }
                    {
                      "name" = ">> (18) How to Set Up TWS layout/Interactive Brokers - YouTube";
                      "url" = "https://www.youtube.com/watch?v=mYVnhTe2ce0&list=PLHvOfb3T3xhTglFsfx2PwH0S-WWJAwDP3&index=74";
                    }
                  ];
                }
              ];
            }
          ];
        }
      ];
    };
    policies = {
      DisablePocket = true;
      DisableTelemetry = true;
      DownloadDirectory = "/home/${username}/Downloads";
      EnableTrackingProtection = true;
      HttpsOnlyMode = true;
      OfferToSaveLogins = false;
      OfferToSaveLoginsDefault = false;
      PasswordManagerEnabled = false;
      PDFjs = false;
      PictureInPicture = true;
      ShowHomeButton = false;
      PromptForDownloadLocation = false;
      DisableProfileImport = false;
      DisableFirefoxStudies = true;
      DisableFeedbackCommands = true;
      DisableDeveloperTools = false;
      DisableBuiltinPDFViewer = true;
      DisableAppUpdate = true;
      DefaultDownloadDirectory = "/home/${username}/Downloads";
    };
  };
}
```


### /home/lf/nix/pkgs/one-dark.colorscheme
```
[Background]
Color=40,44,52

[BackgroundFaint]
Color=40,44,52

[BackgroundIntense]
Color=40,44,52

[Color0]
Color=40,44,52

[Color0Faint]
Color=40,44,52

[Color0Intense]
Color=40,44,52

[Color1]
Color=224,108,117

[Color1Faint]
Color=224,108,117

[Color1Intense]
Color=224,108,117

[Color2]
Color=152,195,121

[Color2Faint]
Color=152,195,121

[Color2Intense]
Color=152,195,121

[Color3]
Color=229,192,123

[Color3Faint]
Color=229,192,123

[Color3Intense]
Color=229,192,123

[Color4]
Color=97,175,239

[Color4Faint]
Color=97,175,239

[Color4Intense]
Color=97,175,239

[Color5]
Color=198,120,221

[Color5Faint]
Color=198,120,221

[Color5Intense]
Color=198,120,221

[Color6]
Color=86,182,194

[Color6Faint]
Color=86,182,194

[Color6Intense]
Color=86,182,194

[Color7]
Color=220,223,228

[Color7Faint]
Color=220,223,228

[Color7Intense]
Color=220,223,228

[Foreground]
Color=171,178,191

[ForegroundFaint]
Color=92,99,112

[ForegroundIntense]
Color=130,137,151

[General]
Description=One Dark
Opacity=1
Wallpaper=
```


### /home/lf/nix/pkgs/fzf.nix
```nix
{
  pkgs, 
  ...
}:{
  programs.fzf = {
    enable = true;
    package = pkgs.fzf;
    enableZshIntegration = true;
    enableFishIntegration = true;
    defaultCommand = "fd --type f --hidden --follow --exclude .git"; # Matches _fzf_compgen_path
    defaultOptions = [
      "--preview='bat --style=numbers --color=always --line-range :500 {}'"
      "--preview-window 'right:70%:wrap'"
      "--border-label='File Picker'"
      "--layout=reverse"
      "--border=none"
      "--info='hidden'"
      "--header=''"
      "--prompt='/ '"
      "-i"
      "--no-bold"
      "--no-hscroll"
      #   "--bind='enter:execute(nvim {})'"
    ];
    fileWidgetCommand = "fd --type f --hidden --follow --exclude .git"; # Matches _fzf_compgen_path
    fileWidgetOptions = [
      "--preview 'bat --color=always {}'"
      "--preview-window '70%:wrap'"
      "--border-label='File Picker'"
    ];
    changeDirWidgetCommand = "fd --type d --hidden --follow --exclude .git"; # Matches _fzf_compgen_dir
    changeDirWidgetOptions = [
      "--preview 'lsd -a --tree --directory-only --color=always {}'"
      "--preview-window '70%:wrap'"
      "--border-label='Dir Jump'"
    ];
    historyWidgetOptions = [
      "--border-label='History Search'"
    ];
    colors = {
      fg = "#C6D0F5";
      "fg+" = "#C6D0F5";
      bg = "#303446";
      "bg+" = "#51576D";
      hl = "#E78284";
      "hl+" = "#E78284";
      info = "#CA9EE6";
      marker = "#BABBF1";
      prompt = "#CA9EE6";
      spinner = "#F2D5CF";
      pointer = "#F2D5CF";
      header = "#E78284";
      gutter = "#262626";
      border = "#414559";
      separator = "#4b4646";
      scrollbar = "#a22b2b";
      preview-bg = "#414559";
      preview-border = "#4b4646";
      label = "#C6D0F5";
      query = "#d9d9d9";
    };
  };

  # home.packages = with pkgs; [
  #   zinit # For managing fzf-tab and fzf-zsh-plugin
  # ];

  # # Manage custom fzf configurations in ~/.config/zsh/fzf.zsh
  # home.file.".config/zsh/fzf.zsh".text = ''
  #   # fzf-tab Zsh plugin
  #   source ${pkgs.fetchFromGitHub {
  #     owner = "Aloxaf";
  #     repo = "fzf-tab";
  #     rev = "v1.1.2"; # Pin to a specific version
  #     sha256 = "sha256-9p2B4eO8uV6j6gUqIuG4gN6P4I24Y3o1L4e6V4Vq8I=";
  #   }}/fzf-tab.zsh

  #   # unixorn/fzf-zsh-plugin
  #   source ${pkgs.fetchFromGitHub {
  #     owner = "unixorn";
  #     repo = "fzf-zsh-plugin";
  #     rev = "v1.0.0"; # Pin to a specific version
  #     sha256 = "sha256-0gP1K9P+9z9z9z9z9z9z9z9z9z9z9z9z9z9z9z9z9z="; # Replace with actual hash
  #   }}/fzf-zsh-plugin.zsh

  #   # fzf-tab zstyle configurations
  #   zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'lsd -a --color=always $realpath'
  #   zstyle ':fzf-tab:*' fzf-bindings 'space:accept'
  #   zstyle ':fzf-tab:*' print-query ctrl-c
  #   zstyle ':fzf-tab:*' single-group color header
  #   zstyle ':fzf-tab:complete:(cat|nvim|cp|rm|bat):*' fzf-preview 'bat --color=always -- "$realpath" 2>/dev/null || lsd -a --color=always -- "$realpath"'
  #   zstyle ':fzf-tab:complete:nvim:*' fzf-flags --preview-window=right:65%
  #   zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
  #   zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

  #   # Aliases
  #   alias zf='z "$(zoxide query -l | fzf --preview "ls --color {}" --preview-window "70%:wrap" --border-label="Dir Jump")"'
  #   alias gv="git grep --line-number . | fzf --delimiter : --nth 3.. --bind 'enter:become(nvim {1} +{2})' --border-label='Git Grep'"
  #   alias dfz='docker ps -a | fzf --multi --header "Select container" --preview "docker inspect {1}" --preview-window "40%:wrap" --border-label="Docker Select" | awk "{print \$1}" | xargs -I {} docker start {}'
  #   alias of='fd .md $HOME/Obsidian/ | sed "s|$HOME/Obsidian/||" | fzf --preview "bat --color=always $HOME/Obsidian/{1}" --preview-window "50%:wrap" --border-label="Obsidian Files" --bind "enter:become(nvim $HOME/Obsidian/{1})"'
  #   alias rgf='rg --line-number --no-heading . | fzf --delimiter : --preview "bat --color=always {1} --highlight-line {2}" --preview-window "70%:wrap" --border-label="Ripgrep Files" --bind "enter:become(nvim {1} +{2})"'
  #   alias v='fzf --preview --border-label="Open in Vim" "bat --color always {}" --preview-window "70%:wrap" --multi --bind "enter:become(vim {+})"'
  #   alias mans='man -k . | fzf --border-label="Man Pages" | awk "{print \$1}" | xargs -r man'

  #   # Functions
  #   _fzf_compgen_path() {
  #     fd --hidden --follow --exclude ".git" . "$1"
  #   }

  #   _fzf_compgen_dir() {
  #     fd --type d --hidden --follow --exclude ".git" . "$1"
  #   }

  #   rga-fzf() {
  #     RG_PREFIX="rga --files-with-matches"
  #     local file
  #     file="$(
  #       FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
  #         fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
  #           --phony -q "$1" \
  #           --bind "change:reload:$RG_PREFIX {q}" \
  #           --preview-window="70%:wrap"
  #     )" &&
  #     echo "opening $file" &&
  #     xdg-open "$file"
  #   }

  #   _fzf_docker_select_container() {
  #     docker ps --format "{{.Names}}" | fzf --height=20% --layout=reverse --prompt="Select Container > "
  #   }

  #   dfd() {
  #     local container
  #     container=$(_fzf_docker_select_container)
  #     [ -z "$container" ] && return 1
  #     local finder_cmd="fd . /"
  #     docker exec "$container" which fd >/dev/null 2>&1 || finder_cmd="find / -mindepth 1"
  #     local previewer_cmd="bat --color=always --plain {}"
  #     docker exec "$container" which bat >/dev/null 2>&1 || previewer_cmd="cat {}"
  #     docker exec "$container" sh -c "$finder_cmd 2>/dev/null" | fzf \
  #       --prompt "Finding files in '$container' > " \
  #       --preview "docker exec '$container' sh -c \"$previewer_cmd\"" \
  #       --preview-window "right:60%:wrap"
  #   }

  #   drg() {
  #     if [ -z "$1" ]; then
  #       echo "Usage: drg <search_pattern>"
  #       return 1
  #     fi
  #     local container
  #     container=$(_fzf_docker_select_container)
  #     [ -z "$container" ] && return 1
  #     local searcher_cmd="rg --line-number --no-heading --color=always '$1' /"
  #     docker exec "$container" which rg >/dev/null 2>&1 || searcher_cmd="grep -I -RHn '$1' /"
  #     local previewer_cmd="bat --color=always --highlight-line {2} {1}"
  #     docker exec "$container" which bat >/dev/null 2>&1 || previewer_cmd="cat {1}"
  #     docker exec "$container" sh -c "$searcher_cmd 2>/dev/null" | fzf \
  #       --prompt "Searching for '$1' in '$container' > " \
  #       --delimiter ":" \
  #       --preview "docker exec '$container' sh -c \"$previewer_cmd\"" \
  #       --preview-window "right:60%:wrap"
  #   }

  #   dfx() {
  #     local container
  #     container=$(_fzf_docker_select_container)
  #     [ -z "$container" ] && return 1
  #     local finder_cmd="fd --extension json --extension yml --extension yaml . /"
  #     docker exec "$container" which fd >/dev/null 2>&1 || finder_cmd="find / -mindepth 1 -name '*.json' -o -name '*.yml' -o -name '*.yaml'"
  #     docker exec "$container" sh -c "$finder_cmd 2>/dev/null" | fzf \
  #       --prompt "Select a JSON/YAML file in '$container' > " \
  #       --bind "enter:become(docker exec '$container' cat {} | fx)"
  #   }

  #   dsh() {
  #     local container
  #     container=$(_fzf_docker_select_container)
  #     [ -z "$container" ] && return 1
  #     local rootfs
  #     rootfs=$(docker inspect -f '{{.GraphDriver.Data.MergedDir}}' "$container")
  #     if [ -z "$rootfs" ]; then
  #       echo "Error: Could not find root filesystem for container '$container'." >&2
  #       return 1
  #     fi
  #     local pid
  #     pid=$(docker inspect -f '{{.State.Pid}}' "$container")
  #     sudo nsenter -t "$pid" -n --wd="$rootfs" chroot "$rootfs" "$SHELL"
  #     echo "Exited container '$container'."
  #   }
  # '';
}
```


### /home/lf/nix/pkgs/git.nix
```nix
{
  ...
}: {
  # Configure Git
  programs.git = {
    enable = true;
    userName = "Laurent Flaster";
    userEmail = "laurentf84@gmail.com";
    extraConfig = {
      # Configure Meld as the default diff tool
      diff = {
        tool = "meld";
      };
      difftool = {
        meld = {
          cmd = ''meld "$LOCAL" "$REMOTE"'';
        };
      };
      # Create a Git alias to use PathPicker with difftool
      alias = {
        diffpick = "!sh -c 'git diff --name-only | fpp --no-file-checks | xargs -r git difftool'";
      };
    };
  };
}
```


### /home/lf/nix/pkgs/lsd.nix
```nix
{pkgs, ...}: {
  programs.lsd = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    package = pkgs.lsd;
    settings = {
      date = "relative"; # Show relative dates
      icons = {
        when = "auto"; # Auto-detect icon support
        theme = "fancy"; # Use fancy icons
      };
    };
  };
}
```


### /home/lf/nix/pkgs/vscode.nix
```nix
{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    # Define your VS Code settings here
    profiles.default = {
      userSettings = {
        # "editor.fontFamily" = "FantasqueSansM Nerd Font Mono Italic";
        "editor.fontFamily" = "Maple Mono NF";
        "editor.fontLigatures" = "'calt', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'zero', 'onum'";
        "editor.tokenColorCustomizations" = {
          "textMateRules" = [
            {
              "scope" = [
                "source"
                "text"
              ];
              "settings" = {
                # "fontStyle" = "italic";
              };
            }
          ];
        };
        "editor.tabSize" = 2;
        "[docker-compose]" = {
          "editor.defaultFormatter" = "KilianJPopp.docker-compose-support";
          "editor.formatOnSave" = true;
        };
        "docker-compose.format.enabled" = true;
        "nix.serverPath" = "nixd";
        "nix.enableLanguageServer" = true;
        "nix.serverSettings" = {
          "nixd.formatting.command" = ["alejandra"];
        };
        "[nix]" = {
          "editor.defaultFormatter" = "kamadorueda.alejandra";
          "editor.formatOnSave" = true;
        };
        "git.openRepositoryInParentFolders" = "always";
        "workbench.iconTheme" = "vscode-icons";
        "vsicons.dontShowNewVersionMessage" = true;
        "workbench.colorTheme" = "Catppuccin Mocha";
        "python.defaultInterpreterPath" = "${pkgs.python312}/bin/python3";
      };
      languageSnippets = {
        python = {
          "AI3 Header" = {
            "body" = [
              "\"\"\""
              "Title = \${1: 'Enter a Title'}"
              "\${2|Exercise,Quiz|} = $3"
              "Description = \${4: 'And now a description'}"
              ""
              "Author = Laurent Flaster"
              "Reviewer = \${6: 'Lucky who?'}"
              ""
              "Infinity Labs R&D AI3"
              "\"\"\""
              ""
              "\${7: import} $0"
            ];
            "description" = ["Insert AI3 Doc string."];
            "prefix" = ["ai3"];
          };
        };
      };
      extensions = with pkgs.vscode-extensions; [
        vscode-icons-team.vscode-icons
        github.copilot
        github.copilot-chat
        ms-python.python
        ms-python.debugpy
        charliermarsh.ruff
        # ms-python.pylint
        ms-python.vscode-pylance
        ms-python.mypy-type-checker
        jnoortheen.nix-ide
        kamadorueda.alejandra
        jeff-hykin.better-nix-syntax
        sumneko.lua
        ms-toolsai.jupyter
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.jupyter-keymap
        ms-azuretools.vscode-docker
        zainchen.json
        vscodevim.vim
        visualstudioexptteam.intellicode-api-usage-examples
        tekumara.typos-vscode
        rubymaniac.vscode-paste-and-indent
        richie5um2.snake-trail
        naumovs.color-highlight
        mongodb.mongodb-vscode
        mishkinf.goto-next-previous-member
        catppuccin.catppuccin-vsc
        njpwerner.autodocstring
      ];
    };
  };
}
```


### /home/lf/nix/pkgs/zsh.nix
```nix
{config, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    history = {
      append = true;
      share = true;
      findNoDups = true;
      saveNoDups = true;
      ignoreAllDups = true;
      ignoreDups = true;
      ignoreSpace = true;
      path = "${config.xdg.dataHome}/.zsh_history";
      size = 100000;
      save = 100000;
      extended = true;
    };
    autocd = true;
    defaultKeymap = "viins";
    localVariables = {
    };
    zsh-abbr.globalAbbreviations = {
      C = "| wl-copy";
      G = "| rg ";
      L = "| less -R";
    };
    shellAliases = {
      nix-update = "sudo nixos-rebuild switch --flake ~/NixOS-Hyprland#lf-nix";
      nix-build = "nixos-rebuild build --flake ~/NixOS-Hyprland#lf-nix";
      nix-gc = "nix-collect-garbage";
      nix-gcd = "nix-collect-garbage -d";
      c = "clear";
      p = "python";
      py = "python";
      e = "exit";
      btc = "curl rate.sx";
      # paths="echo -e ${PATH//:/\\n}";
      d = "docker";
      dc = "docker compose";
      dcu = "docker compose up";
      dcd = "docker compose down";
      dcud = "docker compose up -d";
      dps = "docker ps";
      dpsa = "docker ps -a";
      drfa = "'docker rm -f $(docker ps -aq)'";
      tai = "tmux attach -t ai3";
      t = "tmux";
      ld = "lazydocker";
      lg = "lazygit";
      treesize = "ncdu";
      lastmod = "find . -type f -not -path '*/\.*' -exec ls -lrt {} +";
      zf = "z '$(zoxide query -l | fzf --preview 'ls --color {}' --preview-window '70%:wrap' --border-label='Dir Jump')'";
      gv = "git grep --line-number . | fzf --delimiter : --nth 3.. --bind 'enter:become(nvim {1} +{2})' --border-label='Git Grep'";
      dfz = "docker ps -a | fzf --multi --header 'Select container' --preview 'docker inspect {1}' --preview-window '40%:wrap' --border-label='Docker Select' | awk '{print \$1}' | xargs -I {} docker start {}";
      v = "fzf --preview --border-label='File Picker' 'bat {}' --preview-window '70%:wrap' --multi --bind 'enter:become(nvim {+})'";
      mans = "man -k . | fzf --border-label='Man Pages' | awk '{print \$1}' | xargs -r man";
      ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --preview-window 'right:40%:wrap' --scheme history";
      ".." = "cd ..";
      "..." = "cd ../..";
    };
    syntaxHighlighting = {
      enable = true;
    };
    # fROM initContent:         export PATH="$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:/run/current-system/sw/bin:$PATH"
    initContent = ''
              yt() {fabric -y "$1" --transcript}

              mkcd() { mkdir -p "$1" && cd "$1" }
              rgn() { rg --line-number --no-heading "$@" | awk -F: '{print $1 " [" $2 "]"}' | fzf --border-label 'Ripgrep Search' --delimiter ' \[' --nth 1 --preview 'bat --style=plain --color=always {1} --line-range $(({2}-5)): --highlight-line {2}' --preview-window 'right,70%,border-left' --border-label 'Ripgrep Search' --bind 'enter:become(nvim {1} +{2})' }
              rga-fzf() {
                RG_PREFIX="rga --files-with-matches"
                local file
                file="$(
                    FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
                        fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
                            --phony -q "$1" \
                            --bind "change:reload:$RG_PREFIX {q}" \
                            --preview-window="70%:wrap"
                    )" &&
              echo "opening $file" &&
              xdg-open "$file"
              }


      #        eval "$(starship init zsh)"
    '';
  };
}
```


### /home/lf/nix/treefmt.nix
```nix
{ pkgs, ... }:

{
  # Tell treefmt where your project root is
  projectRootFile = "flake.nix";

  # Enable the Nix formatter, alejandra
  programs.alejandra.enable = true;
}
```


### /home/lf/nix/.github/FUNDING.yml
```yaml
# These are supported funding model platforms

github: JaKooLit
ko_fi: jakoolit
```


### /home/lf/nix/.github/ISSUE_TEMPLATE/bug.yml
```yaml
name: Bug Report
description: Something is not working right
title: "[Bug]: "
labels: ["bug"]
assignees:
  - JaKooLit

body:
  - type: checkboxes
    attributes:
      label: Already reported ? *
      description: Before opening a new bug report, please take a moment to search through the current open and closed issues to check if it already exists.
      options:
      - label: I have searched the existing open and closed issues.
        required: true

  - type: dropdown
    id: type
    attributes:
      label: Regression?
      description: |
        Regression means that something used to work but no longer does.
      options:
        - "Yes"
        - "No"
        - "Not sure"
    validations:
      required: true

  - type: textarea
    id: ver
    attributes:
      label: System Info and Version
      description: |
        Paste the output of `inxi --full` here.
        install inxi if command not found.
      value: "<details>
        <summary>System/Version info</summary>


        ```

        <Paste the output of the command here, without removing any formatting around this>

        ```


        </details>"
    validations:
      required: true
      
  - type: textarea
    id: dots
    attributes:
      label: KooL's Dots version
      description: |
        Paste the output of `find ~/.config/hypr/ -type f -name 'v*' -exec basename {} \;` 
        This is just KooL's Hyprland Dots version.
    validations:
      required: true

  - type: textarea
    id: desc
    attributes:
      label: Description
      description: "What went wrong? What exactly happened?"
    validations:
      required: true

  - type: textarea
    id: repro
    attributes:
      label: How to reproduce
      description: "How can someone else reproduce the issue?"
    validations:
      required: true

  - type: textarea
    id: logs
    attributes:
      label: install logs, images or videos
      description: |
        Anything that can help. Please always ATTACH and not paste them.
```


### /home/lf/nix/.github/ISSUE_TEMPLATE/config.yml
```yaml
blank_issues_enabled: false
```


### /home/lf/nix/.github/ISSUE_TEMPLATE/documentation-update.yml
```yaml
name: Documentation update
description: Propose a change to the project documentation wiki
title: "[Documentation update]: "
labels: ["documentation_update"]
assignees:
  - JaKooLit

body:
  - type: textarea
    id: desc
    attributes:
      label: Description
      description: "Provide a clear and concise description of the documentation update"
    validations:
      required: true

  - type: textarea
    id: repro
    attributes:
      label: Proposed Solution
      description: "Provide a clear and concise description of the updated documentation that you'd like to see added"
    validations:
      required: true

  - type: textarea
    id: logs
    attributes:
      label: install links, images or videos
      description: |
        Add any other information about the documentation update here. For example, you might include links to similar documentation in other projects, or screenshots or diagrams to help explain your idea
```


### /home/lf/nix/.github/ISSUE_TEMPLATE/feature.yml
```yaml
name: Feature Request
description: I'd like to propose some changes and enhancements
title: "[Enhancement]: "
labels: ["enhancement"]
assignees:
  - JaKooLit

body:
  - type: checkboxes
    attributes:
      label: Already reported ? *
      description: Before opening a new feature request, please take a moment to search through the current open and closed issues / request to check if it already exists.
      options:
      - label: I have searched the existing open and closed request.
        required: true

  - type: textarea
    id: desc
    attributes:
      label: Description
      description: "Describe your idea?"
    validations:
      required: true

  - type: textarea
    id: repro
    attributes:
      label: Proposed Solution
      description: "describe if you have a specific solution in mind"
    validations:
      required: true
```


### /home/lf/nix/.editorconfig
```
root = true
[*]
indent_style = space
indent_size = 2
```

