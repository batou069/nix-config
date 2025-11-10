{ config
, pkgs
, ...
}: {
  imports = [ ./lessfilter.nix ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    completionInit = ''
      autoload -U compinit && compinit
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
    '';
    autosuggestion = {
      enable = true;
      highlight = "fg=#b2b7d5ff,italic";
      strategy = [ "match_prev_cmd" "completion" "history" ];
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
      # hist_verify = true;
      ignoreSpace = true;
      path = "${config.xdg.dataHome}/.zsh_history";
      size = 100000;
      save = 100000;
      extended = true;
    };
    autocd = true;
    cdpath = [
      "${config.home.homeDirectory}/git"
      "${config.home.homeDirectory}/nix"
    ];
    dirHashes = {
      lfnix = "${config.home.homeDirectory}/nix/hosts/lf-nix";
      pkgs = "${config.home.homeDirectory}/nix/pkgs";
      nix = "${config.home.homeDirectory}/nix";
      py = "${config.home.homeDirectory}/git/py";
    };
    defaultKeymap = "viins";
    localVariables = { };
    zsh-abbr = {
      # enable = true;
      globalAbbreviations = {
        C = "| wl-copy";
        G = "| rg";
        L = "| less -R";
      };
    };
    shellAliases = {
      man = "batman";
      nhs = "nh os switch $N";
      ngc = "nix-collect-garbage";
      ngcd = "nix-collect-garbage -d";
      sw = "nh os switch";
      upd = "nh os switch --update";
      hms = "nh home switch";
      g = "git";
      c = "clear";
      p = "python";
      e = "exit";
      btc = "curl rate.sx";
      d = "docker";
      dc = "docker compose";
      dcu = "docker compose up";
      dcd = "docker compose down";
      dcud = "docker compose up -d";
      dps = "docker ps";
      dpsa = "docker ps -a";
      tai = "tmux attach -t ai3";
      t = "tmux";
      ld = "lazydocker";
      lg = "lazygit";
      # Useful fzf-based aliases
      # gv = "git grep --line-number . | fzf --delimiter : --nth 3.. --bind 'enter:become(nvim {1} +{2})' --border-label='Git Grep'";
      # dfz = "docker ps -a | fzf --multi --header 'Select container' --preview 'docker inspect {1}' --preview-window '40%:wrap' --border-label='Docker Select' | awk '{print \$1}' | xargs -I {} docker start {}";
      mans = "man -k . | fzf --border-label='Man Pages' | awk '{print \$1}' | xargs -r man";

      # Directory navigation
      "22" = "cd ../..";
      "33" = "cd ../../..";
      "44" = "cd ../../../..";
      "55" = "cd ../../../../..";
      add_secret = "nix-shell -p sops --run \"SOPS_AGE_KEY_FILE=secrets/age-key.txt sops secrets/secrets.yaml\"";
    };

    initContent = ''
      # Unset FZF_DEFAULT_OPTS to clear any stale or conflicting configurations
      unset FZF_DEFAULT_OPTS

      drfa() {docker rm -f "$(docker ps -aq)"}
      bak() { cp "$1" "$1.bak.$(date +%Y-%m-%d_%H-%M-%S)" }
      yt() {fabric -y "$1" --transcript}
      mkcd() { mkdir -p "$1" && cd "$1" }
      ytm() {ytmdl --nolocal --ignore-errors -o ~/Music/ytmdl --spotify-id  "$1" --url "$2" "$3"}
      fzf-man-widget() {
        manpage="echo {} | sed 's/\([[:alnum:][:punct:]]*\) (\([[:alnum:]]*\)).*/\2 \1/'"
        batman="''${manpage} | xargs -r man | col -bx | bat --language=man --plain --color always --theme=\"Monokai Extended\""
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
      }

        if command -v nix-your-shell > /dev/null; then
          nix-your-shell zsh | source /dev/stdin
        fi
        BASE16_SHELL="$HOME/.config/base16-shell/"
        [ -n "$PS1" ] && \
        [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"

        # FZF ZSH man page widget
        bindkey '^h' fzf-man-widget
        zle -N fzf-man-widget
        # Source fzf completions for fzf-tab, without sourcing keybindings
        # source "${pkgs.fzf}/share/fzf/completion.zsh"

        tmux-which-key() { tmux show-wk-menu-root ; }
        zle -N tmux-which-key
        # bindkey -M vicmd " " tmux-which-key
        bindkey -M emacs '^ ' tmux-which-key


        # --- FZF-Tab stuff ---
        # Inherit ALL default options (previewer, colors, layout) from the main fzf config.
        zstyle ':fzf-tab:*' use-fzf-default-opts yes

        # --- Overrides ---
        # 1. For any command, when completing an option (e.g., ls -<TAB>), disable the preview.
        zstyle ':fzf-tab:complete:*:options' fzf-preview

        # 2. For the 'kill' command, use htop as a specific previewer.
        zstyle ':fzf-tab:complete:kill:*' fzf-preview 'htop -p {1}'
    '';

    antidote = {
      enable = true;
      plugins = [
        "z-shell/F-Sy-H"
        "hlissner/zsh-autopair"
        "MichaelAquilina/zsh-you-should-use"
        "olets/zsh-abbr"
        "casonadams/bitwarden.zsh"
        "kalsowerus/zsh-bitwarden"
        # "zshzoo/cd-ls"
        "muePatrick/zsh-ai-commands"
        "wfxr/forgit"
        "Aloxaf/fzf-tab"
      ];
    };
  };
}
