{
  pkgs,
  config,
  ...
}: {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    vimdiffAlias = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    withNodeJs = true;
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [
      # yankring
      # vim-nix
      # {
      # plugin = vim-startify;
      # config = "let g:startify_change_to_vcs_root = 0";
      # }
      # nvim-cmp
      # nvim-lint
      # nvim-dbee
      # # nvim-navic
      # fzf-lua
      # fzf-lsp-nvim
      # telescope-manix
      # telescope-z-nvim
      # telescope-undo-nvim
      # telescope-nvim
      # nvim-snippy
      # nvim-notify
      # nvim-dap-ui
      # nvim-dap-view
      # nvim-spectre
      # nvim-origami
      # nvim-comment
      # nvim-tree-lua
      # nvim-surround
      # nvim-scissors
      # nvim-navbuddy
      # nvim-lsputils
      # nvim-docs-view
      # nvim-autopairs
      # nvim-treesitter
      # nvim-lsp-notify
      # nvim-dap-python
      # nvim-cursorline
      # nvim-web-devicons
      # nvim-various-textobjs
      # nvim-highlight-colors
      # nvim-dap-virtual-text
      # nvim-treesitter-pyfold
      # nvim-treesitter-context
      # nvim-whichkey-setup-lua
      # nvim-search-and-replace
      # nvim-treesitter-textobjects
      # nvim-treesitter-parsers.nix
      # nvim-treesitter-parsers.lua
      # nvim-treesitter-parsers.sql
      # nvim-treesitter-parsers.tsv
      # nvim-treesitter-parsers.vhs
      # nvim-treesitter-parsers.nu
      # nvim-treesitter-parsers.csv
      # nvim-treesitter-parsers.css
      # nvim-treesitter-textsubjects
      # nvim-treesitter-parsers.yaml
      # nvim-treesitter-parsers.tmux
      # nvim-treesitter-parsers.json
      # nvim-treesitter-parsers.http
      # nvim-treesitter-parsers.html
      # nvim-treesitter-parsers.fish
      # nvim-treesitter-parsers.diff
      # nvim-treesitter-parsers.bash
      # nvim-ts-context-commentstring
      # nvim-treesitter-parsers.regex
      # nvim-treesitter-parsers.vimdoc
      # nvim-treesitter-parsers.python
      # nvim-treesitter-parsers.graphql
      # nvim-treesitter-parsers.desktop
      # nvim-treesitter-parsers.markdown
      # nvim-treesitter-parsers.ssh_config
      # nvim-treesitter-parsers.dockerfile
      # nvim-treesitter-parsers.git_config
      # nvim-treesitter-parsers.markdown_inline
      # obsidian-nvim
      # telescope-live-grep-args-nvim
      # telescope-lsp-handlers-nvim
      # telescope-dap-nvim
      # neorg
      # lazygit-nvim
      # lazydev-nvim
      # lazy-lsp-nvim
      # LazyVim
      # orgmode
      # zoxide-vim
      # zen-mode-nvim
      # yanky-nvim
      # wtf-nvim
      # avante-nvim
      # vim-trailing-whitespace
      lazy-nvim
    ];

    extraLuaConfig = ''
      vim.g.mapleader = " " -- Need to set leader before lazy for correct keybindings
      require("lazy").setup({
        performance = {
          reset_packpath = false,
          rtp = {
              reset = false,
            }
          },
        dev = {
          path = "${pkgs.vimUtils.packDir config.home-manager.users.USERNAME.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
        },
        spec = {
          { import = "plugins" }
        },
        install = {
          -- Safeguard in case we forget to install a plugin with Nix
          missing = false,
        },
      })
    '';
  };
}
