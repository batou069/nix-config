{ ... }: {
  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" ];

    userKeymaps = [
      {
        context = "VimControl && !menu";
        bindings = {
          "space c a" = "editor::ToggleCodeActions";
          "space f f" = "file_finder::Toggle";
          "space f s" = "workspace::Save";
          "space f p" = "zed::OpenSettings";
          "space o p" = "project_panel::ToggleFocus";
          "space o t" = "terminal_panel::ToggleFocus";
          "space q q" = "zed::Quit";
          "space w 1" = [ "workspace::ActivatePane" 0 ];
          "space w 2" = [ "workspace::ActivatePane" 1 ];
          "space w 3" = [ "workspace::ActivatePane" 2 ];
          "space w 4" = [ "workspace::ActivatePane" 3 ];
          "space w 5" = [ "workspace::ActivatePane" 4 ];
          "space w 6" = [ "workspace::ActivatePane" 5 ];
          "space w 7" = [ "workspace::ActivatePane" 6 ];
          "space w 8" = [ "workspace::ActivatePane" 7 ];
          "space w 9" = [ "workspace::ActivatePane" 8 ];
          "space w c" = "pane::CloseActiveItem";
          "space w d" = "pane::CloseActiveItem";
          "space w h" = "workspace::ActivatePaneLeft";
          "space w j" = "workspace::ActivatePaneDown";
          "space w l" = "workspace::ActivatePaneRight";
          "space w k" = "workspace::ActivatePaneUp";
          "space w s" = "pane::SplitHorizontal";
          "space w v" = "pane::SplitVertical";
        };
      }
    ];

    mutableUserKeymaps = true;
    userSettings = {
      auto_update = false;
      autosave = "on_focus_change";
      always_treat_brackets_as_autoclosed = true;
      disable_ai = true;
      features = { copilot = false; };
      telemetry = { metrics = false; };
      vim_mode = false;
      # ui_font_size = 16;
      # buffer_font_size = 16;

      show_diagnostics = "all";

      minimap = {
        show = "auto";
        thumb = "hover";
        thumb_border = "left_open";
        current_line_highlight = "all";
      };
      tab_bar = {
        show = true;
        show_nav_history_buttons = true;
        show_tab_bar_buttons = true;
      };
      toolbar = {
        breadcrumbs = true;
        quick_actions = true;
        selections_menu = true;
        agent_review = true;
        code_actions = false;
      };

      enable_language_server = true;
      "status_bar" = {
        "active_language_button" = true;
        "cursor_position_button" = true;
        "line_endings_button" = true;
      };

      global_lsp_settings.button = true;
      lsp = { yaml-language-server.settings.yaml.keyOrdering = true; };
      format_on_save = "on";
      formatter = "language_server";
    };
  };
}
