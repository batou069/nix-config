{ pkgs-unstable, ... }: {
  programs.nix-search-tv = {
    enable = true;
    package = pkgs-unstable.nix-search-tv;
    enableTelevisionIntegration = true;
  };
}
