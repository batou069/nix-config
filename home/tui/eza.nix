{ ... }: {
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = false;
    enableZshIntegration = true;
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
