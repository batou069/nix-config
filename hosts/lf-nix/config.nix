{ inputs
, lib
, pkgs
, ...
}: {
  imports = [
    ./hardware.nix

    ../default/core.nix
    ../default/config.nix
    ../default/kde.nix
    ../default/users.nix
    ../default/packages.nix

    ../../modules/intel-drivers.nix
    ../../modules/vm-guest-services.nix
    ../../modules/local-hardware-clock.nix

    # ./clickcapital-parser.nix

    "${inputs.nix-mineral}/nix-mineral.nix"
    ./packages.nix
  ];

  networking.hostName = "lf-nix";
  users.defaultUserShell = pkgs.nushell;
  stylix = {
    enable = true;
    autoEnable = true;
    # targets.hyprland.enable = false;
    enableReleaseChecks = true;
    base16Scheme = ../../assets/base16_themes/catppuccin-frappe.yaml;
    # image = "/home/lf/Pictures/wallpapers/City-Night.png";

    overlays.enable = true;
    targets.qt.platform = lib.mkForce "qtct";
    homeManagerIntegration = {
      autoImport = true;
      followSystem = true;
    };
  };
}
