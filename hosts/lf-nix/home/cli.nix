{
  lib,
  config,
  pkgs,
  ...
}:
{

  programs = {
    micro = {
      enable = true;
      settings = {
        clipboard = "internal";
        colorscheme = "one-dark";
        diffgutter = true;
        indentchar = "space";
        scrollbar = true;
      };
    };

    eza = {
      enable = true;
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
          color_scheme = 6;
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
      enableBashIntegration = false;
      enableFishIntegration = false;
      enableZshIntegration = true;


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

  zoxide.enable = true;
    
  lsd = {
    enable = true;
    enableZshIntegration= true;
    package = pkgs.lsd;
    settings = {
      date = "relative"; # Show relative dates
      icons = {
        when = "auto"; # Auto-detect icon support
        theme = "fancy"; # Use fancy icons
      };
    };
  };

  fzf = {
      enable = true;
      package = pkgs.fzf;
      enableZshIntegration = true;
      defaultCommand = "fd --type f --hidden --follow --exclude .git"; # Matches _fzf_compgen_path
      defaultOptions = [
        "--preview='bat --style=numbers --color=always --line-range :500 {}'"
        "--preview-window 'right:70%:wrap'"
        "--border-label='File Picker'"
        "--layout=reverse"
        # "--border=none"
        "--info='hidden'"
        "--header=''"
        "--prompt='/ '"
        "-i"
        # "--no-bold"
        "--no-hscroll"
        "--bind='enter:execute(nvim {})'"
      ];
      fileWidgetCommand = "fd --type f --hidden --follow --exclude .git"; # Matches _fzf_compgen_path
      fileWidgetOptions = [
        "--preview 'bat --color=always {}'"
        "--preview-window '70%:wrap'"
        "--border-label='File Picker'"
      ];
      changeDirWidgetCommand = "fd --type d --hidden --follow --exclude .git"; # Matches _fzf_compgen_dir
      changeDirWidgetOptions = [
        "--preview 'lsd -a --tree --directory-only --color=always {}'"
        "--preview-window '70%:wrap'"
        "--border-label='Dir Jump'"
      ];
      historyWidgetOptions = [
        "--border-label='History Search'"
      ];
      colors = {
          fg = "#C6D0F5";
          "fg+" = "#C6D0F5";
          bg = "#303446";
          "bg+" = "#51576D";
          hl = "#E78284";
          "hl+" = "#E78284";
          info = "#CA9EE6";
          marker = "#BABBF1";
          prompt = "#CA9EE6";
          spinner = "#F2D5CF";
          pointer = "#F2D5CF";
          header = "#E78284";
          gutter = "#262626";
          border = "#414559";
          separator = "#4b4646";
          scrollbar = "#a22b2b";
          preview-bg = "#414559";
          preview-border = "#4b4646";
          label = "#C6D0F5";
          query = "#d9d9d9";
      };
    };

    bat = {
      enable = true;
      themes = {
        dracula = {
         src = pkgs.fetchFromGitHub {
           owner = "dracula";
           repo = "sublime"; # Bat uses sublime syntax for its themes
           rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
           sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
           };
           file = "Dracula.tmTheme";
           };
           };
    };

    starship = {
      enable = true;
      settings =
        let
          darkgray = "242";
        in
        {
          format = lib.concatStrings [
            "$username"
            "($hostname )"
            "$directory"
            "($git_branch )"
            "($git_state )"
            "($git_status )"
            "($git_metrics )"
            "($cmd_duration )"
            "$line_break"
            "($python )"
            "($nix_shell )"
            "($direnv )"
            "$character"
          ];

          directory = {
            style = "blue";
            read_only = " !";
          };

          character = {
            success_symbol = "[❯](purple)";
            error_symbol = "[❯](red)";
            vicmd_symbol = "[❮](green)";
          };

          git_branch = {
            format = "[$branch]($style)";
            style = darkgray;
          };

          git_status = {
            format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted )](218)($ahead_behind$stashed)]($style)";
            style = "cyan";
            conflicted = "​";
            untracked = "​";
            modified = "​";
            staged = "​";
            renamed = "​";
            deleted = "​";
            stashed = "≡";
          };

          git_state = {
            format = "[$state( $progress_current/$progress_total)]($style)";
            style = "dimmed";
            rebase = "rebase";
            merge = "merge";
            revert = "revert";
            cherry_pick = "pick";
            bisect = "bisect";
            am = "am";
            am_or_rebase = "am/rebase";
          };

          git_metrics.disabled = false;

          cmd_duration = {
            format = "[$duration]($style)";
            style = "yellow";
          };

          python = {
            format = "[$virtualenv]($style)";
            style = darkgray;
          };

          nix_shell = {
            format = "❄️";
            style = darkgray;
            heuristic = true;
          };

          direnv = {
            format = "[($loaded/$allowed)]($style)";
            style = darkgray;
            disabled = false;
            loaded_msg = "";
            allowed_msg = "";
          };

          username = {
            format = "[$user]($style)";
            style_root = "yellow italic";
            style_user = darkgray;
          };

          hostname = {
            format = "@[$hostname]($style)";
            style = darkgray;
          };
        };
    };

    # for nushell wrapper to pick up HM things
    bash.enable = true;
    fish.enable = true; # only for nushell completions really
    carapace = {
      enable = true;
      enableZshIntegration = true;
      };
    


    nushell = {
      enable = true;

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
