{
  description = "Laurent's NixOS-Hyprland"; 
  	
  inputs = {
	nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
	ags.url = "github:aylur/ags/v1"; # aylurs-gtk-shell-v1
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
            ./hosts/${host}/hardware.nix
	    ./hosts/${host}/users.nix
	    ./hosts/${host}/packages-fonts.nix
            ./hosts/${host}/config.nix
	  ];
	};
      };
    };
}
