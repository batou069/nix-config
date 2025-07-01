{config, ...}: {
  programs.zsh = {
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
    localVariables = {
    };
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
      dps = "docker ps";
      dpsa = "docker ps -a";
      drfa = "'docker rm -f $(docker ps -aq)'";
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
    };
    syntaxHighlighting = {
      enable = true;
    };
    # fROM initContent:         export PATH="$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:/run/current-system/sw/bin:$PATH"
    initContent = ''
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
}
