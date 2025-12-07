{ pkgs, ... }: {
  programs.intelli-shell = {
    enable = true;
    package = pkgs.intelli-shell;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    settings = {
      check_updates = false;
      logs.enabled = false;
      theme = {
        accent = "yellow";
        comment = "italic green";
        error = "dark red";
        highlight = "darkgrey";
        highlight_accent = "yellow";
        highlight_comment = "italic green";
        highlight_primary = "default";
        highlight_secondary = "default";
        highlight_symbol = "» ";
        primary = "default";
        secondary = "dim";
      };
      # keybindings = {
      #   bookmark_hotkey = "\\\\C-b";
      #   fix_hotkey = "\\\\C-p";
      #   search_hotkey = "\\\\C-t";
      #   skip_esc_bind = "\\\\C-q";
      #   variable_hotkey = "\\\\C-a";
      # };
    };
  };
}
