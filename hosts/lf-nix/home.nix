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
  # Use the NixOS pkgs (which has our overlays applied)
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # Pass inputs to Home Manager modules
  home-manager.extraSpecialArgs = { inherit inputs pkgs libPkg libPkgs libOverlay pkgs-stable; };

  home-manager.users.${username} = {
    # This is where we import all the modules for this user's Home Manager configuration.
    imports = [
      # 1. Import the sops-nix module for Home Manager.
      inputs.sops-nix.homeManagerModules.sops

      # 2. Import our shared Home Manager sops configuration.
      ../../modules/hm-sops.nix

      # 3. Import the main, shared user configuration.
      ../../home/home.nix
    ];

    # Set the state version for this specific user configuration.
    home.stateVersion = "24.11";
  };
}
