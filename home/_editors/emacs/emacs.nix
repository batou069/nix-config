# ./pkgs/home.nix
{ pkgs
, dotfiles
, ...
}: {
  programs.doom-emacs = {
    enable = true;
    provideEmacs = true;
    doomDir = dotfiles;
    extraPackages = _epkgs: [
      pkgs.notmuch # <-- This is where 'notmuch' now goes!
    ];
  };
}
