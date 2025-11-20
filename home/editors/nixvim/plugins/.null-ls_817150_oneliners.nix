{ ... }: {
  programs.nixvim = {
    plugins = {
      nvim-surround.enable = true;
      nix-develop.enable = true;
      lualine.enable = true;
      bufferline.enable = true;
      luasnip.enable = true;
      rainbow-delimiters.enable = true;
      yazi.enable = true;
      nix.enable = true;
      lazygit.enable = true;
      auto-session = {
        enable = true;
        settings = {
          log_level = "error";
          git_use_branch_name = true;
          use_git_branch = true; # Create sessions per git branch
          suppressed_dirs = [ "~" ]; # Don't create sessions for home dir
          bypass_save_filetypes = [
            "neo-tree"
            "dashboard"
          ]; # Don't save when only these buffers are open
          session_lens = {
            load_on_setup = true;
            picker_opts.border = true;
          };
        };
      };
      comment.enable = true;
      comment-box.enable = true;
      notify.enable = true;
      barbecue.enable = true;
      leap = {
        enable = true;
        settings.silent = true;
      };
      neogit.enable = true;
      neogen.enable = true;
      multicursors.enable = true;
      markdown-preview.enable = true;
      markview.enable = true;
      easyescape.enable = true;
      gitblame.enable = true;
      gitsigns.enable = true;
      illuminate.enable = false;
      jupytext.enable = true;
      # cursorline.enable = false;
      fidget.enable = true;
      sleuth.enable = true;
      smear-cursor.enable = true;
      spectre.enable = true;
      lint.enable = false;
      undotree.enable = true;
      trim.enable = true;
      # fugitive.enable = false;
      flash.enable = true;
      noice = {
        enable = true;
        settings.presets.lsp_doc_border = true;
      };
    };
  };
}
