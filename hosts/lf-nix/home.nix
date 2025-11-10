{ username
, inputs
, system
, pkgs
, pkgs-unstable
, dotfiles
, ...
}: {
  # This section configures the specific user environments
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit inputs username system pkgs pkgs-unstable dotfiles;
    };
    users.${username} = {
      imports = [
        inputs.nix-doom-emacs-unstraightened.homeModule
        ../../pkgs/home.nix
      ];
    };
  };
}
