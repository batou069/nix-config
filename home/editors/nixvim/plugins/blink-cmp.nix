{ ... }: {
  programs.nixvim = {
    plugins.coq-nvim = {
      enable = false;
      settings = {
        auto_start = true;
        completion = {
          always = true;
        };
        keymap = {
          recommended = true;
        };
      };
    };
    plugins.blink-compat.enable = true;
    plugins.blink-cmp = {
      enable = true;
      settings = {
        snippets = {
          preset = "luasnip";
        };
        signature = {
          enabled = true;
        };
        fuzzy = {
          implementation = "prefer_rust_with_warning";
        };
        keymap = {
          preset = "default";
        };
        appearance = {
          nerd_font_variant = "normal";
        };
        completion = {
          menu.draw.treesitter = "lsp";
          menu.auto_show = false;
          ghost_text.show_with_menu = false;
        };
        documentation = {
          auto_show = true;
          auto_show_delay_ms = 750;
        };

        sources = {
          default = [
            "lsp"
            "buffer"
            "path"
            "snippets"
            "lazydev"
            "avante_commands"
            "avante_mentions"
            "avante_shortcuts"
            "avante_files"
          ];
          providers = {
            lazydev = {
              module = "lazydev.integrations.blink";
              score_offset = 100;
            };
            avante_commands = {
              name = "avante_commands";
              module = "blink.compat.source";
              score_offset = 90; # show at a higher priority than lsp
              opts = { };
            };
            avante_files = {
              name = "avante_files";
              module = "blink.compat.source";
              score_offset = 100; # show at a higher priority than lsp
              opts = { };
            };
            avante_mentions = {
              name = "avante_mentions";
              module = "blink.compat.source";
              score_offset = 1000; # show at a higher priority than lsp
              opts = { };
            };
            avante_shortcuts = {
              name = "avante_shortcuts";
              module = "blink.compat.source";
              score_offset = 1000; # show at a higher priority than lsp
              opts = { };
            };
            lsp = {
              name = "LSP";
              module = "blink.cmp.sources.lsp";
              opts = { };
            };
          };
        };
      };
    };
  };
}
