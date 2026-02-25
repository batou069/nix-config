{ pkgs, ... }: {
  programs.nushell = {
    enable = true;
    plugins = with pkgs.nushellPlugins; [
      # highlight
      formats
      query
      # skim
      # net
      # units
      gstat
      polars
    ];
    # extraConfig = ''
    #   $env.config.keybindings = ($env.config.keybindings | append {
    #     name: atuin_search
    #     modifier: control
    #     keycode: char_p
    #     mode: [emacs, vi_normal, vi_insert]
    #     event: { send: executehostcommand cmd: (_atuin_search_cmd "--shell-up-key-binding") }
    #   })
    # '';
    settings = {
      # show_banner = false;
      # edit_mode = "vi";
      # cursor_shape = {
        # vi_normal = "block";
        # vi_insert = "line";
      # };
      # enable_color = true;
      # enable_command_completion = true;
      # enable_command_suggestions = true;
      # enable_command_history = true;>
      # enable_command_aliases = false;
      # enable_command_env_vars = true;
      history.file_format = "sqlite";
    };
  };
}
