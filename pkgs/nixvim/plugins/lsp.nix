{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    plugins = {
      lsp-status.enable = true;
      lspsaga = {
        enable = true;
        settings = {
          implement = {enable = true;};
          lightbulb = {enable = true;};
          symbol_in_winbar = {enable = true;};
          ui = {border = "single";};
          rename = {enable = true;};
          outline = {enable = true;};
          hover = {enable = true;};
          finder = {enable = true;};
          diagnostic = {enable = true;};
          code_action = {enable = true;};
        };
      };
      none-ls = {
        enable = true;
        enableLspFormatting = false;
        settings = {
          sources = [
            "null_ls.builtins.formatting.prettierd"
            "null_ls.builtins.formatting.stylua"
            "null_ls.builtins.formatting.alejandra"
            "null_ls.builtins.formatting.ruff"
            "null_ls.builtins.diagnostics.ruff"
            "null_ls.builtins.code_actions.gitsigns"
          ];
        };
      };
      lspkind.enable = true;

      lsp-signature.enable = true;

      lsp = {
        enable = true;
        # inlayHints = true;

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

        keymaps.extra = [
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

        servers = {
          nixd.enable = true;
          nil_ls = {
            enable = true;
            settings.nil.diagnostics.autoArchive = true;
          };
          gopls.enable = true;
          clangd.enable = true;
          bashls.enable = true;
          jsonls.enable = true;
          ts_ls.enable = true;
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
  };
}
