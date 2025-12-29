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
      ];
    };
    "viech" = {
      system = "x86_64-linux";
      username = "lf";
      modules = [
        inputs.home-manager.nixosModules.home-manager
        ../hosts/viech/home.nix
      ];
      specialArgs = {
        # CAUTION: Verify your disk device name (lsblk)
        device = "/dev/nvme0n1";
        swap = "8G";
      };
    };
  };

  # List of standalone Home Manager configurations
  home = {
    "lf@lf-nix" = {
      system = "x86_64-linux";
      username = "lf";
      modules = [
        ../home/_common.nix
      ];
    };
    "lf@viech" = {
      system = "x86_64-linux";
      username = "lf";
      modules = [
        ../home/_common.nix
        ../home/_local-ai.nix
      ];
    };
  };
}
