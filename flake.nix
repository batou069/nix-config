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
