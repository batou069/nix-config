{ pkgs-unstable, ... }: {
  programs.bat = {
    enable = true;
    package = pkgs-unstable.bat;
    extraPackages = with pkgs-unstable.bat-extras; [
      batdiff
      batman
      prettybat
      batgrep
      batpipe
      batwatch
    ];
  };
}
