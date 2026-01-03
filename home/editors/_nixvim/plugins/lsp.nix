{ pkgs, ... }: {
  programs.nixvim = {
    plugins = {
      lsp-format.enable = true;
      lsp-status.enable = false;
      lspsaga = {
        enable = true;
        settings = {
          ui = {
            border = "single";
            devicon = true;
          };
          lightbulb = {
            enable = true;
            sign = true;
            virtual_text = true;
          };
          outline = {
            layout = "float";
          };
        };
      };

      # Sources for null-ls
      none-ls = {
        enable = true;
        enableLspFormat = true;
        sources = {
          formatting = {
            prettierd.enable = true;
            stylua.enable = true;
            nixfmt.enable = true;
            black.enable = true;
            isort.enable = true;
            shfmt.enable = true;
          };
          diagnostics = {
            yamllint.enable = true;
            mypy.enable = true;
            deadnix.enable = true;
            statix.enable = true;
          };
        };
      };

      lsp-signature.enable = true;

      lsp = {
        enable = true;
        inlayHints = true;
        keymaps.silent = true;
        # We define keymaps manually below for full control

        servers = {
          nixd.enable = true;
          gopls.enable = true;
          clangd.enable = true;
          bashls.enable = true;
          jsonls.enable = true;
          ruff.enable = true;
          yamlls.enable = true;
          basedpyright.enable = true;
        };
      };
    };

    # Unified Code Keymaps (c)
    keymaps = [
      # Core Actions
      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>Lspsaga code_action<CR>";
        options = {
          desc = "Code Action";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>cr";
        action = "<cmd>Lspsaga rename<CR>";
        options = {
          desc = "Rename";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>cf";
        action = "<cmd>lua vim.lsp.buf.format()<CR>";
        options = {
          desc = "Format";
          silent = true;
        };
      }

      # Peek / Outline
      {
        mode = "n";
        key = "<leader>cp";
        action = "<cmd>Lspsaga peek_definition<CR>";
        options = {
          desc = "Peek Definition";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>co";
        action = "<cmd>Lspsaga outline<CR>";
        options = {
          desc = "Outline";
          silent = true;
        };
      }

      # Diagnostics
      {
        mode = "n";
        key = "<leader>cd";
        action = "<cmd>Lspsaga show_line_diagnostics<CR>";
        options = {
          desc = "Line Diagnostics";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>cD";
        action = "<cmd>Telescope diagnostics<CR>";
        options = {
          desc = "Workspace Diagnostics";
          silent = true;
        };
      }

      # Calls / Navigation
      {
        mode = "n";
        key = "<leader>ci";
        action = "<cmd>Telescope lsp_incoming_calls<CR>";
        options = {
          desc = "Incoming Calls";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>cO";
        action = "<cmd>Telescope lsp_outgoing_calls<CR>";
        options = {
          desc = "Outgoing Calls";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>cs";
        action = "<cmd>Telescope lsp_document_symbols<CR>";
        options = {
          desc = "Document Symbols";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>cS";
        action = "<cmd>Telescope lsp_workspace_symbols<CR>";
        options = {
          desc = "Workspace Symbols";
          silent = true;
        };
      }

      # Direct Goto (No leader)
      {
        mode = "n";
        key = "gd";
        action = "<cmd>Telescope lsp_definitions<CR>";
        options = {
          desc = "Goto Definition";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>Telescope lsp_references<CR>";
        options = {
          desc = "Goto References";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "gI";
        action = "<cmd>Telescope lsp_implementations<CR>";
        options = {
          desc = "Goto Implementation";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "gt";
        action = "<cmd>Telescope lsp_type_definitions<CR>";
        options = {
          desc = "Goto Type Def";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "K";
        action = "<cmd>Lspsaga hover_doc<CR>";
        options = {
          desc = "Hover";
          silent = true;
        };
      }

      # Diagnostic Jumps
      {
        mode = "n";
        key = "[d";
        action = "<cmd>Lspsaga diagnostic_jump_prev<CR>";
        options = {
          desc = "Prev Diagnostic";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "]d";
        action = "<cmd>Lspsaga diagnostic_jump_next<CR>";
        options = {
          desc = "Next Diagnostic";
          silent = true;
        };
      }
    ];
  };
  home.packages = with pkgs; [
    shellcheck
    shellharden
    shfmt
    nodePackages.bash-language-server
  ];
}
