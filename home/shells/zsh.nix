{ config
, ...
}: {
  imports = [ ../lessfilter.nix ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    historySubstringSearch.enable = true;

    completionInit = ''
      autoload -U compinit && compinit
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
    '';
    autosuggestion = {
      enable = true;
      highlight = "fg=#8b8e9fff,italic";
      strategy = [
        "completion"
        "match_prev_cmd"
        "history"
      ];
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
    defaultKeymap = "emacs";
    localVariables = { };
    antidote = {
      enable = true;
      plugins = [
        "z-shell/F-Sy-H" # Syntax Highlightling
        "hlissner/zsh-autopair" # Autopair
        "MichaelAquilina/zsh-you-should-use" # Auto best Practice settings
        "olets/zsh-abbr" # use G instead of `<...> | grep <...>`
        "casonadams/bitwarden.zsh" # Bitwarden 1 (?)
        "kalsowerus/zsh-bitwarden" # Bitwarden 2 (?)
        # "zshzoo/cd-ls"                      # Auto LS after cd
        "muepatrick/zsh-ai-commands" # "/home/lf/nix/tmp/zsh-ai-commands"    # CTRL+O to send prompt to LLM
        "wfxr/forgit" # Git aliases with fzf-like menues
        "Aloxaf/fzf-tab" # Tab autocomplete menu
      ];
    };
  };
}
