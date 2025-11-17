{ inputs, ... }: {
  exports.flake =
    let
      system = "x86_64-linux";
      lib = inputs.nixpkgs.lib; # Re-defined for clarity, or access via the function argument 'lib'
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
            modules
            ++ [
              inputs.hyprland.nixosModules.default
              inputs.disko.nixosModules.default
              inputs.sops-nix.nixosModules.sops
              inputs.nur.modules.nixos.default
              inputs.stylix.nixosModules.stylix
              # inputs.mango.nixosModules.mango
              ./hosts/${host}/config.nix
              ./hosts/${host}/sops.nix
              ./hosts/${host}/home.nix
            ];
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
    };
}
