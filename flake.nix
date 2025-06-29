{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # stylix.url = "github:nix-community/stylix/release-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:aylur/ags/v1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # firefox-addons = {
    #   url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nix-mineral = {
      url = "github:cynicsketch/nix-mineral"; # Refers to the main branch and is updated to the latest commit when you use "nix flake update"
      # url = "github:cynicsketch/nix-mineral/v0.1.6-alpha" # Refers to a specific tag and follows that tag until you change it
      # url = "github:cynicsketch/nix-mineral/cfaf4cf15c7e6dc7f882c471056b57ea9ea0ee61" # Refers to a specific commit and follows that until you change it
      flake = false;
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ags, ... }: let
    system = "x86_64-linux";
    host = "lf-nix";
    username = "lf";
    pkgs = import nixpkgs { 
      inherit system; 
      config.allowUnfree = true;
      };
      # unstablePkgs = import nixpkgs-unstable { inherit system; };
      
  in {
    nixosConfigurations."${host}" = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit system inputs username host; };
      modules = [
        ./hosts/lf-nix/config.nix
        # "${nix-mineral}/nix-mineral.nix"
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.${username} = {
            imports = [ ./hosts/lf-nix/home.nix ];
          };
          home-manager.extraSpecialArgs = { inherit inputs username system; };
        }
      ];
    };
    homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs username system; };
      modulea = [
        ./hosts/lf-nix/home.nix
        {
          home.username = username;
          home.homeDirectory = "/home/${username}";
          home.stateVersion = "24.11";
          home-manager.backupFileExtension = "backup"; 
        }
      ];
    };
  };
}