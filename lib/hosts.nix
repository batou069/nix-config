# lib/hosts.nix
#
# This file defines the data for all the systems in the flake.
# It's imported by the `lib` to be used by the builder functions.
{ inputs, ... }: {
  # List of NixOS hosts
  nixos = {
    "lf-nix" = {
      system = "x86_64-linux";
      username = "lf";
      modules = [
        inputs.home-manager.nixosModules.home-manager
        ../hosts/lf-nix/home.nix
        # Inject the sops-nix home-manager module for this user
        {
          home-manager.users.lf.imports = [
            inputs.sops-nix.homeManagerModules.sops
          ];
        }
      ];
    };
    "viech" = {
      system = "x86_64-linux";
      username = "lf";
      modules = [
        inputs.home-manager.nixosModules.home-manager
        # Inject the sops-nix home-manager module for this user
        {
          home-manager.users.lf.imports = [
            inputs.sops-nix.homeManagerModules.sops
          ];
        }
      ];
    };
  };

  # List of standalone Home Manager configurations
  home = {
    "lf" = {
      system = "x86_64-linux";
      username = "lf";
      modules = [
        inputs.nur.modules.homeManager.default
        inputs.nix-doom-emacs-unstraightened.homeModule
      ];
    };
  };
}
