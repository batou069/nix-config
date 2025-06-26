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



  #VSCode configuration

   programs.vscode = {
    enable = true;
    package = pkgs.vscode-fhs; 

    # Define your VS Code settings here
    profiles.default.userSettings = {
      "editor.fontFamily" = "'MapleMono-NF-LightItalic', monospace"; 
      "editor.fontSize" = 14; 
      "editor.tabSize" = 2;   
      # "editor.fontFamily": "'Fira Code', Consolas, monospace",
      "editor.fontLigatures" = true;
      "[docker-compose]" = {
        "editor.defaultFormatter" = "KilianJPopp.docker-compose-support";
        "editor.formatOnSave" = true;
        };
      "docker-compose.format.enabled" = true;
      "nix.serverPath"= "nixd";
      "nix.enableLanguageServer"= true;
      "nix.serverSettings" = {
        "nixd.formatting.command" = [ "alejandra" ];
          };
        };
      };
 # programs.home-manager.enable = true;
}