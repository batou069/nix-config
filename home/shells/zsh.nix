{ config, ... }: {
  imports = [ ../lessfilter.nix ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    historySubstringSearch.enable = true;

    envExtra = ''
      _export_secret() {
        local val="$(cat "$1" 2>/dev/null)"
        if [ -n "$val" ]; then
          export "$2"="$val"
        fi
      }

      _export_secret "${config.sops.secrets."api_keys/openai".path}" "OPENAI_API_KEY"
      _export_secret "${config.sops.secrets."api_keys/gemini".path}" "GEMINI_API_KEY"
      _export_secret "${config.sops.secrets."api_keys/gemini".path}" "GOOGLE_API_KEY"
      _export_secret "${config.sops.secrets."api_keys/openai".path}" "ZSH_AI_COMMANDS_OPENAI_API_KEY"
      _export_secret "${config.sops.secrets."api_keys/anthropic".path}" "ANTHROPIC_API_KEY"
      _export_secret "${config.sops.secrets.bitwarden.path}" "BW_SESSION"
      _export_secret "${config.sops.secrets.influxdb.path}" "INFLUX_TOKEN"
      _export_secret "${config.sops.secrets."api_keys/tavily".path}" "TAVILY_API_KEY"
      _export_secret "${config.sops.secrets."api_keys/brave_search".path}" "BRAVE_API_KEY"
      _export_secret "${config.sops.secrets."api_keys/github_mcp".path}" "GITHUB_TOKEN"
      _export_secret "${config.sops.secrets.github_pat.path}" "GITHUB_PERSONAL_ACCESS_TOKEN"

      unset -f _export_secret
    '';

    completionInit = ''
      autoload -U compinit && compinit
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
        "muepatrick/zsh-ai-commands" # "/home/lf/nix/tmp/zsh-ai-commands"    # CTRL+O to send prompt to LLM
        "wfxr/forgit" # Git aliases with fzf-like menues
        "Aloxaf/fzf-tab" # Tab autocomplete menu
      ];
    };
  };
}
