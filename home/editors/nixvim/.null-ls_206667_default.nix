{ inputs, ... }: {
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./opts.nix
    ./configs.nix
    ./dependencies.nix
    ./keymaps.nix
    ./plugins
    ./completion.nix
  ];
}
