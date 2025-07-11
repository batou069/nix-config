{pkgs, ...}: {
  programs.doom-emacs = {
    enable = true;

    # Recommended: Use emacs-pgtk for the best Wayland/graphical experience
    emacsPackage = pkgs.emacs-pgtk;

    # Point to your personal configuration directory
    doomPrivateDir = ./doom.d;
  };
}
