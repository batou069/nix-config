{ ... }: {
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--smart-case"
      "--pretty"
      "--hidden"
      "--column"
      "--heading"
      "--trim"
      "--stats"
    ];
  };
}
