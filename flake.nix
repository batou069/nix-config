{
  # description = "Laurent's NixOS-Hyprland"; 
  	
  inputs = {
	nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  ags = {
      url = "github:aylur/ags/v1";
      inputs.nixpkgs.follows = "nixpkgs";
    };  	
  };

  outputs = inputs@{ self, nixpkgs, ags, ... }:
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
	          ];
	        };
        };
      };
}
# outputs = { self, nixpkgs, ags, ... }@inputs:
#   {
#     nixosConfigurations.lf-nix = nixpkgs.lib.nixosSystem {
#       system = "x86_64-linux";
#       modules = [
#         ./config.nix
#         ./hardware.nix
#         ./packages-fonts.nix
#         ./users.nix
#         # Other modules
#       ];
#     };
#   };
# }