{ ... }: {
  programs.nixvim = {
    plugins = {
      nvim-surround.enable = true;
      nix-develop.enable = true;
      bufferline.enable = true;
      luasnip.enable = true;
      rainbow-delimiters.enable = true;
      nix.enable = true;

      # Moved to git.nix: lazygit, neogit, gitblame, gitsigns

      # Moved to more.nix: yazi, auto-session, undotree, spectre, flash, todo-comments, yanky, indent-blankline

      comment.enable = true;
      comment-box.enable = true;
      notify.enable = true;
      barbecue.enable = false;

      leap = {
        enable = true;
        settings.silent = true;
      };

      neogen.enable = true;
      multicursors.enable = true;
      markdown-preview.enable = true;
      markview.enable = true;
      easyescape.enable = true;

      illuminate.enable = false;
      jupytext.enable = true;

      fidget.enable = true;
      sleuth.enable = true;
      smear-cursor.enable = true;
      lint.enable = false;
      trim.enable = true;

      noice = {
        enable = true;
        settings = {
          presets = {
            bottom_search = true;
            command_palette = true;
            long_message_to_split = true;
            lsp_doc_border = true;
          };
          cmdline = {
            view = "cmdline";
          };
          lsp = {
            override = {
              "vim.lsp.util.convert_input_to_markdown_lines" = true;
              "vim.lsp.util.stylize_markdown" = true;
            };
          };
        };
      };
    };
  };
}
