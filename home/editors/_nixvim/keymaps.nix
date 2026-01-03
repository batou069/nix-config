{ ... }: {
  programs.nixvim = {
    globals.mapleader = " ";
    globals.maplocalleader = ",";

    keymaps = [
      # General
      {
        key = "<leader><space>";
        action = "<cmd>nohlsearch<cr>";
        options.desc = "Clear Highlight";
      }

      # --- Windows (w) ---
      {
        mode = "n";
        key = "<leader>ws";
        action = "<cmd>split<CR>";
        options = {
          desc = "Split Horizontal";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>wv";
        action = "<cmd>vsplit<CR>";
        options = {
          desc = "Split Vertical";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>wd";
        action = "<C-w>q";
        options = {
          desc = "Close Window";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>wq";
        action = "<C-w>q";
        options = {
          desc = "Close Window";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>wo";
        action = "<C-w>o";
        options = {
          desc = "Close Others";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>w=";
        action = "<C-w>=<CR>";
        options = {
          desc = "Balance Windows";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>wm";
        action = "<C-w>|<C-w>_";
        options = {
          desc = "Maximize Window";
          silent = true;
        };
      }
      # Navigation
      {
        mode = "n";
        key = "<leader>wh";
        action = "<C-w>h";
        options = {
          desc = "Focus Left";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>wj";
        action = "<C-w>j";
        options = {
          desc = "Focus Down";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>wk";
        action = "<C-w>k";
        options = {
          desc = "Focus Up";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>wl";
        action = "<C-w>l";
        options = {
          desc = "Focus Right";
          silent = true;
        };
      }
      # Move Window
      {
        mode = "n";
        key = "<leader>wH";
        action = "<C-w>H";
        options = {
          desc = "Move Left";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>wJ";
        action = "<C-w>J";
        options = {
          desc = "Move Down";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>wK";
        action = "<C-w>K";
        options = {
          desc = "Move Up";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>wL";
        action = "<C-w>L";
        options = {
          desc = "Move Right";
          silent = true;
        };
      }
      # Swap
      {
        mode = "n";
        key = "<leader>wx";
        action = "<C-w>x";
        options = {
          desc = "Swap Next";
          silent = true;
        };
      }

      # --- Tabs (t) ---
      {
        mode = "n";
        key = "<leader>tn";
        action = "<cmd>tabnew<CR>";
        options = {
          desc = "New Tab";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>tc";
        action = "<cmd>tabclose<CR>";
        options = {
          desc = "Close Tab";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>tl";
        action = "<cmd>tabnext<CR>";
        options = {
          desc = "Next Tab";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>th";
        action = "<cmd>tabprevious<CR>";
        options = {
          desc = "Prev Tab";
          silent = true;
        };
      }

      # --- Buffers (b) ---
      {
        mode = "n";
        key = "<leader>bn";
        action = "<cmd>bnext<CR>";
        options = {
          desc = "Next Buffer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>bp";
        action = "<cmd>bprevious<CR>";
        options = {
          desc = "Prev Buffer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>bdelete<CR>";
        options = {
          desc = "Delete Buffer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>bD";
        action = "<cmd>bdelete!<CR>";
        options = {
          desc = "Force Delete";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>bo";
        action = "<cmd>%bd|e#|bd#<CR>";
        options = {
          desc = "Close Other Buffers";
          silent = true;
        };
      }

      # --- Quit (q) ---
      {
        mode = "n";
        key = "<leader>qq";
        action = "<cmd>qa<CR>";
        options = {
          desc = "Quit All";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>qw";
        action = "<cmd>q<CR>";
        options = {
          desc = "Quit Window";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>qQ";
        action = "<cmd>qa!<CR>";
        options = {
          desc = "Force Quit All";
          silent = true;
        };
      }

      # --- System (s) Generic ---
      {
        mode = "n";
        key = "<leader>sc";
        action = "<cmd>checkhealth<CR>";
        options = {
          desc = "Check Health";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>so";
        action = "<cmd>options<CR>";
        options = {
          desc = "Vim Options";
          silent = true;
        };
      }

      # --- Local Leader (Run/Test) ---
      {
        mode = "n";
        key = "<localleader>r";
        action.__raw = ''
          function()
            local ft = vim.bo.filetype
            if ft == "python" then
              vim.cmd("term python3 " .. vim.fn.expand("%"))
            elseif ft == "go" then
              vim.cmd("term go run .")
            elseif ft == "sh" then
              vim.cmd("term bash " .. vim.fn.expand("%"))
            elseif ft == "nix" then
              vim.cmd("!nix-instantiate --eval %")
            else
              print("No run command defined for " .. ft)
            end
          end
        '';
        options = {
          desc = "Run File";
          silent = true;
        };
      }
    ];
  };
}
