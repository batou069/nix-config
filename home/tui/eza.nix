{ pkgs-unstable, ... }: {
  programs.eza = {
    enable = true;
    package = pkgs-unstable.eza;
    enableFishIntegration = true;
    enableNushellIntegration = false;
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
