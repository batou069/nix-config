# Centralized keybindings for nixvim
{ ... }: {
  programs.nixvim = {
    keymaps = [
      # General & Navigation
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
        key = "<leader>fp";
        action = "<cmd>Telescope find_files<cr>";
        options.desc = "Find Project File";
      }

      # Neo-tree
      {
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options.desc = "Toggle Neo-tree";
      }

      # Git
      {
        key = "<leader>gg";
        action = "<cmd>LazyGit<cr>";
        options.desc = "LazyGit";
      }

      # Terminal
      {
        key = "<C-q>";
        action = "<cmd>Lspsaga term_toggle<cr>";
        options.desc = "Floating Terminal";
      }
      {
        key = "<leader>t";
        action = "<cmd>split<bar>terminal<bar>resize 10<cr>";
        options.desc = "Split Terminal";
      }

      # Editing & LSP
      {
        key = "<leader>rn";
        action = "<cmd>IncRename ";
        options.desc = "Incremental Rename";
      }
      {
        key = "<leader>co";
        action = "<cmd>TypescriptOrganizeImports<cr>";
        options.desc = "Organize Imports (TS)";
      }
      {
        key = "<leader>cR";
        action = "<cmd>TypescriptRenameFile<cr>";
        options.desc = "Rename File (TS)";
      }
      {
        key = "gK";
        action = "<cmd>lua vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines})<CR>";
        mode = "n";
        options.desc = "Toggle Virtual Lines";
      }

      # Python Execution
      {
        key = "<localleader>r";
        action = "<cmd>w<CR><cmd>term python3 %:p<CR>";
        options.desc = "Run Python File";
      }
      {
        key = "<localleader>t";
        action = "<cmd>w<CR><cmd>term pytest -s %:p<CR>";
        options.desc = "PyTest";
      }

      # DAP (Python)
      # {
      #   key = "<leader>dPt";
      #   action = "<cmd>lua require('dap-python').test_method()<cr>";
      #   options.desc = "Debug Method";
      # }
      # {
      #   key = "<leader>dPc";
      #   action = "<cmd>lua require('dap-python').test_class()<cr>";
      #   options.desc = "Debug Class";
      # }

      # Comment Box
      {
        key = "<localleader>cb";
        action = "<Cmd>CBccbox<CR>";
        mode = [ "n" "v" ];
        options.desc = "Box: Title";
      }
      {
        key = "<localleader>ct";
        action = "<Cmd>CBllline<CR>";
        mode = [ "n" "v" ];
        options.desc = "Box: Titled Line";
      }
      {
        key = "<localleader>cl";
        action = "<Cmd>CBline<CR>";
        mode = "n";
        options.desc = "Box: Simple Line";
      }
      {
        key = "<localleader>cm";
        action = "<Cmd>CBllbox14<CR>";
        mode = [ "n" "v" ];
        options.desc = "Box: Marked";
      }
      {
        key = "<localleader>cd";
        action = "<Cmd>CBd<CR>";
        mode = [ "n" "v" ];
        options.desc = "Box: Delete";
      }

      # Dadbod UI
      {
        key = "<leader>D";
        action = "<cmd>DBUIToggle<CR>";
        options.desc = "Toggle DBUI";
      }

      # Treesj
      {
        key = "<space>m";
        action = "<cmd>TSJToggle<cr>";
        options.desc = "Toggle Join/Split";
      }
      {
        key = "<space>j";
        action = "<cmd>TSJJoin<cr>";
        options.desc = "Join Node";
      }
      {
        key = "<space>s"; # Changed from h to s for split
        action = "<cmd>TSJSplit<cr>";
        options.desc = "Split Node";
      }

      # Yanky
      {
        key = "<leader>p";
        action = "<cmd>Telescope yank_history<cr>";
        mode = [ "n" "x" ];
        options.desc = "Open Yank History";
      }
      {
        key = "y";
        action = "<Plug>(YankyYank)";
        mode = [ "n" "x" ];
        options.desc = "Yank text";
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
      {
        key = "p";
        action = "<Plug>(YankyPutAfter)";
        mode = [ "n" "x" ];
        options.desc = "Put after cursor";
      }
      {
        key = "P";
        action = "<Plug>(YankyPutBefore)";
        mode = [ "n" "x" ];
        options.desc = "Put before cursor";
      }
      {
        key = "gp";
        action = "<Plug>(YankyGPutAfter)";
        mode = [ "n" "x" ];
        options.desc = "Put after selection";
      }
      {
        key = "gP";
        action = "<Plug>(YankyGPutBefore)";
        mode = [ "n" "x" ];
        options.desc = "Put before selection";
      }
      {
        key = "]p";
        action = "<Plug>(YankyPutIndentAfterLinewise)";
        mode = "n";
        options.desc = "Put indented after (linewise)";
      }
      {
        key = "[p";
        action = "<Plug>(YankyPutIndentBeforeLinewise)";
        mode = "n";
        options.desc = "Put indented before (linewise)";
      }
      {
        key = ">p";
        action = "<Plug>(YankyPutIndentAfterShiftRight)";
        mode = "n";
        options.desc = "Put and indent right";
      }
      {
        key = "<p";
        action = "<Plug>(YankyPutIndentAfterShiftLeft)";
        mode = "n";
        options.desc = "Put and indent left";
      }
      {
        key = ">P";
        action = "<Plug>(YankyPutIndentBeforeShiftRight)";
        mode = "n";
        options.desc = "Put before and indent right";
      }
      {
        key = "<P";
        action = "<Plug>(YankyPutIndentBeforeShiftLeft)";
        mode = "n";
        options.desc = "Put before and indent left";
      }
      {
        key = "=p";
        action = "<Plug>(YankyPutAfterFilter)";
        mode = "n";
        options.desc = "Put after with reindent";
      }
      {
        key = "=P";
        action = "<Plug>(YankyPutBeforeFilter)";
        mode = "n";
        options.desc = "Put before with reindent";
      }
      {
        key = "iy";
        action = "<cmd>lua require('yanky.textobj').last_put()<cr>";
        mode = [ "o" "x" ];
        options.desc = "Select last put text";
      }
    ];
  };
}
