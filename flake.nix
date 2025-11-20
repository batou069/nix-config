{
  inputs = {
    dotfiles-src = {
      url = "path:/home/lf/dotfiles";
      flake = false;
    };

    # --- Nix & Home-Manager ---
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "git+https://github.com/nix-community/home-manager"; # /release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      url = "git+https://github.com/nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # --- Nix Addons ---

    flake-parts.url = "git+https://github.com/hercules-ci/flake-parts";

    nix-your-shell = {
      url = "git+https://github.com/MercuryTechnologies/nix-your-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      # url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ags = {
    #   url = "git+https://github.com/aylur/ags/v1";
    #   # url = "git+https://github.com/aylur/ags";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nix-mineral = {
      url = "git+https://github.com/cynicsketch/nix-mineral";
      flake = false;
    };

    disko.url = "git+https://github.com/nix-community/disko";

    treefmt-nix.url = "git+https://github.com/numtide/treefmt-nix";

    sops-nix.url = "git+https://github.com/Mic92/sops-nix";

    flake-utils.url = "git+https://github.com/numtide/flake-utils";

    nur = {
      url = "git+https://github.com/nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    claudia = {
      url = "github:getAsterisk/claudia/218ecfb8b2069b69e4c40734e178e2a6af9fced7";
    };

    # --- HYPRLAND stuff ---

    hyprland.url = "github:hyprwm/Hyprland/v0.50.0"; # TODO upgrae to 0.52.0
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins/v0.50.0";
      inputs.hyprland.follows = "hyprland";
    };
    rose-pine-hyprcursor = {
      # url = "github:ndom91/rose-pine-hyprcursor";
      url = "git+https://github.com/ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.hyprlang.follows = "hyprland/hyprlang";
    };

    # hypr-dynamic-cursors = {
    #   url = "git+https://github.com/VirtCode/hypr-dynamic-cursors";
    #   inputs.hyprland.follows = "hyprland"; # to make sure that the plugin is built for the correct version of hyprland
    # };

    # hyprpanel = {
    #   url = "git+https://github.com/Jas-SinghFSU/HyprPanel";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    hy3 = {
      url = "git+https://github.com/outfoxxed/hy3/"; # hl0.50.0";
      inputs.hyprland.follows = "hyprland";
    };

    # pyprland.url = "git+https://github.com/hyprland-community/pyprland";

    mcp-servers-nix.url = "git+https://github.com/natsukium/mcp-servers-nix";

    nixvim = {
      url = "git+https://github.com/nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # zen-browser = {
    #   url = "git+https://github.com/benjaminkitt/zen-browser-flake";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     home-manager.follows = "home-manager";
    #   };
    # };

    nixcord = {
      url = "git+https://github.com/kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Vicinae
    vicinae.url = "github:vicinaehq/vicinae";
    vicinae.inputs.nixpkgs.follows = "nixpkgs";

    nix-vscode-extensions = {
      url = "git+https://github.com/nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #plugins list
    avante-nvim = {
      url = "git+https://github.com/yetone/avante.nvim";
      flake = false;
    };
    minuet-ai-nvim = {
      url = "git+https://github.com/milanglacier/minuet-ai.nvim";
      flake = false;
    };
    blink-cmp.url = "git+https://github.com/saghen/blink.cmp";
    vim-translator = {
      url = "git+https://github.com/voldikss/vim-translator";
      flake = false;
    };
    none-ls-nvim = {
      url = "git+https://github.com/nvimtools/none-ls.nvim";
      flake = false;
    };
    nui-nvim = {
      url = "git+https://github.com/MunifTanjim/nui.nvim";
      flake = false;
    };
    emacs-overlay = {
      url = "git+https://github.com/nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-doom-emacs-unstraightened = {
      url = "git+https://github.com/marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # mango = {
    #   url = "git+https://github.com/DreamMaoMao/mangowc";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nix-mcp-servers = {
      url = "git+https://github.com/cameronfyfe/nix-mcp-servers";
    };
    mcp-nixos = {
      url = "git+https://github.com/utensils/mcp-nixos";
    };
    hyprviz.url = "git+https://github.com/timasoft/hyprviz";
    serena = {
      url = "git+https://github.com/oraios/serena";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "git+https://github.com/nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager-unstable";
    };
    catppuccin.url = "git+https://github.com/catppuccin/nix";
  };

  outputs = inputs:
    #@{flake-parts, nixpkgs, systems, ...}:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        # Import the treefmt-nix module
        inputs.treefmt-nix.flakeModule
        # (import ./lib/import.tree.nix nixpkgs.lib ./pkgs)
        # Try importing HM flake module from https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-flake-parts-module
        # inputs.home-manager-unstable.flakeModules.home-manager
      ];
      systems = [ "x86_64-linux" ];
      perSystem =
        { config
        , pkgs
        , ...
        }:
        let
          pkgs-unfree = import inputs.nixpkgs {
            system = pkgs.system;
            config.allowUnfree = true;
          };
        in
        {
          packages = {
            vscode-fhs = pkgs-unfree.vscode-fhs;
          };

          # Configure treefmt-nix
          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              # FOR NIX
              alejandra.enable = true;
              deadnix.enable = true;
              nixpkgs-fmt.enable = true;

              # For Python files
              # ruff.enable = true;
              ruff.check = true;
              ruff.format = true;
              # For Shell scripts
              shfmt.enable = true;
              # For Markdown, JSON, YAML, etc.
              prettier.enable = true;
              # For SQL & co
              sqlfluff.enable = true;
              # Lua
              stylua.enable = true;
              # Fish
              fish_indent.enable = true;
              # Dockerfiles
              dockfmt.enable = true;
            };
            settings.formatter.ruff-check.priority = 1;
            settings.formatter.ruff-format.priority = 2;
          };

          devShells.default = pkgs.mkShell {
            name = "nix-config-shell";
            inputsFrom = [ config.treefmt.package ];
            packages = [
              pkgs.pre-commit
              pkgs.gh
              pkgs.gum
            ];
            shellHook = ''
              echo "Welcome to the Nix config dev shell!"

              menu() {
                echo "Available commands:"
                echo "  run        # Start the server (not implemented)"
                echo "  run-tests  # Run all tests (not implemented)"
                echo "  lint       # Format and check code"
                echo "  typecheck  # Check types (not implemented)"
              }

              lint() {
                treefmt
              }

              echo "Run 'menu' to see available commands."
            '';
          };
        };

      flake =
        let
          system = "x86_64-linux";
          lib = inputs.nixpkgs.lib;
          # Define a central config to be applied to both package sets
          nixpkgsConfig = {
            config.allowUnfree = true;
            # Import the list of overlays from the dedicated file
            overlays = import ./overlays/default.nix { inherit inputs; };
          };
          # Create the configured package sets
          pkgs = import inputs.nixpkgs {
            inherit system;
            config = nixpkgsConfig.config;
            overlays = nixpkgsConfig.overlays;
          };
          pkgs-unstable = import inputs.nixpkgs-unstable {
            inherit system;
            config = nixpkgsConfig.config;
            overlays = nixpkgsConfig.overlays;
          };

          # Pkgs for standalone home-manager with hm lib
          pkgs-unstable-hm = import inputs.nixpkgs-unstable {
            inherit system;
            config = nixpkgsConfig.config;
            overlays =
              nixpkgsConfig.overlays
              ++ [
                (_self: super: {
                  lib = super.lib.extend (
                    _self-lib: _super-lib: {
                      hm = inputs.home-manager-unstable.lib;
                    }
                  );
                })
              ];
          };

          mkNixosSystem =
            { host
            , username
            , modules ? [ ]
            ,
            }:
            lib.nixosSystem {
              specialArgs = {
                inherit
                  inputs
                  username
                  host
                  system
                  pkgs
                  pkgs-unstable
                  lib
                  ;
                dotfiles = inputs.dotfiles-src;
              };

              modules =
                modules
                ++ [
                  inputs.hyprland.nixosModules.default
                  inputs.disko.nixosModules.default
                  inputs.sops-nix.nixosModules.sops
                  inputs.nur.modules.nixos.default
                  inputs.stylix.nixosModules.stylix
                  # inputs.mango.nixosModules.mango
                  ./hosts/${host}/config.nix
                  ./hosts/${host}/sops.nix
                  ./hosts/${host}/home.nix
                ];
            };
        in
        {
          nixosConfigurations = {
            "lf-nix" = mkNixosSystem {
              host = "lf-nix";
              username = "lf";
              modules = [ inputs.home-manager-unstable.nixosModules.home-manager ];
            };

            "viech" = mkNixosSystem {
              host = "viech";
              username = "lf";
              modules = [ inputs.home-manager-unstable.nixosModules.home-manager ];
            };
          };

          homeConfigurations = {
            "lf" = inputs.home-manager-unstable.lib.homeManagerConfiguration {
              pkgs = pkgs-unstable-hm;
              extraSpecialArgs = {
                inherit
                  inputs
                  system
                  pkgs
                  pkgs-unstable
                  ;
                username = "lf";
                dotfiles = inputs.dotfiles-src;
              };
              modules = [
                # inputs.home-manager-unstable.flakeModules.home-manager
                inputs.plasma-manager.homeModules.plasma-manager
                inputs.stylix.homeModules.stylix
                inputs.nur.modules.homeManager.default
                inputs.nix-doom-emacs-unstraightened.homeModule
                inputs.catppuccin.homeModules.catppuccin
                ./home/home.nix
              ];
            };
          };
        };
    };
}
# Trivial change to invalidate cache

