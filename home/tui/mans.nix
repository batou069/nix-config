{ ... }: {
  programs.man = {
    enable = false; # lib.mkDefault false;
    # package = pkgs-stable.man;
  };

  manual = {
    html.enable = false;
    manpages.enable = false;
    json.enable = false;
  };
}
