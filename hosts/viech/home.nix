# This is a NixOS module that configures the home-manager service for a specific user.
{ username, ... }: {
  imports = [ ../default/home.nix ];

  home-manager.users.${username} = {
    # This is where we import all the modules for this user's Home Manager configuration.
    imports = [
      ../../home/_common.nix
    ];
  };
}
