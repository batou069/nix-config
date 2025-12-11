{ inputs, ... }: {
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./nixvim.nix
    ./opts.nix
    ./configs.nix
    # ./dependencies.nix
    ./keymaps.nix
    ./plugins
    ./completion.nix
  ];
}
