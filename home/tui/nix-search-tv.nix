{ pkgs, ... }: {
  programs.nix-search-tv = {
    enable = true;
    package = pkgs.nix-search-tv;
    enableTelevisionIntegration = true;
  };
}
