# 💫 https://github.com/JaKooLit 💫 #
# Users - NOTE: Packages defined on this will be on current user only

{ pkgs, username, ... }:

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

    # define user packages here
    packages = with pkgs; [
      ];
    };
    
    defaultUserShell = pkgs.zsh;
  }; 
  
  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [ lsd bat fd fzf ]; 
    


  systemd.user.services.create-nvim-symlinks = {
    description = "Create Neovim config symlinks";
    wantedBy = [ "default.target" ];
    script = ''
      # Create the target directories first to be safe
      mkdir -p /home/${username}/.config/nvim/lazyvim
      mkdir -p /home/${username}/.config/nvim/ksnvim

      # Create the symlinks if they don't already exist
      ln -sfn /home/${username}/.config/nvim/lazyvim /home/${username}/.config/lazyvim
      ln -sfn /home/${username}/.config/nvim/ksnvim /home/${username}/.config/ksnvim
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };
}
