{ lib
, config
, pkgs
, pkgs-unstable
, ...
}: {
  programs = {
    fd = {
      enable = true;
      hidden = true;
      ignores = [
        ".git/"
        "__pycache__/"
        ".ipynb_checkpoints/"
        ".mypy_cache/"
        ".vscode/"
        ".tmp/"
      ];
      extraOptions = [
        "--color=auto"
      ];
    };
    tmux = {
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
      terminal = "xterm-kitty";
      tmuxinator.enable = true;
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
    superfile = {
      enable = true;
      # settings = {
      #   transparent_background = true;
      # theme = "catppuccin-frappe";
      # };
    };
    ghostty = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      installBatSyntax = true;
      installVimSyntax = true;
      package = pkgs-unstable.ghostty;
      settings = {
        font-family = "Maple Mono NF";
        font-thicken = true;
        bold-is-bright = true;
        font-style = "medium italic";
        keybind = [
          "ctrl+shift+s>left=new_split:left"
          "ctrl+shift+s>down=new_split:down"
          "ctrl+shift+s>up=new_split:up"
          "ctrl+shift+s>right=new_split:right"
          "ctrl+shift+s>a=new_split:auto"
          "ctrl+shift+s>c=close_surface"
          "ctrl+shift+left=goto_split:left"
          "ctrl+shift+right=goto_split:right"
          "ctrl+shift+up=goto_split:top"
          "ctrl+shift+down=goto_split:bottom"
        ];
        font-size = 12;
        font-thicken-strength = 127;

        link-url = true;
        minimum-contrast = 1;

        # mouse
        mouse-scroll-multiplier = 2;
        mouse-hide-while-typing = true;
        mouse-shift-capture = true;

        quick-terminal-position = "top";
        quick-terminal-screen = "main";

        selection-invert-fg-bg = true;
        cursor-color = "#f5e0dc";
        cursor-text = "#cdd6f4";
        cursor-invert-fg-bg = true;
        cursor-style = "block_hollow";
        cursor-style-blink = false;
        quick-terminal-animation-duration = 0.08;
        auto-update = "check";
        auto-update-channel = "stable";
        quit-after-last-window-closed = true;
        shell-integration-features = true;

        # window
        initial-window = true;
        resize-overlay = "never";
        background-opacity = 0.8;
        unfocused-split-opacity = 0.9;
        # unfocused-split-fill = ffc0cb
        window-save-state = "always";
        window-step-resize = false;
        background-blur-radius = 20;
        window-padding-balance = true;
        confirm-close-surface = false;
      };
      themes = {
        catppuccin-mocha = {
          background = "1e1e2e";
          cursor-color = "f5e0dc";
          foreground = "cdd6f4";
          palette = [
            "0=#45475a"
            "1=#f38ba8"
            "2=#a6e3a1"
            "3=#f9e2af"
            "4=#89b4fa"
            "5=#f5c2e7"
            "6=#94e2d5"
            "7=#bac2de"
            "8=#585b70"
            "9=#f38ba8"
            "10=#a6e3a1"
            "11=#f9e2af"
            "12=#89b4fa"
            "13=#f5c2e7"
            "14=#94e2d5"
            "15=#a6adc8"
          ];
          selection-background = "353749";
          selection-foreground = "cdd6f4";
        };
      };
    };

    atuin = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      settings = {
        inline_height = 30;
        style = "compact";
        history_format = "{time} - {duration} - {directory} - {command}";
        store_failed = false;
        enter_accept = true;
        scroll_exits = false;
        invert = true;
      };
      daemon = {
        enable = true;
        logLevel = "warn";
      };
      flags = [
        "--disable-up-arrow"
        # "--disable-ctrl-r"
      ];
      themes = {
        "catppuccin-frappe-peach" = {
          theme.name = "catppuccin-frappe-peach";
          colors = {
            AlertInfo = "#a6d189";
            AlertWarn = "#ef9f76";
            AlertError = "#e78284";
            Annotation = "#ef9f76";
            Base = "#c6d0f5";
            Guidance = "#949cbb";
            Important = "#e78284";
            Title = "#ef9f76";
          };
        };
      };
    };

    sesh = {
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
    kitty = {
      enable = true;
      shellIntegration = {
        enableZshIntegration = true;
        enableFishIntegration = true;
      };
      enableGitIntegration = true;
      settings = {
        cursor_shape = "block";
        cursor_blink = true;
        cursor_beam_thickness = 1.0;
        cursor_shape_unfocused = "hollow";
        underline_hyperlinks = "always";
        copy_on_select = "clipboard";
        clear_selection_on_clipboard_loss = "yes";
        strip_trailing_spaces = "smart";
        enable_audio_bell = "yes";
        hide_window_decorations = "yes";
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
        tab_activity_symbol = "(O)";
        font_size = 17.0;
        dynamic_background_opacity = "yes";
        window_padding_width = 0;
        window_padding_height = 0;
        background_blur = 10;
        background_opacity = 1;
        set_background_opacity = 1;
        placement_strategy = "top";
        cursor_trail = 10;
        cursor_trail_start_threshold = 0;
        cursor_trail_decay = "0.01 0.05";

        # background_image = "/home/lf/Pictures/wallpapers/Minimal_Squares.png";
        # background_image_layout = "centered";
      };
      keybindings = {
        "ctrl+shift+f1" = "show_kitty_doc overview";

        "ctrl+shift+a>m" = "set_background_opacity +0.1";
        "ctrl+shift+a>l" = "set_background_opacity -0.1";

        "ctrl+alt+left" = "resize_window narrower";
        "cctrl+alt+right" = "resize_window wider";
        "cctrl+alt+up" = "resize_window taller";
        "cctrl+alt+down" = "resize_window shorter 3";
        "cctrl+alt+r" = "resize_window reset";

        "ctrl+left" = "neighboring_window left";
        "shift+left" = "move_window right";
        "ctrl+down" = "neighboring_window down";
        "shift+down" = "move_window up";
        "f1" = "toggle_marker regex 1 \\bERROR\\b";
        "f2" = "create_marker";
        "f3" = "remove_marker";
        "ctrl+p" = "scroll_to_mark prev";
        "ctrl+n" = "scroll_to_mark next";
      };
    };

    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/lf/nix";
    };

    eza = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = false;
      enableZshIntegration = true;
      colors = "always";
      git = true;
      icons = "auto";
      extraOptions = [
        "--color=always"
        "--level=1"
        "--classify"
        "--color-scale"
        "--git"
        "--group-directories-first"
        "--dereference"
        "--time-style=+%Y/%m/%d %H:%M"
      ];
    };

    htop = {
      enable = true;
      settings =
        {
          tree_view = 1;
          hide_kernel_threads = 1;
          hide_userland_threads = 1;
          shadow_other_users = 1;
          show_thread_names = 1;
          show_program_path = 0;
          highlight_base_name = 1;
          header_layout = "two_67_33";
          # color_scheme = 6;
        }
        // (with config.lib.htop; leftMeters [ (bar "AllCPUs4") ])
        // (
          with config.lib.htop;
          rightMeters [
            (bar "Memory")
            (bar "Swap")
            (bar "DiskIO")
            (bar "NetworkIO")
            (text "Systemd")
            (text "Tasks")
            (text "LoadAverage")
          ]
        );
    };

    zellij = {
      enable = true;
      enableZshIntegration = false;
      settings = {
        theme = "one-half-dark";
        themes.one-half-dark = {
          bg = [ 40 44 52 ];
          gray = [ 40 44 52 ];
          red = [ 227 63 76 ];
          green = [ 152 195 121 ];
          yellow = [ 229 192 123 ];
          blue = [ 97 175 239 ];
          magenta = [ 198 120 221 ];
          orange = [ 216 133 76 ];
          fg = [ 220 223 228 ];
          cyan = [ 86 182 194 ];
          black = [ 27 29 35 ];
          white = [ 233 225 254 ];
        };
      };
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };

    # for nushell wrapper to pick up HM things
    bash.enable = true;
    fish.enable = true; # only for nushell completions really
    carapace = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };

    nushell = {
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

    man.enable = lib.mkDefault false;

    ripgrep = {
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
  };

  manual = {
    html.enable = true;
    manpages.enable = true;
  };
}
