# Centralized keybindings for nixvim
{ ... }: {
  programs.nixvim = {
    # Disable all default keymaps that are not explicitly set
    globals.mapleader = " ";
    globals.maplocalleader = ",";

    keymaps = [
      # General & Navigation
      {
        key = "<leader><space>";
        action = "<cmd>nohlsearch<cr>";
        options.desc = "Clear Search Highlight";
      }
      {
        key = "n";
        action = "nzzzv";
        mode = "n";
        options.desc = "Next search result (centered)";
      }
      {
        key = "N";
        action = "Nzzzv";
        mode = "n";
        options.desc = "Previous search result (centered)";
      }

      # Saving & Sourcing
      {
        key = "<leader>w";
        action = "<cmd>w<CR>";
        options.desc = "Save Buffer";
      }
      {
        key = "<leader>q";
        action = "<cmd>q<CR>";
        options.desc = "Quit Buffer";
      }
      {
        key = "<leader>sn";
        action = "<cmd>noautocmd w <CR>";
        options.desc = "Save without auto-formatting";
      }
      {
        key = "<leader><leader>S";
        action = "<cmd>source %<cr>";
        options.desc = "Source Buffer";
      }

      # Telescope
      {
        key = "<leader>f";
        action = "<Nop>";
        options.desc = "Find (Telescope)";
      }
      {
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<cr>";
        options.desc = "Find Files";
      }
      {
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<cr>";
        options.desc = "Live Grep";
      }
      {
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<cr>";
        options.desc = "Find Buffers";
      }
      {
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<cr>";
        options.desc = "Help Tags";
      }
      {
        key = "<leader>fo";
        action = "<cmd>Telescope oldfiles<cr>";
        options.desc = "Find Old Files";
      }
      {
        key = "<leader>fz";
        action = "<cmd>Telescope current_buffer_fuzzy_find<cr>";
        options.desc = "Fuzzy Find in Buffer";
      }
      {
        key = "<leader>fr";
        action = "<cmd>Telescope session-lens search_session<cr>";
        options.desc = "Find Session (Restore)";
      }

      # Neo-tree
      {
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options.desc = "Toggle File Explorer";
      }

      # Git
      {
        key = "<leader>g";
        action = "<Nop>";
        options.desc = "Git";
      }
      {
        key = "<leader>gg";
        action = "<cmd>LazyGit<cr>";
        options.desc = "LazyGit";
      }
      {
        key = "<leader>gs";
        action = "<cmd>Gitsigns stage_hunk<cr>";
        options.desc = "Stage Hunk";
      }
      {
        key = "<leader>gu";
        action = "<cmd>Gitsigns undo_stage_hunk<cr>";
        options.desc = "Undo Stage Hunk";
      }
      {
        key = "<leader>gb";
        action = "<cmd>GitBlameToggle<cr>";
        options.desc = "Toggle Git Blame";
      }

      # Terminal
      {
        key = "<leader>t";
        action = "<Nop>";
        options.desc = "Terminal";
      }
      {
        key = "<leader>tt";
        action = "<cmd>toggleterm<cr>";
        options.desc = "Toggle Floating Terminal";
      }
      {
        key = "<leader>ts";
        action = "<cmd>split<bar>terminal<bar>resize 10<cr>";
        options.desc = "Split Terminal";
      }

      # LSP (Code Intelligence)
      {
        key = "<leader>c";
        action = "<Nop>";
        options.desc = "Code";
      }
      {
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
        options.desc = "Code Action";
      }
      {
        key = "<leader>cd";
        action = "<cmd>Telescope diagnostics<cr>";
        options.desc = "Show Diagnostics";
      }
      {
        key = "<leader>cr";
        action = "<cmd>lua vim.lsp.buf.rename()<cr>";
        options.desc = "Rename";
      }
      {
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<cr>";
        mode = "n";
        options.desc = "Hover Documentation";
      }
      {
        key = "gd";
        action = "<cmd>lua vim.lsp.buf.definition()<cr>";
        mode = "n";
        options.desc = "Go to Definition";
      }
      {
        key = "gr";
        action = "<cmd>Telescope lsp_references<cr>";
        mode = "n";
        options.desc = "Find References";
      }

      # Commenting
      {
        key = "<leader>/";
        action = "gcc";
        mode = "n";
        options.remap = true;
        options.desc = "Toggle Comment";
      }
      {
        key = "<leader>/";
        action = "gc";
        mode = "v";
        options.remap = true;
        options.desc = "Toggle Comment (Visual)";
      }

      # Yanky (Yank History)
      {
        key = "<leader>p";
        action = "<cmd>Telescope yank_history<cr>";
        options.desc = "Yank History";
      }
      {
        key = "<c-p>";
        action = "<Plug>(YankyPreviousEntry)";
        mode = "n";
        options.desc = "Previous yank history";
      }
      {
        key = "<c-n>";
        action = "<Plug>(YankyNextEntry)";
        mode = "n";
        options.desc = "Next yank history";
      }

      # Leap (Motion)
      {
        key = "s";
        action = "<Plug>(leap)";
        mode = [ "n" "x" "o" ];
        options.desc = "Leap Forward";
      }
      {
        key = "S";
        action = "<Plug>(leap-from-window)";
        mode = "n";
        options.desc = "Leap from Window";
      }
      # Python Execution
      {
        key = "<localleader>p";
        options.desc = "Python";
      }
      {
        key = "<localleader>pr";
        action = "<cmd>w<CR><cmd>term python3 %:p<CR>";
        options.desc = "Run Python File";
      }
      {
        key = "<localleader>pt";
        action = "<cmd>w<CR><cmd>term pytest -s %:p<CR>";
        options.desc = "PyTest";
      }
    ];
  };
}
