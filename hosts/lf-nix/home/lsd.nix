{
  pkgs,
  ...
}: {
  programs.lsd = {
    enable = true;
    enableZshIntegration= true;
    package = pkgs.lsd;
    enableAliases = true; # Enables aliases like `ll`, `ls`, `lt`
    settings = {
      date = "relative"; # Show relative dates
      icons = {
        when = "auto"; # Auto-detect icon support
        theme = "fancy"; # Use fancy icons
      };
    };
  };
}