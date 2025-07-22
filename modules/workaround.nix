{lib, ...}: {
  # This defines the attribute that the unstable home-manager module needs.
  # Using mkDefault gives it the lowest priority, so it won't interfere
  # if another module ever needs to legitimately define it.
  config.services.desktopManager.gnome.enable = lib.mkDefault false;
}
