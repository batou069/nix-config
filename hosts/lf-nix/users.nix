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
    
  programs = {
  # Zsh configuration
    zsh = {
    	enable = true;
	enableCompletion = true;
        ohMyZsh.enable = false;
      
        autosuggestions.enable = false;
        syntaxHighlighting.enable = false;
        promptInit = "";
      };
   };
}
