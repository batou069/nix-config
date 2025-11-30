{ pkgs-unstable, ... }: {
  programs.zoxide = {
    enable = true;
    package = pkgs-unstable.zoxide;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };
}
