{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
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
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ags,
    disko,
    sops-nix,
    nur,
    ...
  }: let
    # Function to generate a NixOS system configuration
    mkNixosSystem = {
      system,
      host,
      username,
    }:
      nixpkgs.lib.nixosSystem {
        # Pass all flake inputs to modules via specialArgs.
        # This is the standard way to make them available where needed.
        specialArgs = {inherit inputs username host system;};

        modules = [
          # Define overlays in a single, clean module.
          {
            nixpkgs.overlays = [
              (final: prev: {
                # Add unstable packages under pkgs.unstable
                unstable = import nixpkgs-unstable {
                  inherit system;
                  config.allowUnfree = true;
                };
                # Add other packages from flake inputs
                claudia = inputs.claudia.packages.${prev.system}.default;
                ags = inputs.ags.packages.${prev.system}.default;
                firefox-addons = inputs.firefox-addons.packages.${prev.system};
              })
            ];
            # Allow unfree packages for the main pkgs set
            nixpkgs.config.allowUnfree = true;
          }

          # Now, import all necessary modules.
          # They can access the inputs via the `inputs` argument
          # that specialArgs provides.
          disko.nixosModules.default
          sops-nix.nixosModules.sops # Corrected module name
          nur.nixosModules.nur

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
              extraSpecialArgs = {inherit inputs username system;};
              users.${username} = {
                imports = [./pkgs/home.nix];
              };
            };
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

    # This 'services' block is invalid here.
    # Move the unison configuration to your NixOS configuration,
    # for example, inside ./hosts/lf-nix/config.nix
    #
    # services.unison = {
    #   enable = true;
    #   profiles = {
    #     org = {
    #       src = "/home/moredhel/org";
    #       dest = "/home/moredhel/org.backup";
    #       extraArgs = "-batch -watch -ui text -repeat 60 -fat";
    #     };
    #   };
    # };
  };
}
