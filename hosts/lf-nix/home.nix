{ pkgs, username, ... }:
{
  # Home Manager version
  home.stateVersion = "24.11";

  # User information
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # User-specific packages
  home.packages = with pkgs; [
    lsd
    bat
    fd
    fzf
    ripgrep
    repgrep
    ripgrep-all
  ];

  # Neovim symlink service (ported from users.nix)
  systemd.user.services.create-nvim-symlinks = {
    description = "Create Neovim config symlinks";
    wantedBy = [ "default.target" ];
    script = ''
      mkdir -p ${home.homeDirectory}/.config/nvim/lazyvim
      mkdir -p ${home.homeDirectory}/.config/nvim/ksnvim
      ln -sfn ${home.homeDirectory}/.config/nvim/lazyvim ${home.homeDirectory}/.config/lazyvim
      ln -sfn ${home.homeDirectory}/.config/nvim/ksnvim ${home.homeDirectory}/.config/ksnvim
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      PrivateTmp = false; # Required for 25.05
      ProtectHome = false; # Required for 25.05
    };
  };

  # Enable Home Manager to manage itself
  programs.home-manager.enable = true;
}