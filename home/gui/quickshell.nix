{ inputs
, libPkgs
, ...
}: {
  programs.quickshell = {
    # activeConfig = ;
    # configs = ;
    enable = true;
    package = (libPkgs inputs.quickshell).quickshell;
    systemd = {
      enable = true;
      # target = ;	The systemd target that will automatically start quickshell. If you set this to a WM-specific target, make sure that systemd integration for that WM is enabled (e.g. `wayland.windowManager.hyprland.systemd.enable`). **This is typically true by default**. 	string
    };
  };
}
