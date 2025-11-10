{ ... }: {
  programs.television = {
    enable = true;
    channels = {
      my-custom = {
        cable_channel = [
          {
            name = "ns";
            source_command = "nix-search-tv print";
            preview_command = "nix-search-tv preview {}";
          }
        ];
        alias = [
          {
            name = "aliases";
            description = "A channel to select from shell aliases";
            source_command = "alias";
            interactive = true;
            output = "{split:=:0}";
          }
        ];
        man_pages = [
          {
            name = "man-pages";
            description = "Browse and preview system manual pages";
            requirements = [ "apropos" "man" "col" ];
            source_command = "apropos .";
            preview_command = "man '{0}' | col -bx";
            keybindings_enter = "actions:open";
            preview.env.MANWIDTH = "80";
            actions.open.description = "Open the selected man page in the system pager";
            actions.open.command = "man '{0}'";
            actions.open.mode = "execute";
            ui.preview_panel.header = "{0}";
          }
        ];
      };
    };
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    settings = {
      ui = {
        use_nerd_font_icons = true;
        show_preview_panel = true;
        theme = "catppuccin";
        ui_scale = 75;
        orientation = "landscape";
        theme_overrides = {
          preview-fg = "#f5e0dc";
        };
      };
      keybindings = {
        quit = [ "esc" "ctrl-c" ];
      };
    };
  };
}
