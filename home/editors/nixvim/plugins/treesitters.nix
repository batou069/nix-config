{ pkgs, ... }: {
  programs.nixvim = {
    plugins = {
      treesitter-textobjects = {
        enable = true;
        settings = {
          select = {
            enable = true;
            lookahead = true;
            keymaps = {
              "af" = "@function.outer";
              "if" = "@function.inner";
              "ac" = "@class.outer";
              "ic" = "@class.inner";
              "as" = "@scope";
              "is" = "@scope.inner";
              "aa" = "@parameter.outer";
              "ia" = "@parameter.inner";
            };
          };
          move = {
            enable = true;
            setJumps = true;
            gotoNextStart = {
              "]m" = "@function.outer";
              "]]" = "@class.outer";
            };
            gotoNextEnd = {
              "]M" = "@function.outer";
              "][" = "@class.outer";
            };
            gotoPreviousStart = {
              "[m" = "@function.outer";
              "[[" = "@class.outer";
            };
            gotoPreviousEnd = {
              "[M" = "@function.outer";
              "[]" = "@class.outer";
            };
          };
          swap = {
            enable = true;
            swapNext = {
              "<leader>a" = "@parameter.inner";
            };
            swapPrevious = {
              "<leader>A" = "@parameter.inner";
            };
          };
        };
      };
      treesitter-context = {
        enable = true;
        settings.lang = {
          python = "# %s";
        };
      };

      ts-comments.enable = true;

      treesitter = {
        enable = true;
        folding = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          tmux
          nix
          query
          vim
          vimdoc
          csv
          diff
          editorconfig
          git_config
          git_rebase
          gitattributes
          gitcommit
          gitignore
          c
          cpp
          go
          javascript
          json
          lua
          nix
          python
          markdown
          markdown_inline
          regex
          rust
          toml
          typescript
          yaml
          python
          hyprlang
        ];
        settings = {
          # Installing tree-sitter grammars from nvim-treesitter
          # (can be combined with grammarPackages from Nixpkgs)
          # https://nix-community.github.io/nixvim/plugins/treesitter/index.html#installing-tree-sitter-grammars-from-nvim-treesitter
          auto_install = false;
          ensureInstalled = "all";

          highlight = {
            enable = true;

            # Some languages depend on vim's regex highlighting system for indent rules.
            additional_vim_regex_highlighting = true;
            custom_captures = { };
            disable = [
              "rust"
            ];
          };
          ignore_install = [
            "rust"
          ];
          incremental_selection = {
            enable = true;
            keymaps = {
              init_selection = false;
              node_decremental = "grm";
              node_incremental = "grn";
              scope_incremental = "grc";
            };
          };

          parser_install_dir = {
            __raw = "vim.fs.joinpath(vim.fn.stdpath('data'), 'treesitter')";
          };
          sync_install = false;
          indent = {
            enable = true;
            disable = [
              "ruby"
            ];
          };

          # There are additional nvim-treesitter modules that you can use to interact
          # with nvim-treesitter. You should go explore a few and see what interests you:
          #
          #    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
          #    - Show your current context: https://nix-community.github.io/nixvim/plugins/treesitter-context/index.html
          #    - Treesitter + textobjects: https://nix-community.github.io/nixvim/plugins/treesitter-textobjects/index.html
        };
      };
    };
  };
}
