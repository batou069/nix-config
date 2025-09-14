{
  pkgs,
  lib,
  ...
}: {
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
        keymap = {
          preset = "default";
        };
        appearance = {
          nerd_font_variant = "mono";
        };
        completion = {
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 750;
          };
        };

        sources = {
          default = [
            "lsp"
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
              opts = {};
            };
            avante_files = {
              name = "avante_files";
              module = "blink.compat.source";
              score_offset = 100; # show at a higher priority than lsp
              opts = {};
            };
            avante_mentions = {
              name = "avante_mentions";
              module = "blink.compat.source";
              score_offset = 1000; # show at a higher priority than lsp
              opts = {};
            };
            avante_shortcuts = {
              name = "avante_shortcuts";
              module = "blink.compat.source";
              score_offset = 1000; # show at a higher priority than lsp
              opts = {};
            };
          };
        };

        fuzzy = {
          implementation = "lua";
        };
        signature = {
          enabled = true;
        };

        snippets = {
          preset = "luasnip";
        };
      };
    };
  };
}
