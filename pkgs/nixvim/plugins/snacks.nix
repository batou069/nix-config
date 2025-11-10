{ ... }: {
  programs.nixvim = {
    plugins.snacks = {
      enable = true;
      settings = {
        snackline = {
          enabled = true;
        };
      };
    };
  };
}
