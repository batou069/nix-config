{
  inputs,
  pkgs,
  ...
}: {
  programs.hyprpanel = {
    enable = true;
    package = inputs.hyprpanel.packages.${pkgs.system}.default;
    dontAssertNotificationDaemons = true;
    systemd.enable = true;

    # Configure bar layouts for monitors.
    # See 'https://hyprpanel.com/configuration/panel.html'.
    # Default: null

    # Configure and theme almost all options from the GUI.
    # See 'https://hyprpanel.com/configuration/settings.html'.
    # Default: <same as gui>
    settings = {
      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;

      menus.clock = {
        time = {
          military = true;
          hideSeconds = true;
        };
        weather.unit = "metric";
      };
      layout = {
        "bar.layouts" = {
          "*" = {
            left = ["dashboard" "workspaces" "windowtitle"];
            middle = ["cava" "media"];
            right = [
              "volume"
              "network"
              "bluetooth"
              "systray"
              "clock"
              "notifications"
            ];
          };
        };
      };
      bar.clock.format = "%e | %H:%M";
      menus.dashboard.directories.enabled = true;
      menus.dashboard.stats.enable_gpu = false;

      theme.bar.transparent = true;

      theme.font = {
        name = "Maple Mono NF";
        size = "16px";
      };
    };
  };
}
