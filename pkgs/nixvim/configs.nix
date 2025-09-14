{
  pkgs,
  lib,
  inputs,
  ...
}: {
  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "frappe";

        # Needed to keep terminal transparency, if any
        transparent_background = true;
      };
    };
    clipboard.providers.wl-copy = {
      enable = true;
      package = pkgs.wl-clipboard;
    };
    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };
    diagnostic.settings = {
      virtual_lines = {
        current_line = true;
      };
      virtual_text = false; # This replaces the distracting virtual lines with more subtle indicators
      virtualText.enable = false; # Disable virtual lines
      signs.enable = true; # Show icons in the sign column
      underline.enable = true; # Underline the code with the error
      float = {}; # Show a floating window with details on hover
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
    extraConfigVim = ''
      let mapleader = ' '
      colorscheme catppuccin
    '';
  };
}
