{
  lib,
  config,
  pkgs,
  ...
}: {
  programs = {
    micro = {
      enable = true;
      settings = {
        clipboard = "internal";
        # colorscheme = "one-dark";
        diffgutter = true;
        indentchar = "space";
        scrollbar = true;
      };
    };

    kitty = {
      enable = true;
      shellIntegration = {
        enableZshIntegration = true;
        enableFishIntegration = true;
      };
      settings = {
        cursor_shape = "beam";
        cursor_beam_thickness = 1.5;
        cursor_shape_unfocused = "hollow";
        underline_hyperlinks = "always";
        copy_on_select = "clipboard";
        clear_selection_on_clipboard_loss = "yes";
        strip_trailing_spaces = "smart";
        enable_audio_bell = "yes";
        hide_window_decorations = "yes";
        tab_bar_style = "powerline";
        tab_powerline_style = "slanted";
        tab_activity_symbol = "(X)";
      };
      # };
    };

    eza = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = false;
      enableZshIntegration = true;
      colors = "always";
      extraOptions = [
        "--classify"
        "--color-scale"
        "--git"
        "--group-directories-first"
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
        // (with config.lib.htop; leftMeters [(bar "AllCPUs4")])
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
          bg = [
            40
            44
            52
          ];
          gray = [
            40
            44
            52
          ];
          red = [
            227
            63
            76
          ];
          green = [
            152
            195
            121
          ];
          yellow = [
            229
            192
            123
          ];
          blue = [
            97
            175
            239
          ];
          magenta = [
            198
            120
            221
          ];
          orange = [
            216
            133
            76
          ];
          fg = [
            220
            223
            228
          ];
          cyan = [
            86
            182
            194
          ];
          black = [
            27
            29
            35
          ];
          white = [
            233
            225
            254
          ];
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
    };

    nushell = {
      enable = true;
      plugins = with pkgs.nushellPlugins; [
        polars
        highlight
        formats
        query
        skim
        net
        units
        gstat
      ];
      settings = {
        show_banner = false;
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
      ];
    };
  };

  manual = {
    html.enable = true;
    manpages.enable = true;
  };
}
