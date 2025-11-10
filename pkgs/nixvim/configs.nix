{ pkgs, ... }: {
  programs.nixvim = {
    # colorschemes.catppuccin = {
    #   enable = true;
    #   settings = {
    #     flavour = "frappe";

    #     # Needed to keep terminal transparency, if any
    #     transparent_background = true;
    #   };
    # };
    clipboard.providers.wl-copy = {
      enable = true;
      package = pkgs.wl-clipboard;
    };
    globals = {
      mapleader = " ";
      maplocalleader = "\\";
      have_nerd_font = true;
      health = { style = "float"; };
      loaded_gzip = 1;
      loaded_tar = 1;
      loaded_tarPlugin = 1;
      loaded_zip = 1;
      loaded_zipPlugin = 1;
      loaded_getscript = 1;
      loaded_getscriptPlugin = 1;
      loaded_vimball = 1;
      loaded_vimballPlugin = 1;
      loaded_matchit = 1;
      loaded_2html_plugin = 1;
      loaded_rrhelper = 1;
      loaded_netrwPlugin = 1;
      loaded_matchparen = 1;
    };
    diagnostic.settings = {
      virtual_lines = {
        current_line = true;
      };
      float = {
        border = "rounded";
        title = "";
        header = "";
      };
      virtual_text = false; # This replaces the distracting virtual lines with more subtle indicators
      virtualText.enable = false; # Disable virtual lines
      signs = {
        enable = true;
        Error.text = "●";
        Warn.text = "●";
        Info.text = "●";
        Hint.text = "●";
      }; # Show icons in the sign column
      underline.enable = true; # Underline the code with the error
      # float = {}; # Show a floating window with details on hover
      virtualText.currentLine = true;
      severitySort = true;
    };

    extraPackages = with pkgs; [
      # language servers
      ruff
      # nodePackages.pyright
      lua-language-server

      # other dependencies
      gdb
      pkgs.python3Packages.jupytext
    ];

    # Force-set leader and colorscheme to debug loading issues
    # extraConfigVim = ''
    #   let mapleader = ' '
    #   let localmapleader = '\\'
    #   colorscheme catppuccin
    # '';
  };
}
