{ pkgs, ... }: {
  programs.eza = {
    enable = true;
    package = pkgs.eza;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    colors = "always";
    git = true;
    icons = "auto";
    extraOptions = [
      "--color=always"
      "--level=1"
      "--classify"
      "--color-scale"
      "--git"
      "--group-directories-first"
      "--dereference"
      "--time-style=+%Y/%m/%d %H:%M"
    ];
  };
}
