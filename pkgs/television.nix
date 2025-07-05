{...}: {
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
      };
    };
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    settings = {
      ui = {
        use_nerd_font_icons = true;
        show_preview_panel = true;
      };
      keybindings = {
        quit = ["esc" "ctrl-c"];
      };
    };
  };
}
