{ ... }: {
  programs.nixvim = {
    plugins = {
      tmux-navigator.enable = true;
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
      kitty-navigator.enable = true;
      alpha = {
        enable = false;
        settings.layout = [
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
        ];
      };
    };

    keymaps = [
      # UI Toggles
      {
        mode = "n";
        key = "<leader>uz";
        action = "<cmd>ZenMode<CR>";
        options = {
          desc = "Toggle Zen Mode";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ut";
        action = "<cmd>Twilight<CR>";
        options = {
          desc = "Toggle Twilight";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>un";
        action = "<cmd>Noice history<CR>";
        options = {
          desc = "Notification History";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ud";
        action = "<cmd>Noice dismiss<CR>";
        options = {
          desc = "Dismiss Notifications";
          silent = true;
        };
      }
    ];
  };
}
