{
  pkgs,
  ...
}: {
  programs.lsd = {
    enable = true;
    enableZshIntegration= true;
    package = pkgs.lsd;
    settings = {
      date = "relative"; # Show relative dates
      icons = {
        when = "auto"; # Auto-detect icon support
        theme = "fancy"; # Use fancy icons
      };
    };
  };
}