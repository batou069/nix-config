{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Disable the welcome message
      set fish_greeting

      # VI Mode (If you like it)
      fish_vi_key_bindings
    '';
    # Plugins are managed via simple lists or "fisher"
    plugins = [
      # FZF support for Fish
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      # Syntax highlighting is native, but "done" adds nicer patterns
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
    ];
  };
}
