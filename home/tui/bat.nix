{ pkgs, ... }: {
  programs.bat = {
    enable = true;
    package = pkgs.bat;
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      prettybat
      batgrep
      batpipe
      batwatch
    ];
  };
}
