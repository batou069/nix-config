{ pkgs, ... }: {
  services = {
    activitywatch = {
      enable = true;
      watchers = {
        aw-watcher-window-wayland = {
          package = pkgs.aw-watcher-window-wayland;
        };
        # aw-watcher-afk = {
        #   enable = false;
        #   package = pkgs.aw-watcher-afk;
        #   settings = {
        #     timeout = 180;
        #     poll_time = 5;
        #   };
        # };

        # aw-watcher-window = {
        #   package = pkgs.aw-watcher-window;
        #   settings = {
        #     poll_time = 4;
        #     exclude_title = true;
        #   };
        # };
      };
    };
  };
}
