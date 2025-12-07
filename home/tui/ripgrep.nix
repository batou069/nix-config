{ pkgs, ... }: {
  programs.ripgrep = {
    enable = true;
    package = pkgs.ripgrep;
    arguments = [
      "--max-columns=150"
      "--max-columns-preview"
      "--smart-case"
      "--pretty"
      "--hidden"
      "--column"
      "--heading"
      "--trim"
      "--stats"
      "--glob=!.git/*"
    ];
  };
}
