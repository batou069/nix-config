# This is a NixOS module that configures the home-manager service for a specific user.
{ username
, inputs
, pkgs
, libPkg
, libPkgs
, libOverlay
, pkgs-stable
, ...
}: {
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit inputs pkgs libPkg libPkgs libOverlay pkgs-stable; };

  home-manager.users.${username} = {
    imports = [
      inputs.sops-nix.homeManagerModules.sops
      ../../modules/hm-sops.nix
    ];
    home.stateVersion = "24.11";
  };
}
