{ pkgs, ... }: {
  programs.carapace = {
    enable = true;
    package = pkgs.carapace;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableBashIntegration = true;
  };
}
