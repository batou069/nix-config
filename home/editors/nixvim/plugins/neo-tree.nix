{ ... }: {
  programs.nixvim = {
    plugins = {
      nui.enable = true;

      neo-tree = {
        enable = true;
        settings = {
          close_if_last_window = true;
          popup_border_style = "NC";
          enable_git_status = true;
          enable_diagnostics = true;
          open_files_do_not_replace_types = [ "terminal" "trouble" "qf" ];
          open_files_using_relative_paths = false;
          filesystem = {
            follow_current_file = {
              enabled = true;
              leave_dirs_open = true;
            };
            use_libuv_file_watcher = true;
            filteredItems = {
              hide_gitignored = true;
              hideDotfiles = false;
              neverShowByPattern = [
                "__pycache__"
                "node_modules"
                ".git"
                ".DS_Store"
              ];
            };
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>ee";
        action = "<cmd>Neotree toggle<CR>";
        options = {
          desc = "Toggle Explorer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ef";
        action = "<cmd>Neotree reveal<CR>";
        options = {
          desc = "Reveal File";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ec";
        action = "<cmd>Neotree close<CR>";
        options = {
          desc = "Close Explorer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>es";
        action = "<cmd>Neotree git_status<CR>";
        options = {
          desc = "Git Status";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>eb";
        action = "<cmd>Neotree buffers<CR>";
        options = {
          desc = "Explorer Buffers";
          silent = true;
        };
      }
    ];
  };
}
