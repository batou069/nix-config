{ ... }: {
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    settings = {
      inline_height = 30;
      style = "compact";
      history_format = "{time} - {duration} - {directory} - {command}";
      store_failed = false;
      enter_accept = true;
      scroll_exits = false;
      invert = true;
    };
    daemon = {
      enable = true;
      logLevel = "warn";
    };
    flags = [
      "--disable-up-arrow"
      # "--disable-ctrl-r"
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
