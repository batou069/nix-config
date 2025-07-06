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
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
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
          (final: prev: {
            nur =
              prev.nur
              // {
                repos =
                  prev.nur.repos
                  // {
                    "7mind" =
                      prev.nur.repos."7mind"
                      // {
                        ibkr-tws = prev.nur.repos."7mind".ibkr-tws.overrideAttrs (old: {
                          src = prev.fetchurl {
                            url = "https://download2.interactivebrokers.com/installers/tws/stable-standalone/tws-stable-standalone-linux-x64.sh";
                            sha256 = "+z77sypqbN9PMMOQnJTfdDHRP5NVfTOCUBT0AaAn87Y=";
                          };
                        });
                      };
                  };
              };
          })
        ];
      };
      lib = nixpkgs.lib;
      # Function to generate a NixOS system configuration
      mkNixosSystem = {
        host,
        username,
      }:
        lib.nixosSystem {
          # Pass all flake inputs to modules via specialArgs.
          # This is the standard way to make them available where needed.
          specialArgs = {inherit inputs username host system pkgs lib;};

          modules = [
            # Now, import all necessary modules.
            # They can access the inputs via the `inputs` argument
            # that specialArgs provides.
            disko.nixosModules.default
            sops-nix.nixosModules.sops
            nur.modules.nixos.default
            stylix.nixosModules.stylix
            # Your custom host and user configurations
            ./hosts/${host}/config.nix
            ./hosts/${host}/sops.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                # Pass flake inputs to home-manager modules as well
                extraSpecialArgs = {inherit inputs username system pkgs lib;};
                users.${username} = {
                  imports = [
                    ./pkgs/home.nix
                  ];
                };
              };
            }
          ];
        };
    in {
      nixosConfigurations = {
        "lf-nix" = mkNixosSystem {
          host = "lf-nix";
          username = "lf";
        };

        "viech" = mkNixosSystem {
          host = "viech";
          username = "lf";
        };
      };

      homeConfigurations = {
        "lf@lf-nix" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs lib;
          extraSpecialArgs = { inherit inputs username system; };
          modules = [
            inputs.stylix.homeModules.stylix
            ./pkgs/home.nix
          ];
        };
        "lf@viech" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs lib;
          extraSpecialArgs = { inherit inputs username system; };
          modules = [
            inputs.stylix.homeModules.stylix
            ./pkgs/home.nix
          ];
        };
      };
    });
}
