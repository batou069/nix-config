{
  programs.nixvim = {
    plugins = {
      lazygit.enable = true;
      neogit = {
        enable = true;
        settings.integrations.diffview = true;
      };
      gitblame = {
        enable = true;
        settings.enabled = false;
      };
      gitsigns = {
        enable = true;
        settings = {
          current_line_blame = false;
          signcolumn = true;
        };
      };
      diffview.enable = true;
    };
    keymaps = [
      # Main Git Tools
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>LazyGit<CR>";
        options = {
          desc = "LazyGit";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gs";
        action = "<cmd>Neogit<CR>";
        options = {
          desc = "Git Status";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gl";
        action = "<cmd>Telescope git_commits<CR>";
        options = {
          desc = "Git Log";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gL";
        action = "<cmd>Telescope git_bcommits<CR>";
        options = {
          desc = "Buffer Log";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gb";
        action = "<cmd>Telescope git_branches<CR>";
        options = {
          desc = "Git Branches";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gS";
        action = "<cmd>Telescope git_stash<CR>";
        options = {
          desc = "Git Stash";
          silent = true;
        };
      }

      # Blame & Diff
      {
        mode = "n";
        key = "<leader>gB";
        action = "<cmd>GitBlameToggle<CR>";
        options = {
          desc = "Toggle Blame Line";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gd";
        action = "<cmd>Gitsigns diffthis<CR>";
        options = {
          desc = "Diff This";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gD";
        action = "<cmd>DiffviewOpen<CR>";
        options = {
          desc = "Diffview Open";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gQ";
        action = "<cmd>DiffviewClose<CR>";
        options = {
          desc = "Diffview Close";
          silent = true;
        };
      }

      # Hunk Actions (gh)
      {
        mode = "n";
        key = "<leader>ghs";
        action = "<cmd>Gitsigns stage_hunk<CR>";
        options = {
          desc = "Stage Hunk";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ghr";
        action = "<cmd>Gitsigns reset_hunk<CR>";
        options = {
          desc = "Reset Hunk";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ghu";
        action = "<cmd>Gitsigns undo_stage_hunk<CR>";
        options = {
          desc = "Undo Stage Hunk";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ghp";
        action = "<cmd>Gitsigns preview_hunk<CR>";
        options = {
          desc = "Preview Hunk";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ghb";
        action = "<cmd>Gitsigns blame_line{full=true}<CR>";
        options = {
          desc = "Blame Hunk (Full)";
          silent = true;
        };
      }

      # Navigation
      {
        mode = "n";
        key = "]h";
        action = "<cmd>Gitsigns next_hunk<CR>";
        options = {
          desc = "Next Hunk";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "[h";
        action = "<cmd>Gitsigns prev_hunk<CR>";
        options = {
          desc = "Prev Hunk";
          silent = true;
        };
      }
    ];
  };
}
