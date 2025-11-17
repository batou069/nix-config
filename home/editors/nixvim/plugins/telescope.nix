{ ... }: {
  programs.nixvim = {
    plugins = {
      telescope = {
        enable = true;
        extensions = {
          #file_browser = {
          #  enable = true;
          # hijackNetrw = true;
          #};
          # frecency.enable = true;
          fzf-native.enable = true;
          undo.enable = true;
        };
      };
      fzf-lua = {
        enable = true;
        profile = "fzf-tmux"; # Type: null or one of “default”, “fzf-native”, “fzf-tmux”, “fzf-vim”, “max-perf”, “telescope”, “skim” or raw lua code
      };
    };
  };
}
