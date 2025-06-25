{ pkgs, config, username, ... }:
{
  # Home Manager version
  home.stateVersion = "24.11";

  # User information
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # User-specific packages
  home.packages = with pkgs; [
    lsd
    fd
    fzf
    ripgrep
    repgrep
    ripgrep-all
  ];

  # Bat configuration
  programs.bat = {
    enable = true;
    config = {
      theme = "Catppuccin Mocha";
    };
    themes = {
      "Catppuccin Mocha" = {
        src = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/bat/refs/heads/main/themes/Catppuccin%20Mocha.tmTheme";
          sha256 = "sha256-Rj7bB/PCaC/r0y+Nh62yI+Jg1O0WDm88E+DrsaDZj6o="; # Replace with actual sha256
        };
      };
    };
  };

  # Enable Home Manager to manage itself
  programs.home-manager.enable = true;
}