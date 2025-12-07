{ pkgs, ... }: {
  programs.atuin = {
    enable = true;
    package = pkgs.atuin;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    settings = {
      inline_height = 30;
      style = "full";
      filter_mode_shell_up_key_binding = "session";
      workspaces = true;
      history_filter = [
        "^_"
        "^set-env "
        "^export "
      ];
      history_format = "{time} - {duration} - {directory} - {command}";
      store_failed = false;
      enter_accept = true;
      scroll_exits = false;
      invert = true;
      records = true;
      search_mode = "skim";
      secrets_filter = true;
      show_preview = true;
    };
    daemon = {
      enable = true;
      logLevel = "warn";
    };
    flags = [
      "--disable-up-arrow"
    ];
    themes = {
      "catppuccin-frappe-peach" = {
        theme.name = "catppuccin-frappe-peach";
        colors = {
          AlertInfo = "#a6d189";
          AlertWarn = "#ef9f76";
          AlertError = "#e78284";
          Annotation = "#ef9f76";
          Base = "#c6d0f5";
          Guidance = "#949cbb";
          Important = "#e78284";
          Title = "#ef9f76";
        };
      };
    };
  };
}
