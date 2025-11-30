{ pkgs-unstable, ... }: {
  programs.carapace = {
    enable = true;
    package = pkgs-unstable.carapace;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableBashIntegration = true;
  };
}
