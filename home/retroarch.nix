{ pkgs, ... }: {
  programs.retroarch = {
    enable = true;
    cores = {
      mgba.enable = true;
      genesis-plus-gx.enable = true;
      dosbox-pure.enable = true;
      dolphin.enable = true;
      bsnes.enable = true;
      blastem.enable = true;
      yabause.enable = true;
      citra.enable = true;
      vice-xvic.enable = true;
      snes9x = {
        enable = true;
        package = pkgs.libretro.snes9x2010;
      };
    };
  };
}
