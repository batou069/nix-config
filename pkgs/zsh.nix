{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
      highlight = "fg=#ff00ff,bg=cyan,bold,underline";
      strategy = [
        "match_prev_cmd"
        "completion"
        "history"
      ];
    };
          historySubstringSearch = {
        enable = true;
      };

    history = {
      append = true;
      share = true;
      # findNoDups = true;
      # saveNoDups = true;
      # ignoreAllDups = true;
      # ignoreDups = true;
      ignoreSpace = true;
      path = "${config.xdg.dataHome}/.zsh_history";
      size = 100000;
      save = 100000;
      extended = true;
    };
    autocd = true;
    defaultKeymap = "viins";
    localVariables = {
    };
    zsh-abbr = {
      enable = true;
      globalAbbreviations = {
        C = "| wl-copy";
        G = "| rg ";
        L = "| less -R";
      };
    };
    shellAliases = {
      nhs = "nh os switch $N";
      nix-gc = "nix-collect-garbage";
      nix-gcd = "nix-collect-garbage -d";
      sw = "nh os switch";
      upd = "nh os switch --update";
      hms = "nh home switch";
      g = "git";
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
      dps = "docker ps";
      dpsa = "docker ps -a";
      drfa = "'docker rm -f $(docker ps -aq)'";
      tai = "tmux attach -t ai3";
      t = "tmux";
      ld = "lazydocker";
      lg = "lazygit";
      treesize = "ncdu";
      lastmod = "find . -type f -not -path '*/\.*' -exec ls -lrt {} +";
      deadnix = "nix run github:astro/deadnix";
      "-" = "cd -";

      # zf = "z '$(zoxide query -l | fzf --preview 'ls --color {}' --preview-window '70%:wrap' --border-label='Dir Jump')'";
      # gv = "git grep --line-number . | fzf --delimiter : --nth 3.. --bind 'enter:become(nvim {1} +{2})' --border-label='Git Grep'";
      # dfz = "docker ps -a | fzf --multi --header 'Select container' --preview 'docker inspect {1}' --preview-window '40%:wrap' --border-label='Docker Select' | awk '{print \$1}' | xargs -I {} docker start {}";
      # v = "fzf --preview --border-label='File Picker' 'bat {}' --preview-window '70%:wrap' --multi --bind 'enter:become(nvim {+})'";
      # mans = "man -k . | fzf --border-label='Man Pages' | awk '{print \$1}' | xargs -r man";
      # ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --preview-window 'right:40%:wrap' --scheme history";
      # manx = "manix '' | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview='manix '{}'' | xargs manix";
      ".." = "cd ..";
      "..." = "cd ../..";
    };
    # syntaxHighlighting = {
    #   enable = true;
    #   highlighters = [
    #     "main"
    #     "brackets"
    #     "pattern"
    #     "cursor"
    #   ];
    # };

    #. ${pkgs.fzf}/share/fzf/completion.zsh
    initContent = ''
                    bak() { cp "$1" "$1.bak.$(date +%Y-%m-%d_%H-%M-%S)" }
                    yt() {fabric -y "$1" --transcript}
                    if command -v nix-your-shell > /dev/null; then
                      nix-your-shell zsh | source /dev/stdin
                    fi

                    mkcd() { mkdir -p "$1" && cd "$1" }
                    rga() {
                      # 1. Find the root of the git repository. This ensures all paths are consistent.
                      local git_root
                      git_root=$(git rev-parse --show-toplevel 2>/dev/null)
                      if [[ -z "$git_root" ]]; then
                        echo "Error: Not in a git repository." >&2
                        return 1
                      fi

                      # 2. Define the command to find files.
                      #    - We add `--color=never` to fix the garbled output with [@m[35m...
                      local RG_PREFIX="rga --files-with-matches --color=never"
                      local file

                      # 3. Run fzf from within the git root directory using a subshell `(...)`.
                      #    This prevents the function from changing your current directory.
                      file=$(
                        (
                          cd "$git_root" && \
                          FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
                              fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
                                  --phony -q "$1" \
                                  --bind "change:reload:$RG_PREFIX {q}" \
                                  --preview-window="70%:wrap"
                        )
                      )

                      # 4. If a file was selected, open it using its full, absolute path.
                      if [[ -n "$file" ]]; then
                        echo "opening $git_root/$file" &&
                        xdg-open "$git_root/$file"
                      fi
                    }

                    [[ -f /run/secrets/api_keys/openai ]] && export OPENAI_API_KEY="$(cat /run/secrets/api_keys/openai)"
                    [[ -f /run/secrets/api_keys/gemini ]] && export GEMINI_API_KEY="$(cat /run/secrets/api_keys/gemini)"
                    [[ -f /run/secrets/api_keys/anthropic ]] && export ANTHROPIC_API_KEY="$(cat /run/secrets/api_keys/anthropic)"
            #        eval "$(starship init zsh)"
            # Base16 Shell
      BASE16_SHELL="$HOME/.config/base16-shell/"
      [ -n "$PS1" ] && \
          [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
              source "$BASE16_SHELL/profile_helper.sh"

      # base16_default
      autoload -U compinit; compinit
      source ~/repos/fzf-tab/fzf-tab.plugin.zsh
    '';
    plugins = [
      {
        name = "zsh-fzf-tab";
        src = pkgs.zsh-fzf-tab;
      }
      # {
      #   name = "zsh-fzf-history-search";
      #   src = pkgs.zsh-fzf-history-search;
      # }
      {
        # name = "zsh-fast-syntax-highlighting";
        # src = pkgs.zsh-fast-syntax-highlighting;
        name = "zsh-f-sy-h";
        src = pkgs.zsh-f-sy-h;
      }
      {
        name = "zsh-autopair";
        src = pkgs.zsh-autopair;
      }
      {
        name = "zsh-you-should-use";
        src = pkgs.zsh-you-should-use;
      }
      {
        name = "zsh-history-to-fish";
        src = pkgs.zsh-history-to-fish;
      }
      {
        name = "zsh-forgit";
        src = pkgs.zsh-forgit;
      }
    ];
  };
}
