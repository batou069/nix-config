{
  inputs = {
    dotfiles-src = {
      url = "path:/home/lf/dotfiles";
      flake = false;
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nix-your-shell = {
      url = "github:MercuryTechnologies/nix-your-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    # ags = {
    #   url = "github:aylur/ags/v1";
    #   # url = "github:aylur/ags";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-mineral = {
      url = "github:cynicsketch/nix-mineral";
      flake = false;
    };
    disko.url = "github:nix-community/disko";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    sops-nix.url = "github:Mic92/sops-nix";
    flake-utils.url = "github:numtide/flake-utils";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    claudia = {
      url = "github:getAsterisk/claudia/218ecfb8b2069b69e4c40734e178e2a6af9fced7";
    };
    hyprland.url = "github:hyprwm/Hyprland/v0.50.0";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins/v0.50.0";
      inputs.hyprland.follows = "hyprland";
    };
    # hypr-dynamic-cursors = {
    #   url = "github:VirtCode/hypr-dynamic-cursors";
    #   inputs.hyprland.follows = "hyprland"; # to make sure that the plugin is built for the correct version of hyprland
    # };
    hy3 = {
      url = "github:outfoxxed/hy3/hl0.50.0";
      inputs.hyprland.follows = "hyprland";
    };
    # pyprland.url = "github:hyprland-community/pyprland";
    mcp-servers-nix.url = "github:natsukium/mcp-servers-nix";
    # hyprpanel = {
    #   url = "github:Jas-SinghFSU/HyprPanel";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # zen-browser = {
    #   url = "github:benjaminkitt/zen-browser-flake";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     home-manager.follows = "home-manager";
    #   };
    # };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Vicinae
    vicinae.url = "github:vicinaehq/vicinae";
    vicinae.inputs.nixpkgs.follows = "nixpkgs";

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #plugins list
    avante-nvim = {
      url = "github:yetone/avante.nvim";
      flake = false;
    };
    minuet-ai-nvim = {
      url = "github:milanglacier/minuet-ai.nvim";
      flake = false;
    };
    blink-cmp.url = "github:saghen/blink.cmp";
    vim-translator = {
      url = "github:voldikss/vim-translator";
      flake = false;
    };
    none-ls-nvim = {
      url = "github:nvimtools/none-ls.nvim";
      flake = false;
    };
    nui-nvim = {
      url = "github:MunifTanjim/nui.nvim";
      flake = false;
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    # mango = {
    #   url = "github:DreamMaoMao/mangowc";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nix-mcp-servers = {
      url = "github:cameronfyfe/nix-mcp-servers";
    };
    hyprviz.url = "github:timasoft/hyprviz";
    serena = {
      url = "github:oraios/serena";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    #@{flake-parts, nixpkgs, systems, ...}:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        # Import the treefmt-nix module
        inputs.treefmt-nix.flakeModule
        # (import ./lib/import.tree.nix nixpkgs.lib ./pkgs)
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
            packages = [ pkgs.pre-commit pkgs.gh pkgs.gum ];
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
                  lib = super.lib.extend (_self-lib: _super-lib: {
                    hm = inputs.home-manager-unstable.lib;
                  });
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
                inherit inputs username host system pkgs pkgs-unstable lib;
                dotfiles = inputs.dotfiles-src;
              };

              modules =
                [
                  inputs.hyprland.nixosModules.default
                  inputs.disko.nixosModules.default
                  inputs.sops-nix.nixosModules.sops
                  inputs.nur.modules.nixos.default
                  inputs.stylix.nixosModules.stylix
                  # inputs.mango.nixosModules.mango
                  ./hosts/${host}/config.nix
                  ./hosts/${host}/sops.nix
                  ./hosts/${host}/home.nix
                ]
                ++ modules;
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
              modules = [ inputs.home-manager.nixosModules.home-manager ];
            };
          };

          homeConfigurations = {
            "lf" = inputs.home-manager-unstable.lib.homeManagerConfiguration {
              pkgs = pkgs-unstable-hm;
              extraSpecialArgs = {
                inherit inputs system pkgs pkgs-unstable;
                username = "lf";
                dotfiles = inputs.dotfiles-src;
              };
              modules = [
                inputs.home-manager-unstable.homeManagerModules.default
                inputs.stylix.homeModules.stylix
                # inputs.nur.modules.homeManager.default
                inputs.nix-doom-emacs-unstraightened.homeModule
                ./home/home.nix
              ];
            };
          };
        };
    };
}
