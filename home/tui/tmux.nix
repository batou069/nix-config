{ lib
, pkgs
, ...
}: {
  xdg.configFile = {
    "tmux/plugins/tmux-which-key/config.yaml".text = lib.generators.toYAML { } {
      command_alias_start_index = 200;
      keybindings.prefix_table = "Space"; # The keybinding for the prefix key table (required)
      keybindings.root_table = "C-Space";
      title = {
        style = "align=centre,bold"; # The title style
        prefix = "tmux"; # A prefix added to every menu title
        prefix_style = "fg=green,align=centre,bold"; # The prefix style
      };
    };
  };
  programs.tmux = {
    enable = true;
    clock24 = true;
    aggressiveResize = true;
    baseIndex = 1;
    disableConfirmationPrompt = true;
    focusEvents = true;
    mouse = true;
    newSession = true;
    shortcut = "a";
    sensibleOnTop = true;
    terminal = "screen-256color"; # "xterm-kitty";
    shell = "${pkgs.zsh}/bin/zsh";
    tmuxinator.enable = true;
    customPaneNavigationAndResize = true;
    historyLimit = 9999999;
    resizeAmount = 5;
    keyMode = "vi";
    plugins = [
      pkgs.tmuxPlugins.vim-tmux-navigator
      # pkgs.tmuxPlugins.urlview
      pkgs.tmuxPlugins.tmux-which-key

      # pkgs.tmuxPlugins.tmux-sessionx
      # pkgs.tmuxPlugins.tmux-powerline
      pkgs.tmuxPlugins.tmux-floax
      pkgs.tmuxPlugins.tmux-fzf
      # pkgs.tmuxPlugins.session-wizard
      pkgs.tmuxPlugins.resurrect
      pkgs.tmuxPlugins.prefix-highlight
      pkgs.tmuxPlugins.mode-indicator
      # pkgs.tmuxPlugins.cpu
      pkgs.tmuxPlugins.copycat
      pkgs.tmuxPlugins.continuum
      pkgs.tmuxPlugins.catppuccin
      # pkgs.tmuxPlugins.battery
    ];
    extraConfig = ''
            set -g @catppuccin_flavour 'frappe' # or macchiato, frappe, latte, mocha
            set -g @resurrect-strategy-nvim 'session' # Restore nvim sessions
            set -g @tmux-which-key-xdg-enable 1;

            is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
        | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"

      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'

      # Forwarding <C-\\> needs different syntax, depending on tmux version
      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
        "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
        "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'C-\' select-pane -l
    '';
  };
}
