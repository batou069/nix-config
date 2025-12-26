{ ... }: {
  systemd.user = {
    startServices = "sd-switch";
    targets.hyprland-session = {
      Unit = {
        Description = "Hyprland compositor session";
        Documentation = [ "man:systemd.special(7)" ];
        BindsTo = [ "graphical-session.target" ];
        Wants = [ "graphical-session-pre.target" ];
        After = [ "graphical-session-pre.target" ];
      };
    };
    services = {
      # waybar = {
      #   Unit = {
      #     Description = "Waybar";
      #     PartOf = [ "graphical-session.target" ];
      #   };
      #   Service = {
      #     ExecStart = "${pkgs.waybar}/bin/waybar";
      #     Restart = "on-failure";
      #     RestartSec = 1;
      #   };
      #   Install = { WantedBy = [ "hyprland-session.target" ]; };
      # };

      activitywatch-watcher-aw-watcher-window-wayland = {
        Unit.ConditionEnvironment = "HYPRLAND_INSTANCE_SIGNATURE";
      };
    };
  };
}
