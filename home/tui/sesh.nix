{ ... }: {
  programs.sesh = {
    enable = true;
    enableAlias = true;
    enableTmuxIntegration = true;
    tmuxKey = "s";
    icons = true;
    settings = {
      default_session = {
        name = "Downloads 📥";
        path = "~/Downloads";
        startup_command = "ls";
        # startup_command = "nvim -c ':Telescope find_files'";
        preview_command = "eza --all --git --icons --color=always {}";
      };
    };
  };
}
