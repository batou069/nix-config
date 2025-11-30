{ pkgs-unstable, ... }: {
  programs.nh = {
    enable = true;
    package = pkgs-unstable.nh;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/lf/nix";
  };
}
