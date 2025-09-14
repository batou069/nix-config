{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim.plugins = {
    nui.enable = true;

    neo-tree = {
      enable = true;
      settings = {
        close_if_last_window = true; # Close Neo-tree if it is the last window left in the tab
        popup_border_style = "NC"; # -- or "" to use 'winborder' on Neovim v0.11+
        enable_git_status = true;
        enable_diagnostics = true;
        open_files_do_not_replace_types = ["terminal" "trouble" "qf"]; #-- when opening files, do not use windows containing these filetypes or buftypes
        open_files_using_relative_paths = false;
        sort_case_insensitive = false; # -- used when sorting files and directories in the tree
        sort_function = "nil";
        default_component_configs = {
          container = {
            enable_character_fade = true;
          };
        };
        indent = {
          indent_size = 2;
          padding = 1; # -- extra padding on left hand sid;
          # -- indent guide
          with_markers = true;
          indent_marker = "│";
          last_indent_marker = "└";
          highlight = "NeoTreeIndentMarker";
          # -- expander config, needed for nesting file
          with_expanders = "nil"; # -- if nil and file nesting is enabled, will enable expander;
          expander_collapsed = "";
          expander_expanded = "";
          expander_highlight = "NeoTreeExpander";
        };

        name = {
          trailing_slash = false;
          use_filtered_colors = true; # -- Whether to use a different highlight when the file is filtered (hidden, dotfile, etc.).
          use_git_status_colors = true;
          highlight = "NeoTreeFileName";
        };
        git_status = {
          symbols = {
            # -- Change type
            added = ""; # -- or "✚ "
            modified = ""; # -- or " "
            deleted = "✖"; #-- this can only be used in the git_status source
            renamed = "󰁕"; #-- this can only be used in the git_status source
            #   -- Status type
            untracked = "";
            ignored = "";
            unstaged = "󰄱";
            staged = "";
            conflict = "";
          };
        };
        # -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
        file_size = {
          enabled = true;
          width = 12; # -- width of the column
          required_width = 64; # -- min width of window required to show this column
        };
        type = {
          enabled = true;
          width = 10; # -- width of the column
          required_width = 122; # -- min width of window required to show this column
        };
        last_modified = {
          enabled = true;
          width = 20; # -- width of the column
          required_width = 88; #  -- min width of window required to show this column
        };
        created = {
          enabled = true;
          width = 20; # -- width of the column
          required_width = 110; # -- min width of window required to show this column
        };
        symlink_target = {
          enabled = false;
        };

        filesystem = {
          follow_current_file = {
            enabled = true;
            leave_dirs_open = true;
          };
          group_empty_dirs = true;
          hijack_netrw_behavior = "open_default";
          use_libuv_file_watcher = true; # This will use the OS level file watchers to detect changes instead of polling
          filteredItems = {
            hide_gitignored = true;
            hideDotfiles = false;
            # hideHidden = true;
            hide_ignored = true;
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
}
