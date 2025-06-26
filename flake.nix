{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    # stylix.url = "github:nix-community/stylix/release-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:aylur/ags/v1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ags, ... }:
    let
      system = "x86_64-linux";
      host = "lf-nix";
      username = "lf";

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
      {
        nixosConfigurations = {
          "${host}" = nixpkgs.lib.nixosSystem rec {
            specialArgs = {
              inherit system;
              inherit inputs;
              inherit username;
              inherit host;
            };
            modules = [
              ./hosts/lf-nix/config.nix
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${username} = import ./hosts/lf-nix/home.nix;
                home-manager.extraSpecialArgs = { inherit inputs username; };
              }
            ];
          };
        };

        homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./hosts/lf-nix/home.nix
            {
              home.username = username;
              home.homeDirectory = "/home/${username}";
              home.stateVersion = "24.11";
            }
          ];
          extraSpecialArgs = { inherit inputs username; };
        };
      };
}