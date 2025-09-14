{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.nixvim = {
    opts = {
      autoindent = true;
      autochdir = true;
      backspace = "indent,eol,start"; # allow backspace on
      breakindent = true;
      backup = false;
      relativenumber = true;
      completeopt = "menu,menuone,noselect,noinsert";
      colorcolumn = "100";
      cmdheight = 1; # more space in the neovim command line for displaying messages
      clipboard = "unnamedplus";
      confirm = true;
      cursorline = true;
      cursorcolumn = false;
      copyindent = true;
      conceallevel = 0; # so that `` is visible in markdown files
      expandtab = true;
      fileencoding = "utf-8"; # the encoding written to a file
      foldmethod = "marker";
      hidden = true;
      history = 1000;
      hlsearch = true;
      inccommand = "split";
      ignorecase = true;
      linebreak = true;
      laststatus = 3;

      mouse = "a";
      number = true;
      numberwidth = 4; # -- set number column width to 2 {default 4}
      list = true;
      listchars = {
        tab = "▸ ";
        trail = "·";
        eol = "↵";
        space = "·";
        nbsp = "␣";
        extends = "⟩";
        precedes = "⟦";
      };
      pumheight = 10; #  pop up menu height
      preserveindent = true;
      sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions";
      showtabline = 2; # 1: Show tabs from 2+ open ones, 2: always show tabs
      showmode = false;
      scrolloff = 999;
      showmatch = true;
      sidescrolloff = 8; # minimal number of screen columns either side of cursor if wrap is `false`
      splitbelow = true;
      splitright = true;
      swapfile = false;
      smartindent = true;
      smartcase = true;
      shiftwidth = 4;
      synmaxcol = 240;
      termguicolors = true;
      tabstop = 4;
      timeoutlen = 300;
      updatetime = 250;
      undofile = true; # Build-in persistent undo
      virtualedit = "block";
      writebackup = false;
    };
  };
}
