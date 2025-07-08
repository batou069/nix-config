# {pkgs, ...}:
# {
#   programs.neovim = {
#     enable = true;
#     viAlias = true;
#     vimAlias = true;
#     defaultEditor = true;
#     plugins = with pkgs.vimPlugins;
#     [
#       yankring
#       vim-nix
#       {
#         plugin = vim-startify;
#         config = "let g:startify_change_to_vcs_root = 0";
#       }
#       nvim-cmp
#       nvim-lint
#       nvim-dbee
#       # nvim-navic
#       fzf-lua
#       fzf-lsp-nvim
#       telescope-manix
#       telescope-z-nvim
#       telescope-undo-nvim
#       telescope-nvim
#       nvim-snippy
#       nvim-notify
#       nvim-dap-ui
#       nvim-dap-view
#       nvim-spectre
#       nvim-origami
#       nvim-comment
#       nvim-tree-lua
#       nvim-surround
#       nvim-scissors
#       nvim-navbuddy
#       nvim-lsputils
#       nvim-docs-view
#       nvim-autopairs
#       nvim-treesitter
#       nvim-lsp-notify
#       nvim-dap-python
#       nvim-cursorline
#       nvim-web-devicons
#       nvim-various-textobjs
#       nvim-highlight-colors
#       nvim-dap-virtual-text
#       nvim-treesitter-pyfold
#       nvim-treesitter-context
#       nvim-whichkey-setup-lua
#       nvim-search-and-replace
#       nvim-treesitter-textobjects
#       nvim-treesitter-parsers.nix
#       nvim-treesitter-parsers.lua
#       nvim-treesitter-parsers.sql
#       nvim-treesitter-parsers.tsv
#       nvim-treesitter-parsers.vhs
#       nvim-treesitter-parsers.nu
#       nvim-treesitter-parsers.csv
#       nvim-treesitter-parsers.css
#       nvim-treesitter-textsubjects
#       nvim-treesitter-parsers.yaml
#       nvim-treesitter-parsers.tmux
#       nvim-treesitter-parsers.json
#       nvim-treesitter-parsers.http
#       nvim-treesitter-parsers.html
#       nvim-treesitter-parsers.fish
#       nvim-treesitter-parsers.diff
#       nvim-treesitter-parsers.bash
#       nvim-ts-context-commentstring
#       nvim-treesitter-parsers.regex
#       nvim-treesitter-parsers.vimdoc
#       nvim-treesitter-parsers.python
#       nvim-treesitter-parsers.graphql
#       nvim-treesitter-parsers.desktop
#       nvim-treesitter-parsers.markdown
#       nvim-treesitter-parsers.ssh_config
#       nvim-treesitter-parsers.dockerfile
#       nvim-treesitter-parsers.git_config
#       nvim-treesitter-parsers.markdown_inline
#       obsidian-nvim
#       telescope-live-grep-args-nvim
#       telescope-lsp-handlers-nvim
#       telescope-dap-nvim
#       neorg
#       lazygit-nvim
#       lazydev-nvim
#       lazy-lsp-nvim
#       LazyVim
#       orgmode
#       zoxide-vim
#       zen-mode-nvim
#       yanky-nvim
#       wtf-nvim
#       avante-nvim
#       vim-trailing-whitespace
#     ];
#   };
# }
{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [
      # Plugin Manager
      lazy-nvim
      # Base Distro
      LazyVim
      statix
      # Coding
      mini-pairs
      ts-comments-nvim
      mini-ai
      lazydev-nvim

      # Blink
      blink-cmp
      friendly-snippets

      # Editor
      undotree
      neo-tree-nvim
      grug-far-nvim
      flash-nvim
      which-key-nvim
      gitsigns-nvim
      trouble-nvim
      todo-comments-nvim

      # Fzf
      fzf-lua

      # Formatting
      conform-nvim

      # Linting
      nvim-lint

      # LSP
      nvim-lspconfig

      # TreeSitter
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects
      nvim-ts-autotag
      (nvim-treesitter.withPlugins (
               p: with p; [
                 bash
                 comment
                 dockerfile
                 html
                 javascript
                 json
                 lua
                 python
                 regex
                 rust
                 sql
                 toml
                 vim
                 vimdoc
                 yaml
                 markdown
                 markdown_inline
                 nix
               ]
             ))

      # UI
      bufferline-nvim
      lualine-nvim
      noice-nvim
      mini-icons
      nui-nvim

      # Util
      snacks-nvim
      persistence-nvim
      plenary-nvim

      # Mini-comment Extra
      mini-comment
      nvim-ts-context-commentstring

      # Mini-surround Extra
      mini-surround

      # DAP Core Extra
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text
      nvim-nio

      # DAP Neovim Lua Adapter Extra
      # one-small-step-for-vimkind

      # Aerial Extra
      aerial-nvim

      # Illuminate Extra
      vim-illuminate

      # Inc-rename Extra
      inc-rename-nvim

      # Leap Extra
      flit-nvim
      leap-nvim
      vim-repeat

      # Mini-diff Extra
      mini-diff

      # Navic Extra
      nvim-navic

      # Overseer Extra
      overseer-nvim

      # Clangd Extra
      clangd_extensions-nvim

      # Helm Extra
      vim-helm

      # JSON/YAML Extra
      SchemaStore-nvim # load known formats for json and yaml

      # Markdown Extra
      markdown-preview-nvim
      render-markdown-nvim

      # Python Extra
      neotest-python
      nvim-dap-python

      # Rust Extra
      crates-nvim
      rustaceanvim

      # Terraform Extra
      # telescope-terraform-doc-nvim
      # telescope-terraform-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-ui-select-nvim

      # LSP Extra
      neoconf-nvim
      none-ls-nvim

      # Test Extra
      neotest

      # Edgy Extra
      edgy-nvim

      # Mini-animate Extra
      mini-animate

      # Treesitter-context Extra
      nvim-treesitter-context

      # Project Extra
      project-nvim

      # Startuptime
      vim-startuptime

      nvim-web-devicons
      nvim-notify
      nvim-lsp-notify

      # smart typing
      guess-indent-nvim

      # LSP
      nvim-lightbulb # lightbulb for quick actions
      nvim-code-action-menu # code action menu
      lspkind-nvim
    ];

    extraPackages = with pkgs; [
      gcc # needed for nvim-treesitter

      # HTML, CSS, JSON
      vscode-langservers-extracted

      # LazyVim defaults
      stylua
      shfmt

      # Markdown extra
      markdownlint-cli2
      marksman

      # JSON and YAML extras
      nodePackages.yaml-language-server

      # Custom
      editorconfig-checker
      shellcheck

      pyright
      nil
      lua-language-server
      zls
      bash-language-server
      yaml-language-server
      vscode-langservers-extracted # eslint, json
      nodePackages_latest.dockerfile-language-server-nodejs

      ripgrep
      alejandra
    ];

    extraLuaConfig = ''
            vim.g.mapleader = " "
            vim.g.maplocalleader = "\\"
            require("lazy").setup({
        spec = {
          -- add LazyVim and import its plugins
          { "LazyVim/LazyVim", import = "lazyvim.plugins" },
          -- import/override with your plugins
          { import = "plugins" },
        },
        defaults = {
          -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
          -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
          lazy = false,
          -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
          -- have outdated releases, which may break your Neovim install.
          version = false, -- always use the latest git commit
          -- version = "*", -- try installing the latest stable version for plugins that support semver
        },
        install = { colorscheme = { "catppuccin" } },
        checker = {
          enabled = true, -- check for plugin updates periodically
          notify = false, -- notify on update
        }, -- automatically check for plugin updates
        performance = {
          rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
              "gzip",
              -- "matchit",
              -- "matchparen",
              -- "netrwPlugin",
              "tarPlugin",
              "tohtml",
              "tutor",
              "zipPlugin",
            },
          },
        },
      })
            --[[
            require("lazy").setup({
              spec = {
                { "LazyVim/LazyVim", import = "lazyvim.plugins" },
                -- import any extras modules here
                { import = "lazyvim.plugins.extras.coding.mini-comment" },
                { import = "lazyvim.plugins.extras.coding.mini-surround" },
                { import = "lazyvim.plugins.extras.dap.core" },
                { import = "lazyvim.plugins.extras.dap.nlua" },
                -- We need to use Edgy before Aerial
                { import = "lazyvim.plugins.extras.ui.edgy" },
                { import = "lazyvim.plugins.extras.editor.aerial" },
                { import = "lazyvim.plugins.extras.editor.illuminate" },
                { import = "lazyvim.plugins.extras.editor.inc-rename" },
                { import = "lazyvim.plugins.extras.editor.leap" },
                { import = "lazyvim.plugins.extras.editor.mini-diff" },
                { import = "lazyvim.plugins.extras.editor.navic" },
                { import = "lazyvim.plugins.extras.editor.overseer" },
                { import = "lazyvim.plugins.extras.lang.clangd" },
                { import = "lazyvim.plugins.extras.lang.docker" },
                { import = "lazyvim.plugins.extras.lang.helm" },
                { import = "lazyvim.plugins.extras.lang.json" },
                { import = "lazyvim.plugins.extras.lang.markdown" },
                { import = "lazyvim.plugins.extras.lang.nushell" },
                { import = "lazyvim.plugins.extras.lang.python" },
                { import = "lazyvim.plugins.extras.lang.rust" },
                { import = "lazyvim.plugins.extras.lang.terraform" },
                { import = "lazyvim.plugins.extras.lang.yaml" },
                { import = "lazyvim.plugins.extras.lsp.neoconf" },
                { import = "lazyvim.plugins.extras.lsp.none-ls" },
                { import = "lazyvim.plugins.extras.test.core" },
                { import = "lazyvim.plugins.extras.ui.mini-animate" },
                { import = "lazyvim.plugins.extras.ui.treesitter-context" },
                { import = "lazyvim.plugins.extras.util.project" },
                { import = "lazyvim.plugins.extras.util.startuptime" },
                -- import/override with your plugins
                { import = "plugins" },
              },
              defaults = {
                -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
                -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
                lazy = false,
                -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
                -- have outdated releases, which may break your Neovim install.
                version = false, -- always use the latest git commit
                -- version = "*", -- try installing the latest stable version for plugins that support semver
              },
              performance = {
                -- Used for NixOS
                reset_packpath = false,
                rtp = {
                  reset = false,
                  -- disable some rtp plugins
                  disabled_plugins = {
                    "gzip",
                    -- "matchit",
                    -- "matchparen",
                    -- "netrwPlugin",
                    "tarPlugin",
                    "tohtml",
                    "tutor",
                    "zipPlugin",
                  },
                }
              },
              dev = {
                path = "/etc/profiles/per-user/lf/etc/xdg/nvim/pack/myNeovimPackages/start",
                patterns = {""},
              },
              install = {
                missing = false,
              },
            })
            --]]
    '';
  };

  xdg.configFile."nvim/lua" = {
    recursive = true;
    source = ./lua; # Or the path to your lua config
  };
}
