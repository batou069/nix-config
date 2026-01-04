{ ... }: {
  programs.nixvim = {
    plugins = {
      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
          undo.enable = true;
        };
      };
      fzf-lua = {
        enable = true;
        profile = "fzf-tmux";
      };
    };

    keymaps = [
      # Files
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
        options = {
          desc = "Find Files";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>Telescope oldfiles<CR>";
        options = {
          desc = "Recent Files";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fc";
        action = "<cmd>Telescope find_files cwd=~/nix<CR>";
        options = {
          desc = "Find Config";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fp";
        action = "<cmd>Telescope git_files<CR>";
        options = {
          desc = "Find Project Files";
          silent = true;
        };
      }

      # Search
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
        options = {
          desc = "Live Grep";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fw";
        action = "<cmd>Telescope grep_string<CR>";
        options = {
          desc = "Grep Word";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>f/";
        action = "<cmd>Telescope search_history<CR>";
        options = {
          desc = "Search History";
          silent = true;
        };
      }

      # Neovim
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<CR>";
        options = {
          desc = "Find Buffers";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<CR>";
        options = {
          desc = "Help Tags";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fk";
        action = "<cmd>Telescope keymaps<CR>";
        options = {
          desc = "Keymaps";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fn";
        action = "<cmd>Telescope man_pages<CR>";
        options = {
          desc = "Man Pages";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fo";
        action = "<cmd>Telescope vim_options<CR>";
        options = {
          desc = "Vim Options";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fC";
        action = "<cmd>Telescope colorscheme<CR>";
        options = {
          desc = "Colorschemes";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fa";
        action = "<cmd>Telescope autocommands<CR>";
        options = {
          desc = "Autocommands";
          silent = true;
        };
      }

      # Lists
      {
        mode = "n";
        key = "<leader>f\"";
        action = "<cmd>Telescope registers<CR>";
        options = {
          desc = "Registers";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>f'";
        action = "<cmd>Telescope marks<CR>";
        options = {
          desc = "Marks";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fq";
        action = "<cmd>Telescope quickfix<CR>";
        options = {
          desc = "Quickfix List";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fl";
        action = "<cmd>Telescope loclist<CR>";
        options = {
          desc = "Location List";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>fR";
        action = "<cmd>Telescope resume<CR>";
        options = {
          desc = "Resume Picker";
          silent = true;
        };
      }

      # FZF-Lua (Alternative)
      {
        mode = "n";
        key = "<leader>fz";
        action = "<cmd>FzfLua<CR>";
        options = {
          desc = "FzfLua (Root)";
          silent = true;
        };
      }
    ];
  };
}
