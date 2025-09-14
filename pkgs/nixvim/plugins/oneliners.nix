{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    plugins = {
      dap-python.enable = true;
      luasnip.enable = true;
      rainbow-delimiters.enable = true;
      snacks.enable = false;
      yazi.enable = false;
      nix.enable = true;
      lazygit.enable = false;
      auto-session.enable = false;
      comment.enable = false;
      comment-box.enable = false;
      notify.enable = false;
      barbecue.enable = false;
      leap.enable = false;
      neogit.enable = false;
      neogen.enable = false;
      multicursors.enable = true;
      markdown-preview.enable = false;
      easyescape.enable = false;
      # gitblame.enable = false;
      # gitsigns.enable = false;
      illuminate.enable = false;
      jupytext.enable = true;
      # cursorline.enable = false;
      fidget.enable = false;
      sleuth.enable = true;
      smear-cursor.enable = true;
      spectre.enable = true;
      lint.enable = false;
      undotree.enable = true;
      trim.enable = true;
      # fugitive.enable = false;
      flash.enable = false;
      noice.enable = false;
    };
  };
}
