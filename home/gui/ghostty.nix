{ pkgs-unstable, ... }: {
  programs.ghostty = {
    enable = true;
    systemd.enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
    package = pkgs-unstable.ghostty;
    settings = {
      font-family = "Maple Mono Italic SemiBold";
      font-thicken = true;
      bold-is-bright = true;
      font-style = "medium italic";
      font-feature = "cv02,cv38,cv42,cv43,cv62,cv66,ss03,ss07,zero";
      window-title-font-family = "JetBrains Mono";
      keybind = [
        "ctrl+s>left=new_split:left"
        "ctrl+s>down=new_split:down"
        "ctrl+s>up=new_split:up"
        "ctrl+s>right=new_split:right"
        "ctrl+s>a=new_split:auto"
        "ctrl+s>c=close_surface"
        "alt+left=goto_split:left"
        "alt+right=goto_split:right"
        "alt+up=goto_split:top"
        "alt+down=goto_split:bottom"
      ];
      font-size = 10;
      font-thicken-strength = 127;

      link-url = true;
      minimum-contrast = 1;

      # mouse
      mouse-scroll-multiplier = 10;
      mouse-hide-while-typing = true;
      mouse-shift-capture = true;

      quick-terminal-position = "top";
      quick-terminal-screen = "main";

      selection-invert-fg-bg = false;
      cursor-click-to-move = true;
      cursor-color = "#ffee00ff";
      cursor-text = "#cdd6f4";
      cursor-style = "block_hollow";
      cursor-style-blink = false;
      quick-terminal-animation-duration = 0.08;
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
      theme = "maple";
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
      maple = {
        background = "#1e1e1f";
        cursor-color = "#cbd5e1";
        foreground = "#cbd5e1";
        palette = [
          "8 = #666666"
          "12 = #a8e0ff"
          "14 = #bafffe"
          "10 = #bdf8c7"
          "13 = #ebe5ff"
          "9 = #ffc4c4"
          "15 = #ffffff"
          "11 = #ffe8b9"
          "0 = #333333"
          "4 = #8fc7ff"
          "6 = #a1e8e5"
          "2 = #a4dfae"
          "5 = #d2ccff"
          "1 = #edabab"
          "7 = #f3f2f2"
          "3 = #eecfa0"
        ];
        selection-background = "#cbd5e1";
        selection-foreground = "#1e1e1f";
      };
    };
  };
}
