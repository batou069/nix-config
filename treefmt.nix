{ pkgs, ... }:

{
  # Tell treefmt where your project root is
  projectRootFile = "flake.nix";

  # Enable the Nix formatter, alejandra
  programs.alejandra.enable = true;
}
