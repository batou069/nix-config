{ pkgs, ... }: {
  programs.aliae = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    settings = {
      alias = [
        # --- ALIASES (Simple) ---
        {
          name = "man";
          value = "batman";
        }
        {
          name = "l";
          value = "ls";
        }
        {
          name = "ls";
          value = "lsd";
        }
        {
          name = "man";
          value = "batman";
        }
        {
          name = "nhs";
          value = "nh os switch $N";
          "if" = "match .Shell \"(zsh|bash|fish)\"";
        }
        {
          name = "nhs";
          value = "nh os switch $env.N";
          "if" = "match .Shell \"nushell\"";
        }
        {
          name = "ncg";
          value = "nix-collect-garbage";
        }
        {
          name = "ncgd";
          value = "nix-collect-garbage -d";
        }
        {
          name = "nhos";
          value = "nh os switch";
        }
        {
          name = "nhosu";
          value = "nh os switch --update";
        }
        {
          name = "nhms";
          value = "nh home switch";
        }
        {
          name = "g";
          value = "git";
        }
        {
          name = "c";
          value = "clear";
        }
        {
          name = "p";
          value = "python";
        }
        {
          name = "e";
          value = "exit";
        }
        {
          name = "btc";
          value = "curl rate.sx";
        }
        {
          name = "d";
          value = "docker";
        }
        {
          name = "dc";
          value = "docker compose";
        }
        {
          name = "dcu";
          value = "docker compose up";
        }
        {
          name = "dcd";
          value = "docker compose down";
        }
        {
          name = "dcud";
          value = "docker compose up -d";
        }
        {
          name = "dps";
          value = "docker ps";
        }
        {
          name = "dpsa";
          value = "docker ps -a";
        }
        {
          name = "tai";
          value = "tmux attach -t ai3";
        }
        {
          name = "t";
          value = "tmux";
        }
        {
          name = "ld";
          value = "lazydocker";
        }
        {
          name = "lg";
          value = "lazygit";
        }
        {
          name = "mans";
          value = "man -k . | fzf --border-label='Man Pages' | awk '{print $1}' | xargs -r man";
        }
        # {
        #   name = "gv";
        #   type = "git";
        #   value = "git grep --line-number . | fzf --delimiter : --nth 3.. --bind 'enter:become(nvim {1} +{2})' --border-label='Git Grep'";
        # }

        # Directory navigation
        {
          name = "22";
          value = "cd ../..";
        }
        {
          name = "33";
          value = "cd ../../..";
        }
        {
          name = "44";
          value = "cd ../../../..";
        }
        {
          name = "55";
          value = "cd ../../../../..";
        }
        {
          name = "add_secret";
          value = "nix-shell -p sops --run \"SOPS_AGE_KEY_FILE=secrets/age-key.txt sops secrets/secrets.yaml\"";
        }

        # --- FUNCTIONS (Type = "function") ---
        {
          name = "mkcd";
          type = "function";
          value = "mkdir -p \"$1\" && cd \"$1\"";
        }
        {
          name = "drfa";
          type = "function";
          value = "docker rm -f \"$(docker ps -aq)\"";
        }
        {
          name = "bak";
          type = "function";
          value = "cp \"$1\" \"$1.bak.$(date +%Y-%m-%d_%H-%M-%S)\"";
        }
        {
          name = "ytm";
          type = "function";
          value = "ytmdl --nolocal --ignore-errors -o ~/Music/ytmdl --spotify-id  \"$1\" --url \"$2\" \"$3\"";
        }
        {
          name = "fzf-man-widget";
          type = "function";
          # Note: Zsh-specific function logic is wrapped here.
          value = ''
            man -k . | sort \
            | awk -v cyan=$(tput setaf 6) -v blue=$(tput setaf 4) -v res=$(tput sgr0) -v bld=$(tput bold) '{ $1=cyan bld $1; $2=res blue $2; } 1' \
            | fzf  \
                -q "$1" \
                --ansi \
                --tiebreak=begin \
                --prompt=' Man > '  \
                --preview-window '50%,rounded,<50(up,85%,border-bottom)' \
                --preview "''${batman}" \
                --bind "enter:execute(''${manpage} | xargs -r man)" \
                --bind "alt-c:+change-preview(cht.sh {1})+change-prompt(ﯽ Cheat > )" \
                --bind "alt-m:+change-preview(''${batman})+change-prompt( Man > )" \
                --bind "alt-t:+change-preview(tldr --color=always {1})+change-prompt(ﳁ TLDR > )"
            zle reset-prompt
          '';
        }
        {
          name = "fcd";
          type = "function";
          "if" = "match .Shell \"(zsh|bash)\"";
          value = ''
            local dest
            dest=$(tree -df . | fzf --height 40% --reverse)
            if [[ -n "$dest" ]]; then
              cd "$(echo "$dest" | awk '{print $NF}')"
            fi
          '';
        }
        {
          name = "fcd";
          type = "function";
          "if" = "match .Shell \"fish\"";
          value = ''
            set dest (tree -df . | fzf --height 40% --reverse)
            if test -n "$dest"
              cd "(echo "$dest" | awk '{print $NF}')"
            end
          '';
        }

        # --- Flake Inspection Functions ---
        # Usage: flake-show github:owner/repo
        {
          name = "flake-show";
          type = "function";
          "if" = "match .Shell \"(zsh|bash)\"";
          value = ''
            nix flake show "$1" 2>&1 | head -100
          '';
        }
        {
          name = "flake-show";
          type = "function";
          "if" = "match .Shell \"fish\"";
          value = ''
            nix flake show $argv[1] 2>&1 | head -100
          '';
        }
        # Usage: flake-pkgs github:owner/repo [system]
        # Lists all packages in a flake
        {
          name = "flake-pkgs";
          type = "function";
          "if" = "match .Shell \"(zsh|bash)\"";
          value = ''
            local flake="$1"
            local system="''${2:-x86_64-linux}"
            nix eval "$flake#packages.$system" --apply 'x: builtins.attrNames x' 2>&1 | tr ',' '\n' | tr -d '[]" '
          '';
        }
        {
          name = "flake-pkgs";
          type = "function";
          "if" = "match .Shell \"fish\"";
          value = ''
            set flake $argv[1]
            set system (if test (count $argv) -ge 2; echo $argv[2]; else; echo "x86_64-linux"; end)
            nix eval "$flake#packages.$system" --apply 'x: builtins.attrNames x' 2>&1 | tr ',' '\n' | tr -d '[]" '
          '';
        }
        # Usage: flake-modules github:owner/repo
        # Lists nixosModules and homeModules
        {
          name = "flake-modules";
          type = "function";
          "if" = "match .Shell \"(zsh|bash)\"";
          value = ''
            local flake="$1"
            echo "=== nixosModules ==="
            nix eval "$flake#nixosModules" --apply 'x: builtins.attrNames x' 2>&1 | tr ',' '\n' | tr -d '[]" '
            echo ""
            echo "=== homeModules / homeManagerModules ==="
            nix eval "$flake#homeModules" --apply 'x: builtins.attrNames x' 2>&1 | tr ',' '\n' | tr -d '[]" '
            nix eval "$flake#homeManagerModules" --apply 'x: builtins.attrNames x' 2>&1 | tr ',' '\n' | tr -d '[]" '
          '';
        }
        {
          name = "flake-modules";
          type = "function";
          "if" = "match .Shell \"fish\"";
          value = ''
            set flake $argv[1]
            echo "=== nixosModules ==="
            nix eval "$flake#nixosModules" --apply 'x: builtins.attrNames x' 2>&1 | tr ',' '\n' | tr -d '[]" '
            echo ""
            echo "=== homeModules / homeManagerModules ==="
            nix eval "$flake#homeModules" --apply 'x: builtins.attrNames x' 2>&1 | tr ',' '\n' | tr -d '[]" '
            nix eval "$flake#homeManagerModules" --apply 'x: builtins.attrNames x' 2>&1 | tr ',' '\n' | tr -d '[]" '
          '';
        }
        # Usage: flake-overlays github:owner/repo
        {
          name = "flake-overlays";
          type = "function";
          "if" = "match .Shell \"(zsh|bash)\"";
          value = ''
            local flake="$1"
            nix eval "$flake#overlays" --apply 'x: builtins.attrNames x' 2>&1 | tr ',' '\n' | tr -d '[]" '
          '';
        }
        {
          name = "flake-overlays";
          type = "function";
          "if" = "match .Shell \"fish\"";
          value = ''
            nix eval "$argv[1]#overlays" --apply 'x: builtins.attrNames x' 2>&1 | tr ',' '\n' | tr -d '[]" '
          '';
        }
        # Usage: flake-info github:owner/repo
        # Shows metadata about a flake
        {
          name = "flake-info";
          type = "function";
          "if" = "match .Shell \"(zsh|bash)\"";
          value = ''
            nix flake metadata "$1" 2>&1
          '';
        }
        {
          name = "flake-info";
          type = "function";
          "if" = "match .Shell \"fish\"";
          value = ''
            nix flake metadata $argv[1] 2>&1
          '';
        }
      ];
      env = [
        # --- ENVIRONMENT VARIABLES (Simple) ---
        # Personal directory shortcuts
        {
          name = "P";
          value = "$HOME/git/py";
        }
        {
          name = "C";
          value = "$HOME/.config";
        }
        {
          name = "G";
          value = "$HOME/git";
        }
        {
          name = "R";
          value = "$HOME/repos";
        }
        {
          name = "O";
          value = "$HOME/Obsidian";
        }
        {
          name = "D";
          value = "$HOME/dotfiles";
        }
        {
          name = "N";
          value = "$HOME/nix";
        }
        {
          name = "D";
          value = "$HOME/Downloads";
        }

        # Personal application preferences
        {
          name = "TERM";
          value = "xterm-kitty";
        }
        {
          name = "VISUAL";
          value = "nvim";
        }
        {
          name = "EDITOR";
          value = "nvim";
        }
        {
          name = "PAGER";
          value = "less";
        }
        {
          name = "LESS";
          value = "-R";
        }

        {
          name = "FZF_DEFAULT_COMMAND";
          value = "fd --type f --hidden --follow --exclude .git";
        }
        {
          name = "FZF_CTRL_T_COMMAND";
          value = "fd --type f --hidden --follow --exclude .git";
        }
        {
          name = "FZF_DEFAULT_OPTS";
          delimiter = " ";
          value = [
            # --- PREVIEW ---
            "--preview '{{ .Home }}/.local/bin/lessfilter.sh {}'"
            "--preview-window 'right:60%:wrap'"
            "--bind '?:toggle-preview'"
            "--bind 'ctrl-/:change-preview-window(60%|30%|hidden|)'"

            # --- APPEARANCE ---
            "--height=50%"
            "--layout=reverse"
            "--border rounded"
            "--border-label='╢ FZF ╟'"
            "--prompt=' '"
            "--pointer='▶'"
            "--marker=''"
            "--info=inline"
            "--ghost='Search ...'"
            "--color preview-fg:#ddc8c8"

            # --- MARGINS ---
            # Note: Quotes are tricky here, we use simple strings
            "padding='10%,0%,0%,0%'"
            "margin='10%,30%,0%,0%'"

            # --- BEHAVIOR ---
            "--multi"
            "--cycle"
            "--bind 'ctrl-a:select-all'"

            # --- ACTIONS ---
            # Note: referencing system 'fd' and 'nvim' directly
            "--bind 'ctrl-r:reload(fd --type f --hidden --follow --exclude .git)'"
            "--bind 'ctrl-k:kill-line'"
            "--bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'"

            # --- CLIPBOARD ---
            # Note: {+} passes all selected files
            "--bind 'ctrl-y:execute-silent(echo {+} | wl-copy)'"
          ];
        }
        # Secrets (Using the same shell command substitution from your config)
        # { name = "OPENAI_API_KEY"; value = "$(cat /run/secrets/api_keys/openai 2>/dev/null || echo '')"; }
        # {
        #   name = "GEMINI_API_KEY";
        #   value = "$(cat /run/secrets/api_keys/gemini 2>/dev/null || echo '')";
        # }
        # {
        #   name = "GOOGLE_API_KEY";
        #   value = "$(cat /run/secrets/api_keys/gemini 2>/dev/null || echo '')";
        # }
        # {
        #   name = "ZSH_AI_COMMANDS_OPENAI_API_KEY";
        #   value = "$(cat /run/secrets/api_keys/openai 2>/dev/null || echo '')";
        # }
        # {
        #   name = "ANTHROPIC_API_KEY";
        #   value = "$(cat /run/secrets/api_keys/anthropic 2>/dev/null || echo '')";
        # }
        # {
        #   name = "BW_SESSION";
        #   value = "$(cat /run/secrets/bitwarden 2>/dev/null || echo '')";
        # }
        # {
        #   name = "INFLUX_TOKEN";
        #   value = "$(cat /run/secrets/influxdb 2>/dev/null || echo '')";
        # }
        # # Keys for MCP Servers
        # {
        #   name = "TAVILY_API_KEY";
        #   value = "$(cat /run/secrets/api_keys/tavily 2>/dev/null || echo '')";
        # }
        # {
        #   name = "BRAVE_API_KEY";
        #   value = "$(cat /run/secrets/api_keys/brave_search 2>/dev/null || echo '')";
        # }
        # {
        #   name = "GITHUB_TOKEN";
        #   value = "$(cat /run/secrets/api_keys/github_mcp 2>/dev/null || echo '')";
        # }

        # Theming and shell appearance
        {
          name = "BASE16_SHELL";
          value = "$HOME/.config/base16-shell";
        }
        {
          name = "TERM_ITALICS";
          value = "true";
        }
        {
          name = "BAT_THEME";
          value = "base16";
        }
        {
          name = "BASE16_SHELL";
          value = "$HOME/.config/base16-shell/";
        }
        {
          name = "LESSOPEN";
          value = "|{{ .Home }}/.local/bin/lessfilter.sh %s";
        }
        {
          name = "LESS";
          value = "-R";
        }
        {
          name = "FZF_DEFAULT_OPTS";
          value = "--ansi";
        }

        # --- Directory Navigation & Base Configs ---
        # Transforming your Nix 'cdpath' to a standard env var
        {
          name = "CDPATH";
          value = ". {{ .Home }}/git {{ .Home }}/nix";
          delimiter = " ";
          # Automatically joins the array with spaces
        }
        # Dynamic LS_COLORS (executed by the shell at runtime)
        {
          name = "LS_COLORS";
          value = "$(vivid generate molokai)";
          "if" = "hasCommand \"vivid\"";
        }
      ];
      path = [
        {
          value = "{{ .Home }}/.local/bin";
          force = true;
        }
      ];

      script = [
        {
          "if" = "match .Shell \"zsh\"";
          value = ''
            zmodload zsh/zprof

            # --- Directory Hashes (Specific to Zsh) ---
            hash -d nhl={{ .Home }}/nix/hosts/lf-nix
            hash -d nh={{ .Home }}/nix/home
            hash -d n={{ .Home }}/nix
            hash -d gp={{ .Home }}/git/py

            # --- Base16 Shell ---
            [ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && source "$BASE16_SHELL/profile_helper.sh"

            # --- Keybindings ---
            # Note: We must ensure the widget is defined before binding.
            # Aliae loads aliases/functions, so 'fzf-man-widget' is already defined above.
            zle -N fzf-man-widget
            bindkey '^h' fzf-man-widget

            # Edit command line
            autoload -z edit-command-line
            zle -N edit-command-line
            bindkey "^v" edit-command-line

            # Source fzf completions for fzf-tab, without sourcing keybindings
            # source "${pkgs.fzf}/share/fzf/completion.zsh"

            # Tmux Which Key
            tmux-which-key() { tmux show-wk-menu-root ; }
            zle -N tmux-which-key
            bindkey -M emacs '^ ' tmux-which-key
            # bindkey -M vicmd " " tmux-which-key

            # Navigation
            bindkey '^[[1;5C' forward-word
            bindkey '^[[1;5D' backward-word

            # --- FZF Tab Styles ---
            zstyle ':fzf-tab:*' use-fzf-default-opts yes
            zstyle ':fzf-tab:complete:*:options' fzf-preview
            zstyle ':fzf-tab:complete:kill:*' fzf-preview 'htop -p {1}'

            # --- Global Aliases (Zsh Specific) ---
            # Aliae standard aliases are command-position only.
            # For global pipes, we define them here manually or in Home-Manager

            # zsh-abbr = {
            #       # enable = true;
            #       globalAbbreviations = {
            #         C = "| wl-copy";
            #         G = "| rg";
            #         L = "| less -R";
            #       };
            #     };

            # We assume zsh-abbr is loaded via Home Manager.
            # # We just add the standard Directory Hashes here.
            # hash -d nhl={{ .Home }}/nix/hosts/lf-nix
            # hash -d nh={{ .Home }}/nix/home
            # hash -d n={{ .Home }}/nix


            zprof
          '';
        }
        {
          "if" = "match .Shell \"fish\"";
          value = ''
                # Set theme (Fish specific)
            fish_config theme choose "Gruvbox"

            # Directory abbreviations
            abbr --add 22 "cd ../.."
            abbr --add 33 "cd ../../.."
            abbr --add 44 "cd ../../../.."
            abbr --add 55 "cd ../../../../.."

            # Command abbreviations (Expands when you type space!)
            abbr --add g git
            abbr --add d docker
            abbr --add t tmux
            abbr --add v vim
            abbr --add dc "docker compose"
            abbr --add nhs "nh os switch"

            # GLOBAL Abbreviations (The Fish equivalent of Zsh global aliases)
            # Type 'command | L' and it expands to 'command | less -R'
            abbr --add --position anywhere C "| wl-copy"
            abbr --add --position anywhere G "| rg"
            abbr --add --position anywhere L "| less -R"
          '';
        }
        {
          "if" = "match .Shell \"xonsh\"";
          value = ''
            # Xonsh uses a python dictionary for abbreviations
            abbrevs['g'] = 'git'
            abbrevs['d'] = 'docker'
            abbrevs['t'] = 'tmux'
            abbrevs['dc'] = 'docker compose'
            abbrevs['nhs'] = 'nh os switch'

            # Xonsh doesn't support global abbrevs identically,
            # but supports python logic.
          '';
        }
      ];
    };
  };
}
