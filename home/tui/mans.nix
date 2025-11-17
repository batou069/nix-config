{ ... }: {
  programs.man.enable = true; # lib.mkDefault false;

  manual = {
    html.enable = true;
    manpages.enable = true;
  };
}
