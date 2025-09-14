{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    plugins = {
      zen-mode.enable = true;
      twilight.enable = true;
      dressing.enable = true;
      dashboard.enable = true;
      web-devicons = {
        enable = true;
        settings = {
          color_icons = true;
          default = true;
        };
      };
      # kitty-navigator.enable = true;
      # kitty-scrollback.enable = true;
      alpha = {
        enable = false;
        layout = [
          {
            type = "padding";
            val = 2;
          }
          {
            opts = {
              hl = "Type";
              position = "center";
            };
            type = "text";
            val = [
              "                                                     "
              "  ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓ "
              "  ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒ "
              " ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░ "
              " ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██  "
              " ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒ "
              " ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░ "
              " ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░ "
              "    ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░    "
              "          ░    ░  ░    ░ ░        ░   ░         ░    "
              "                                 ░                   "
              "                                                     "
              "                █████╗  ██╗ ██████████████╗          "
              "               ██╔══██╗ ╚═╝ ╚═██╔═██╔═██╔═╝          "
              "              ██╔╝  ██║ ██╗   ██║ ██║ ██║            "
              "              ████████║ ██║   ██║ ██║ ██║            "
              "              ██╔═══██║ ██║ ██████████████╗          "
              "              ╚═╝   ╚═╝ ╚═╝ ╚═════════════╝          "
            ];
          }
          {
            type = "padding";
            val = 2;
          }
          {
            type = "group";
            val = [
              {
                on_press = {
                  __raw = "function() vim.cmd[[ene]] end";
                };
                opts = {
                  shortcut = "n";
                };
                type = "button";
                val = "  New file";
              }
              {
                on_press = {
                  __raw = "function() vim.cmd[[qa]] end";
                };
                opts = {
                  shortcut = "q";
                };
                type = "button";
                val = " Quit Neovim";
              }
            ];
          }
          {
            type = "padding";
            val = 2;
          }
          {
            opts = {
              hl = "Keyword";
              position = "center";
            };
            type = "text";
            val = "Inspiring quote here.";
          }
        ];
      };
    };
  };
}
