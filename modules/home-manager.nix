{ inputs, username, system, ... }: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      extraSpecialArgs = { inherit inputs username system; };
      users.${username} = {
        imports = [ ../hosts/lf-nix/home.nix ];
      };
    };
  }