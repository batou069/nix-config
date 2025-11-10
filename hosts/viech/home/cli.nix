{ lib
, config
, pkgs
, ...
}: {
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

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      history = {
        append = true;
        share = true;
        findNoDups = true;
        saveNoDups = true;
        ignoreAllDups = true;
        ignoreDups = true;
        ignoreSpace = true;
        path = "${config.xdg.dataHome}/.zsh_history";
        size = 100000;
        save = 100000;
        extended = true;
      };
      autocd = true;
      defaultKeymap = "viins";
      localVariables = { };
      zsh-abbr.globalAbbreviations = {
        C = "| wl-copy";
        G = "| rg ";
        L = "| less -R";
      };
      shellAliases = {
        nix-update = "sudo nixos-rebuild switch --flake ~/NixOS-Hyprland#lf-nix";
        nix-build = "nixos-rebuild build --flake ~/NixOS-Hyprland#lf-nix";
        nix-gc = "nix-collect-garbage";
        nix-gcd = "nix-collect-garbage -d";
        c = "clear";
        p = "python";
        py = "python";
        e = "exit";
        btc = "curl rate.sx";
        # paths="echo -e ${PATH//:/\\n}";
        d = "docker";
        dc = "docker compose";
        dcu = "docker compose up";
        dcd = "docker compose down";
        dcud = "docker compose up -d";
        dcub = "docker compose up --build";
        dcudb = "docker compose up -d --build";
        dps = "docker ps";
        dpsa = "docker ps -a";
        drma = "'docker rm -f $(docker ps -aq)'";
        tai = "tmux attach -t ai3";
        t = "tmux";
        ld = "lazydocker";
        lg = "lazygit";
        treesize = "ncdu";
        lastmod = "find . -type f -not -path '*/\.*' -exec ls -lrt {} +";
        zf = "z '$(zoxide query -l | fzf --preview 'ls --color {}' --preview-window '70%:wrap' --border-label='Dir Jump')'";
        gv = "git grep --line-number . | fzf --delimiter : --nth 3.. --bind 'enter:become(nvim {1} +{2})' --border-label='Git Grep'";
        dfz = "docker ps -a | fzf --multi --header 'Select container' --preview 'docker inspect {1}' --preview-window '40%:wrap' --border-label='Docker Select' | awk '{print \$1}' | xargs -I {} docker start {}";
        v = "fzf --preview --border-label='File Picker' 'bat {}' --preview-window '70%:wrap' --multi --bind 'enter:become(nvim {+})'";
        mans = "man -k . | fzf --border-label='Man Pages' | awk '{print \$1}' | xargs -r man";
        ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --preview-window 'right:40%:wrap' --scheme history";
        ".." = "cd ..";
        "..." = "cd ../..";
        spf = "superfile";
      };
      syntaxHighlighting = {
        enable = true;
      };

      initContent = ''
                export PATH="$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:/run/current-system/sw/bin:$PATH"
                yt() {fabric -y "$1" --transcript}

                mkcd() { mkdir -p "$1" && cd "$1" }
                rgn() { rg --line-number --no-heading "$@" | awk -F: '{print $1 " [" $2 "]"}' | fzf --border-label 'Ripgrep Search' --delimiter ' \[' --nth 1 --preview 'bat --style=plain --color=always {1} --line-range $(({2}-5)): --highlight-line {2}' --preview-window 'right,70%,border-left' --border-label 'Ripgrep Search' --bind 'enter:become(nvim {1} +{2})' }
                rga-fzf() {
                  RG_PREFIX="rga --files-with-matches"
                  local file
                  file="$(
                      FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
                          fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
                              --phony -q "$1" \
                              --bind "change:reload:$RG_PREFIX {q}" \
                              --preview-window="70%:wrap"
                      )" &&
                echo "opening $file" &&
                xdg-open "$file"
                }


        #        eval "$(starship init zsh)"
      '';
    };

    kitty = {
      enable = true;
      font = {
        name = "Maple Mono NF";
        size = 14;
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
    };

    lsd = {
      enable = true;
      enableZshIntegration = true;
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
        "--preview"
        "bat"
        "--style=numbers"
        "--color=always"
        "--line-range"
        ":500 {}"
        "--preview-window"
        "right:70%:wrap"
        "--border-label='File Picker'"
        "--layout=reverse"
        "--border=none"
        "--info='hidden'"
        "--header=''"
        "--prompt='/ '"
        "-i"
        "--no-bold"
        "--no-hscroll"
        #   "--bind='enter:execute(nvim {})'"
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
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        prettybat
        batwatch
      ];
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
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
    #bash.enable = true;
    #fish.enable = true; # only for nushell completions really
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
