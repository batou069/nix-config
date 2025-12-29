{ lib, ... }: {
  imports = import ../modules/import-tree.nix lib ./.;
}
