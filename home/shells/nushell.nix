{ pkgs, ... }: {
  programs.nushell = {
    enable = true;
    plugins = with pkgs.nushellPlugins; [
      highlight
      formats
      query
      skim
      net
      units
      gstat
    ];
    settings = {
      show_banner = true;
      enable_color = true;
      enable_command_completion = true;
      enable_command_suggestions = true;
      enable_command_history = true;
      enable_command_aliases = true;
      enable_command_env_vars = true;
    };
  };
}
