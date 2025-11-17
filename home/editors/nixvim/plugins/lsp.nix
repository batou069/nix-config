{ pkgs, ... }: {
  programs.nixvim = {
    plugins = {
      lsp-format = {
        enable = true;
        settings = {
          yaml = {
            tab_width = 2;
          };
          python = {
            tab_width = 4;
          };
          nix = {
            tab_width = 2;
          };
          conf = {
            tab_width = 2;
          };
        };
      };
      lsp-status.enable = true;
      lspsaga = {
        enable = true;
        settings = {
          scroll_preview = {
            scroll_down = "<C-f>";
            scroll_up = "<C-b>";
          };
          beacon = { enable = true; };
          implement = { enable = true; };
          lightbulb = {
            enable = false;
            sign = false;
            virtual_text = false;
          };
          symbol_in_winbar = {
            enable = true;
            showFile = false;
            folderLevel = 0;
          };
          ui = {
            border = "single";
            devicon = true;
          };
          rename = {
            auto_save = false;
            keys = {
              exec = "<CR>";
              quit = [ "<C-k>" "<Esc>" ];
              select = "x";
            };
          };
          outline = {
            auto_close = true;
            auto_preview = true;
            close_after_jump = true;
            layout = "normal"; # normal or float
            win_position = "right"; # left or right
            keys = {
              jump = "e";
              quit = "q";
              toggle_or_jump = "o";
            };
          };
          # hover = {enable = true;};
          hover = { openLink = "gx"; };
          finder = { enable = true; };
          diagnostic = {
            border_follow = true;
            diagnostic_only_current = false;
            show_code_action = true;
            extend_related_information = true;
          };
          code_action = {
            extendGitSigns = false;
            showServerName = false;
            onlyInCursor = true;
            numShortcut = true;
            keys = {
              exec = "<CR>";
              quit = [ "<Esc>" "q" ];
            };
          };
        };
      };
      none-ls = {
        enable = true;
        enableLspFormat = true;
        sources = {
          formatting = {
            prettierd.enable = true;
            stylua.enable = true;
            alejandra.enable = true;
            sqruff.enable = true;
            isort.enable = true;
            black.enable = true;
            sqlfluff.enable = true;
            shellharden.enable = true;
            shfmt.enable = true;
            nixfmt.enable = true;
            nixpkgs_fmt.enable = true;
            nix_flake_fmt.enable = true;
            markdownlint.enable = true;
          };
          diagnostics = {
            yamllint.enable = true;
            sqruff.enable = true;
            zsh.enable = true;
            trail_space.enable = true;
            todo_comments.enable = true;
            mypy.enable = true;
            markdownlint.enable = true;
            vint.enable = true;
            statix.enable = true;
            gitlint.enable = true;
            fish.enable = true;
            editorconfig_checker.enable = true;
            deadnix.enable = true;
            # shellcheck.enable = true; # Added
            hadolint.enable = true; # Added
          };
          code_actions = {
            gitsigns.enable = true;
            gitrebase.enable = true;
            refactoring.enable = true;
            statix.enable = true;
            # textlint.enable = true;
          };
          hover.printenv.enable = true;
        };
      };
      lspkind = {
        enable = true;
        cmp.enable = false;
      };

      lsp-signature.enable = true;

      lsp = {
        enable = true;
        inlayHints = false;
        luaConfig.post =
          # lua
          ''
            vim.diagnostic.config({virtual_lines = true})
          '';

        # Set the position encoding capability globally for the LSP client
        capabilities = ''
          ;(function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.general.positionEncodings = { "utf-8" }
            return capabilities
          end)()
        '';

        # Disable the default formatting keymap that causes errors

        onAttach = ''
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = 0, desc = "LSP: " .. desc })
          end

          -- The following mappings are only set if the language server supports them
          if client.server_capabilities.hoverProvider then
            map("K", vim.lsp.buf.hover, "Hover Documentation")
          end
          if client.server_capabilities.referencesProvider then
            map("gD", vim.lsp.buf.references, "Go to References")
          end
          if client.server_capabilities.definitionProvider then
            map("gd", vim.lsp.buf.definition, "Go to Definition")
          end
          if client.server_capabilities.implementationProvider then
            map("gi", vim.lsp.buf.implementation, "Go to Implementation")
          end
          if client.server_capabilities.typeDefinitionProvider then
            map("gt", vim.lsp.buf.type_definition, "Go to Type Definition")
          end
        '';

        keymaps = {
          silent = true;
          lspBuf = {
            gd = {
              action = "definition";
              desc = "Goto Definition";
            };
            gr = {
              action = "references";
              desc = "Goto References";
            };
            gD = {
              action = "declaration";
              desc = "Goto Declaration";
            };
            gI = {
              action = "implementation";
              desc = "Goto Implementation";
            };
            #gT = {
            #	action = "type_definition";
            #	desc = "Type Definition";
            #};
            K = {
              action = "hover";
              desc = "Hover";
            };
            "<leader>cw" = {
              action = "workspace_symbol";
              desc = "Workspace Symbol";
            };
            #"<leader>cr" = {
            #	action = "rename";
            #	desc = "Rename";
            #};
          };
          extra = [
            {
              key = "<leader>k";
              action = "<cmd>lua vim.diagnostic.jump({ count = -1, float = true })<cr>";
            }
            {
              key = "<leader>j";
              action = "<cmd>lua vim.diagnostic.jump({ count = 1, float = true })<cr>";
            }
            {
              key = "<leader>lx";
              action = "<CMD>LspStop<CR>";
            }
            {
              key = "<leader>ls";
              action = "<CMD>LspStart<CR>";
            }
            {
              key = "<leader>lr";
              action = "<CMD>LspRestart<CR>";
            }
            {
              key = "gd";
              action = "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>";
            }
            {
              key = "K";
              action = "<CMD>Lspsaga hover_doc<CR>";
            }
          ];
        };

        servers = {
          # nixd.enable = true;
          nil_ls = {
            enable = true;
            settings.nil.diagnostics.autoArchive = true;
          };
          gopls.enable = true;
          clangd.enable = true;
          bashls.enable = true;
          jsonls.enable = true;
          # ts_ls.enable = true;
          dockerls = {
            enable = true;
            package = pkgs.nodePackages.dockerfile-language-server-nodejs;
          };
          ruff = {
            enable = true;
            package = pkgs.ruff;
          };
          hyprls = {
            enable = true;
            package = pkgs.hyprls;
          };
          yamlls = {
            enable = true;
            settings.yaml.keyOrdering = false;
          };
          basedpyright = {
            enable = true;
            settings.basedpyright.analysis = {
              autoSearchPaths = true;
              diagnosticMode = "openFilesOnly";
              useLibraryCodeForTypes = true;
            };
          };
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "cp";
        action = "<cmd>Lspsaga peek_definition<CR>";
        options = {
          desc = "Peek Definition";
          silent = true;
        };
      }

      {
        mode = "n";
        key = "gT";
        action = "<cmd>Lspsaga peek_type_definition<CR>";
        options = {
          desc = "Type Definition";
          silent = true;
        };
      }

      #{
      #	mode = "n"; key = "K"; action = "<cmd>Lspsaga hover_doc<CR>";
      #	options = { desc = "Hover"; silent = true; };
      #}

      {
        mode = "n";
        key = "<leader>cw";
        action = "<cmd>Lspsaga outline<CR>";
        options = {
          desc = "Outline";
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
        key = "<leader>ca";
        action = "<cmd>Lspsaga code_action<CR>";
        options = {
          desc = "Code Action";
          silent = true;
        };
      }

      {
        mode = "n";
        key = "<leader>cd";
        action = "<cmd>Lspsaga show_line_diagnostics<CR>";
        options = {
          desc = "Line Diagnostics";
          silent = true;
        };
      }

      #{
      #	mode = "n"; key = "[d"; action = "<cmd>Lspsaga diagnostic_jump_next<CR>";
      #	options = { desc = "Next Diagnostic"; silent = true; };
      #}

      #{
      #	mode = "n"; key = "]d"; action = "<cmd>Lspsaga diagnostic_jump_prev<CR>";
      #	options = { desc = "Previous Diagnostic"; silent = true; };
      #}
    ];
    # diagnostic = {
    #       "<leader>cd" = {
    #         action = "open_float";
    #         desc = "Line Diagnostics";
    #       };
    #       "[d" = {
    #         action = "goto_next";
    #         desc = "Next Diagnostic";
    #       };
    #       "]d" = {
    #         action = "goto_prev";
    #         desc = "Previous Diagnostic";
    #       };
    #     };
  };
}
