{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:nix-community/stylix/release-25.05";
    # ags = {
    #   # url = "github:aylur/ags/v1";
    #   url = "github:aylur/ags";
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
      inputs.nixpkgs.follows = "nixpkgs";
    };
    claudia = {
      url = "github:getAsterisk/claudia/218ecfb8b2069b69e4c40734e178e2a6af9fced7";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hypr-dynamic-cursors = {
      url = "github:VirtCode/hypr-dynamic-cursors";
      inputs.hyprland.follows = "hyprland"; # to make sure that the plugin is built for the correct version of hyprland
    };
    pyprland.url = "github:hyprland-community/pyprland";
    # catppuccin.url = "github:catppuccin/nix";
    # neovim = {
    #   url = github:neovim/neovim/contrib;
    # };
    # gemini-cli = {
    #   url = "github:novel2430/gemini-cli";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    disko,
    sops-nix,
    nur,
    stylix,
    flake-utils,
    claudia,
    firefox-addons,
    ...
  }: let
    # Define a function to create pkgs for a given system
    mkPkgs = system:
      import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = pkg:
            builtins.elem (nixpkgs.lib.getName pkg) [
              "vscode"
            ];
        };
        overlays = [
          (final: prev: {
            unstable = import inputs.nixpkgs-unstable {
              inherit (prev) system;
              config.allowUnfree = true;
            };
            claudia = inputs.claudia.packages.${prev.system}.default;
            firefox-addons = inputs.firefox-addons.packages.${prev.system};
          })
          inputs.nur.overlays.default
          (final: prev: {
            ibkr-tws = prev.nur.repos."7mind".ibkr-tws.overrideAttrs (old: {
              src = prev.fetchurl {
                url = "https://download2.interactivebrokers.com/installers/tws/stable-standalone/tws-stable-standalone-linux-x64.sh";
                sha256 = "sha256-+z77sypqbN9PMMOQnJTfdDHRP5NVfTOCUBT0AaAn87Y=";
              };
            });
          })
        ];
      };

    # Function to generate a NixOS system configuration
    mkNixosSystem = {
      system,
      host,
      username,
      pkgs,
      lib,
      hm, # Add hm here
    }:
      lib.nixosSystem {
        specialArgs = {
          inherit inputs username host system hm; # Inherit hm here
        };

        modules = [
          # Correctly pass pkgs to NixOS modules
          nixpkgs.nixosModules.readOnlyPkgs
          {
            nixpkgs.pkgs = pkgs;
          }
          disko.nixosModules.default
          inputs.sops-nix.nixosModules.sops
          inputs.nur.modules.nixos.default
          stylix.nixosModules.stylix
          ./hosts/${host}/config.nix
          ./hosts/${host}/sops.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = {
                inherit inputs username system pkgs lib;
              };
              users.${username} = {
                imports = [
                  ./pkgs/home.nix
                ];
              };
            };
          }
        ];
      };

    # Function to generate a Home Manager configuration
    mkHomeConfiguration = {
      system,
      username,
      pkgs,
      lib,
    }:
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs lib;
        extraSpecialArgs = {
          inherit inputs system username;
          hm = home-manager.lib; # Pass home-manager's lib as 'hm'
        };
        modules = [
          inputs.stylix.homeModules.stylix
          ./pkgs/home.nix
        ];
      };
  in {
    nixosConfigurations = {
      "lf-nix" = mkNixosSystem {
        system = "x86_64-linux";
        pkgs = mkPkgs "x86_64-linux";
        lib = nixpkgs.lib;
        hm = home-manager.lib;
        host = "lf-nix";
        username = "lf";
      };

      "viech" = mkNixosSystem {
        system = "x86_64-linux";
        pkgs = mkPkgs "x86_64-linux";
        lib = nixpkgs.lib;
        hm = home-manager.lib;
        host = "viech";
        username = "lf";
      };
    };

    homeConfigurations = {
      "lf@lf-nix" = mkHomeConfiguration {
        system = "x86_64-linux";
        pkgs = mkPkgs "x86_64-linux";
        lib = nixpkgs.lib;
        username = "lf";
      };
      "lf@viech" = mkHomeConfiguration {
        system = "x86_64-linux";
        pkgs = mkPkgs "x86_64-linux";
        lib = nixpkgs.lib;
        username = "lf";
      };
    };

    # Add a 'packages' output for general packages, if needed by other tools or for consistency
    packages.x86_64-linux = mkPkgs "x86_64-linux";
    defaultPackage.x86_64-linux = self.packages.x86_64-linux.hello; # Example default package
  };
}
