{ ... }: {
  programs.nixvim = {
    dependencies = {
      bat.enable = true;
      fzf.enable = false;
      # gemini.enable = true;
      git.enable = true;
      lazygit.enable = true;
      ripgrep.enable = true;
      yazi.enable = true;
      curl.enable = true;
    };
  };
}
