{ pkgs
, inputs
, lib
, ...
}: {
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
  ];
  home.packages = with pkgs; [
    (catppuccin-kde.override {
      flavour = [ "macchiato" ];
      accents = [ "lavender" ];
    })
    gnome-text-editor
    kde-rounded-corners
    kdePackages.kcalc
    kdePackages.krohnkite
    kdotool
    libnotify
    tela-circle-icon-theme
  ];

  services = {
    gpg-agent = {
      pinentry.package = lib.mkForce pkgs.kwalletcli;
      extraConfig = "pinentry-program ${pkgs.kwalletcli}/bin/pinentry-kwallet";
    };
    kdeconnect = {
      enable = true;
    };
  };

  programs.plasma = {
    enable = true;
  };

  qt.platformTheme.name = lib.mkForce "kde";
}
