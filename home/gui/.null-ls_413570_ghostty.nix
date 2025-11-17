{ pkgs-unstable, ... }: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
    package = pkgs-unstable.ghostty;
    settings = {
      font-family = "Maple Mono NF";
      font-thicken = true;
      bold-is-bright = true;
      font-style = "medium italic";
      keybind = [
        "ctrl+shift+s>left=new_split:left"
        "ctrl+shift+s>down=new_split:down"
        "ctrl+shift+s>up=new_split:up"
        "ctrl+shift+s>right=new_split:right"
        "ctrl+shift+s>a=new_split:auto"
        "ctrl+shift+s>c=close_surface"
        "ctrl+shift+left=goto_split:left"
        "ctrl+shift+right=goto_split:right"
        "ctrl+shift+up=goto_split:top"
        "ctrl+shift+down=goto_split:bottom"
      ];
      font-size = 12;
      font-thicken-strength = 127;

      link-url = true;
      minimum-contrast = 1;

      # mouse
      mouse-scroll-multiplier = 2;
      mouse-hide-while-typing = true;
      mouse-shift-capture = true;

      quick-terminal-position = "top";
      quick-terminal-screen = "main";

      selection-invert-fg-bg = true;
      cursor-color = "#f5e0dc";
      cursor-text = "#cdd6f4";
      cursor-invert-fg-bg = true;
      cursor-style = "block_hollow";
      cursor-style-blink = false;
      quick-terminal-animation-duration = 8.0e-2;
      auto-update = "check";
      auto-update-channel = "stable";
      quit-after-last-window-closed = true;
      shell-integration-features = true;

      # window
      initial-window = true;
      resize-overlay = "never";
      background-opacity = 0.8;
      unfocused-split-opacity = 0.9;
      # unfocused-split-fill = ffc0cb
      window-save-state = "always";
      window-step-resize = false;
      background-blur-radius = 20;
      window-padding-balance = true;
      confirm-close-surface = false;
    };
    themes = {
      catppuccin-mocha = {
        background = "1e1e2e";
        cursor-color = "f5e0dc";
        foreground = "cdd6f4";
        palette = [
          "0=#45475a"
          "1=#f38ba8"
          "2=#a6e3a1"
          "3=#f9e2af"
          "4=#89b4fa"
          "5=#f5c2e7"
          "6=#94e2d5"
          "7=#bac2de"
          "8=#585b70"
          "9=#f38ba8"
          "10=#a6e3a1"
          "11=#f9e2af"
          "12=#89b4fa"
          "13=#f5c2e7"
          "14=#94e2d5"
          "15=#a6adc8"
        ];
        selection-background = "353749";
        selection-foreground = "cdd6f4";
      };
    };
  };
}
