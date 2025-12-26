{ ... }: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = { hide_env_diff = true; };
    # Shell integrations are auto-enabled when the shell is enabled
  };
}
