{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    plugins.which-key = {
      enable = true;
      settings = {
        timeout = 500;
      };
    };
  };
}
