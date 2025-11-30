{ ... }: {
  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableZshIntegration = true;
      enableFishIntegration = true;
    };
    enableGitIntegration = true;
    settings = {
      cursor_shape = "underline"; # block, beam, underline
      # cursor_blink = true;
      cursor_beam_thickness = 1.5;
      cursor_underline_thickness = 3.0;
      cursor_shape_unfocused = "hollow";
      underline_hyperlinks = "always";
      copy_on_select = "clipboard";
      clear_selection_on_clipboard_loss = "yes";
      strip_trailing_spaces = "smart";
      enable_audio_bell = "yes";
      hide_window_decorations = "yes";
      tab_bar_style = "separator"; # fade, slant, separator, powerline, hidden
      tab_powerline_style = "slanted"; # angled, slanted, round.
      tab_fade = "0.25 0.5 0.75 1";
      tab_activity_symbol = "";
      font_size = 17.0;
      dynamic_background_opacity = "yes";
      # window_padding_width = 0;
      # window_padding_height = 0;
      background_blur = 10;
      # background_opacity = 1;
      # set_background_opacity = 1;
      placement_strategy = "top";
      cursor_trail = 10;
      cursor_trail_start_threshold = 0;
      cursor_trail_decay = "0.01 0.05";
      disable_ligatures = "never";
      # background_image = "/home/lf/Pictures/wallpapers/Minimal_Squares.png";
      # background_image_layout = "centered";
    };
    quickAccessTerminalConfig = {
      start_as_hidden = false;
      hide_on_focus_loss = false;
      background_opacity = 0.85;
    };
    keybindings = {
      ## Kitty stuff
      "ctrl+shift+f1" = "show_kitty_doc overview";

      # Opacity
      "ctrl+shift+a>m" = "set_background_opacity +0.1";
      "ctrl+shift+a>l" = "set_background_opacity -0.1";

      # Resizing panes
      "ctrl+alt+left" = "resize_window narrower";
      "ctrl+alt+right" = "resize_window wider";
      "ctrl+alt+up" = "resize_window taller";
      "ctrl+alt+down" = "resize_window shorter 3";
      "ctrl+alt+r" = "resize_window reset";

      # Moving panes
      "ctrl+left" = "neighboring_window left";
      "shift+left" = "move_window right";
      "ctrl+down" = "neighboring_window down";
      "shift+down" = "move_window up";

      # Creating panes
      "ctrl+alt+v" = "launch --location=vsplit";
      "ctrl+alt+h" = "launch --location=hsplit";

      # Markers
      "f1" = "toggle_marker regex 1 \\bERROR\\b";
      "f2" = "create_marker";
      "f3" = "remove_marker";
      "ctrl+p" = "scroll_to_mark prev";
      "ctrl+n" = "scroll_to_mark next";
    };
  };
}
