{ lib
, config
, ...
}: {
  gtk = {
    enable = true;
    iconTheme = {
      package = lib.mkForce config.stylix.icons.package;
      name = lib.mkForce config.stylix.icons.${config.stylix.polarity};
    };
    colorScheme = "dark";
    gtk3 = {
      bookmarks = [
        "file://${config.home.homeDirectory}/Documents"
        "file://${config.home.homeDirectory}/Downloads"
        "file://${config.home.homeDirectory}/Pictures"
        "file://${config.home.homeDirectory}/Videos"
        "file://${config.home.homeDirectory}/Downloads"
        "file://${config.home.homeDirectory}/repos"
      ];
    };
  };
}
