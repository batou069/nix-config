{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim.plugins = {
    dap.enable = true;
    dap-ui.enable = true;
    dap-virtual-text.enable = true;
  };
}
