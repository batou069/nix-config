{ pkgs, ... }: {
  programs.lsd = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    package = pkgs.lsd;
    settings = {
      date = "relative"; # Show relative dates
      icons = {
        when = "auto"; # Auto-detect icon support
        theme = "fancy"; # Use fancy icons
      };
      sorting = {
        column = "extension";
        dir-grouping = "first";
      };
      hyperlink = "auto";
      symlink-arrow = ""; # Other nice arrows: 󰑃      ⇒    󰁚 󰁗 
      header = true;
    };
    icons = {
      name = {
        ".trash" = "";
        "nix" = "";
        "Video" = "󰨜"; # 
        "Camera" = "";
        "secrets" = "󰢬";
        "git" = "";
        "game" = "";
        "hypr" = "";
        "modules" = "󰕳";
        "shells" = "";
        "nvim" = "";
        "nixvim" = "";
        "vim" = "";
        "ghostty*" = "";
        "kitty" = "";
        "pyproject" = "";
      };
      extension = {
        yaml = "";
        md = "󱇗";
        toml = "";
        mpeg = ""; # "   󰈫 󰍫  ";
        avi = "";
        mkv = "";
        mov = "";
        mp4 = "";
        ipynb = "";
        bak = "";
        csv = "";
        pdf = "";
      };
      filetype = {
        dir = "";
        file = "";
        pipe = "";
      };
    };
  };
}
