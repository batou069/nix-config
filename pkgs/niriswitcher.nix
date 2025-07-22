{pkgs, ...}: {
  programs.niriswitcher = {
    enable = true;
    package = pkgs.unstable.niriswitcher;
    settings = {
      keys = {
        modifier = "Super";
        switch = {
          next = "Tab";
          prev = "Shift+Tab";
        };
        window = {
          close = "q";
          abort = "Escape";
        };
      };
      appearance = {
        # system_theme = "dark";
        icon_size = 64;
      };
      separate_workspaces = true;
      current_output_only = false;
      double_click_to_hide = false;
      center_on_focus = false;
      log_level = "WARN";
    };
  };
}
