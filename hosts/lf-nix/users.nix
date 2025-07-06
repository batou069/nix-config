{
  pkgs,
  username,
  ...
}:
# users.nix
{
  users = {
    mutableUsers = true;
    users."${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "Laurent Flaster";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
        "video"
        "input"
        "audio"
        "docker"
      ];
    };
    defaultUserShell = pkgs.zsh;
  };

  #  environment.shells = with pkgs; [ zsh ];
  # environment.systemPackages = with pkgs; [
    # lsd
    # bat
  #  fd
    # fzf
    # ripgrep
   # grip-grab
   # repgrep
   # ripgrep-all
  #   ];
  systemd.user.services.install-pre-commit = {
    description = "Install pre-commit hooks for dotfiles";
    wantedBy = ["default.target"];
    script = ''
      ${pkgs.pre-commit}/bin/pre-commit install --install-dir $HOME/nix
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      PrivateTmp = false;
      ProtectHome = false;
    };
  };
}
