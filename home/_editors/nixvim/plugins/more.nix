{ ... }: {
  programs.nixvim = {
    plugins = {
      # Utilities
      yanky = {
        enable = true;
      };

      indent-blankline = {
        enable = true;
        settings = {
          indent = {
            char = "│";
            tab_char = "│";
          };
          exclude = {
            filetypes = [
              "help"
              "dashboard"
              "neo-tree"
              "Trouble"
              "trouble"
              "notify"
              "toggleterm"
            ];
          };
        };
      };

      todo-comments = {
        enable = true;
        settings = {
          signs = true;
        };
      };

      undotree = {
        enable = true;
      };

      spectre = {
        enable = true;
      };

      yazi = {
        enable = true;
      };

      flash = {
        enable = true;
        settings = {
          modes = {
            search = {
              enabled = false;
            };
          };
        };
      };

      auto-session = {
        enable = true;
        log_level = "error";
        settings = {
          auto_session_suppress_dirs = [ "~" "~/Downloads" "/" ];
        };
      };

      harpoon = {
        enable = false;
      };

      lazydev = {
        enable = true;
        settings = {
          library = [
            {
              path = "\${3rd}/luv/library";
              words = [ "vim%.uv" ];
            }
          ];
        };
      };
    };

    keymaps = [
      # Yazi (e)
      {
        mode = "n";
        key = "<leader>ey";
        action = "<cmd>Yazi<CR>";
        options = {
          desc = "Yazi";
          silent = true;
        };
      }

      # Session (s)
      {
        mode = "n";
        key = "<leader>ss";
        action = "<cmd>SessionSave<CR>";
        options = {
          desc = "Save Session";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>sr";
        action = "<cmd>SessionRestore<CR>";
        options = {
          desc = "Restore Session";
          silent = true;
        };
      }

      # Undo (u) - Wait, 'u' is UI. 'f' is find. Undo is 'fu' in telescope.
      # Undotree Toggle
      {
        mode = "n";
        key = "<leader>uu";
        action = "<cmd>UndotreeToggle<CR>";
        options = {
          desc = "Undo Tree";
          silent = true;
        };
      }

      # Spectre (Find/Replace) -> 'S' (Global) or 'rs' (Replace)?
      # User had 'S' in layer 1? No.
      # Let's put Spectre under 'f' (Find) as 'fs' (Spectre)? Or 'R' (Replace)?
      # I'll put it under 'fS' (Search Replace).
      {
        mode = "n";
        key = "<leader>fS";
        action = "<cmd>Spectre<CR>";
        options = {
          desc = "Spectre";
          silent = true;
        };
      }

      # Flash
      {
        mode = [ "n" "x" "o" ];
        key = "s";
        action = "<cmd>lua require('flash').jump()<cr>";
        options = { desc = "Flash"; };
      }
      {
        mode = [ "n" "x" "o" ];
        key = "S";
        action = "<cmd>lua require('flash').treesitter()<cr>";
        options = { desc = "Flash Treesitter"; };
      }

      # Todo Comments
      {
        mode = "n";
        key = "]t";
        action = "<cmd>lua require('todo-comments').jump_next()<cr>";
        options = {
          desc = "Next Todo";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "[t";
        action = "<cmd>lua require('todo-comments').jump_prev()<cr>";
        options = {
          desc = "Prev Todo";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ft";
        action = "<cmd>TodoTelescope<cr>";
        options = {
          desc = "Find Todos";
          silent = true;
        };
      }
    ];
  };
}
