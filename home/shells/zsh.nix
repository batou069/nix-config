{ config
, pkgs
, ...
}: {
  imports = [ ../lessfilter.nix ];

  programs.sheldon = {
    enable = false;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtraFirst = ''
    '';
    # NEW NOTE December 2025: DO NOT RENAME initContent TO initExtra.
    # initExtra is deprecated, initContent is the correct attribute for this configuration.
    initContent = ''
      # Starship Manual Init (to fix path issues)
      eval "$(${pkgs.starship}/bin/starship init zsh)"

      source ${./zsh_ai_fix.zsh}

      # Keybindings for modern terminals
      bindkey "^[[3~" delete-char
      bindkey "^[OH" beginning-of-line
      bindkey "^[OF" end-of-line
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word

      # Fzf-tab configuration
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
      zstyle ':fzf-tab:*' use-fzf-default-opts yes
      zstyle ':fzf-tab:*' fzf-flags --scheme=path
      zstyle ':fzf-tab:*' switch-group ',' '.'
      zstyle ':fzf-tab:complete:*:*' fzf-preview '$HOME/.local/bin/lessfilter.sh $realpath'
    '';
    historySubstringSearch.enable = true;

    envExtra = ''
      _export_secret() {
        [[ -f "$1" ]] || return
        export "$2"="$(<"$1")"
      }

      _export_secret "${config.sops.secrets."api_keys/openai".path}" "OPENAI_API_KEY"
      _export_secret "${config.sops.secrets."api_keys/gemini".path}" "GEMINI_API_KEY"
      _export_secret "${config.sops.secrets."api_keys/gemini".path}" "GOOGLE_API_KEY"
      _export_secret "${config.sops.secrets."api_keys/openrouter".path}" "OPENROUTER_API_KEY"
      _export_secret "${config.sops.secrets."api_keys/openai".path}" "ZSH_AI_COMMANDS_OPENAI_API_KEY"
      _export_secret "${config.sops.secrets."api_keys/anthropic".path}" "ANTHROPIC_API_KEY"
      _export_secret "${config.sops.secrets.bitwarden.path}" "BW_SESSION"
      _export_secret "${config.sops.secrets.influxdb.path}" "INFLUX_TOKEN"
      _export_secret "${config.sops.secrets."api_keys/tavily".path}" "TAVILY_API_KEY"
      _export_secret "${config.sops.secrets."api_keys/brave_search".path}" "BRAVE_API_KEY"
      _export_secret "${config.sops.secrets."api_keys/github_mcp".path}" "GITHUB_TOKEN"
      _export_secret "${config.sops.secrets.github_pat.path}" "GITHUB_PERSONAL_ACCESS_TOKEN"

      GOOGLE_GENAI_USE_VERTEXAI=true
      GEMINI_DEFAULT_AUTH_TYPE="vertex-ai"

      unset -f _export_secret
    '';

    completionInit = ''
      setopt extendedglob
      autoload -U compinit
      local zcompdump="''${ZDOTDIR:-$HOME}/.zcompdump"

      if [[ -n "$zcompdump"(#qN.mh+24) ]]; then
        compinit -d "$zcompdump"
        zcompile "$zcompdump"
      else
        compinit -C -d "$zcompdump"
      fi

      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
    '';
    autosuggestion = {
      enable = true;
      highlight = "fg=#8b8e9fff,italic";
      strategy = [ "completion" "match_prev_cmd" "history" ];
    };
    zsh-abbr = {
      enable = true;
      globalAbbreviations = {
        C = "| wl-copy";
        G = "| rg";
        L = "| less -R";
      };
    };

    history = {
      append = true;
      share = true;
      # findNoDups = true;
      # saveNoDups = true;
      ignoreAllDups = true;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      # hist_verify = true;
      ignoreSpace = true;
      path = "${config.xdg.dataHome}/.zsh_history";
      size = 100000;
      save = 100000;
      extended = true;
      ignorePatterns = [ "rm *" "pkill *" "shutdown" "reboot" "ls *" "exit" "clear" ];
    };
    autocd = true;
    defaultKeymap = "emacs";
    localVariables = { };
    antidote = {
      enable = true;
      plugins = [
        "z-shell/F-Sy-H" # Syntax Highlightling
        # "hlissner/zsh-autopair" # Autopair
        "MichaelAquilina/zsh-you-should-use" # Auto best Practice settings
        # "olets/zsh-abbr" # use G instead of `<...> | grep <...>`
        # "casonadams/bitwarden.zsh" # Bitwarden 1 (?)
        # "kalsowerus/zsh-bitwarden" # Bitwarden 2 (?)
        # "zshzoo/cd-ls"                      # Auto LS after cd
        # "muepatrick/zsh-ai-commands" # "/home/lf/nix/tmp/zsh-ai-commands"    # CTRL+O to send prompt to LLM
        "wfxr/forgit" # Git aliases with fzf-like menus
      ];
    };
  };
}
