{
  pkgs, 
  ...
}:{
  programs.fzf = {
    enable = true;
    package = pkgs.fzf;
    enableZshIntegration = true;
    enableFishIntegration = true;
    defaultCommand = "fd --type f --hidden --follow --exclude .git"; # Matches _fzf_compgen_path
    defaultOptions = [
      "--preview='bat --style=numbers --color=always --line-range :500 {}'"
      "--preview-window 'right:70%:wrap'"
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

  # home.packages = with pkgs; [
  #   zinit # For managing fzf-tab and fzf-zsh-plugin
  # ];

  # # Manage custom fzf configurations in ~/.config/zsh/fzf.zsh
  # home.file.".config/zsh/fzf.zsh".text = ''
  #   # fzf-tab Zsh plugin
  #   source ${pkgs.fetchFromGitHub {
  #     owner = "Aloxaf";
  #     repo = "fzf-tab";
  #     rev = "v1.1.2"; # Pin to a specific version
  #     sha256 = "sha256-9p2B4eO8uV6j6gUqIuG4gN6P4I24Y3o1L4e6V4Vq8I=";
  #   }}/fzf-tab.zsh

  #   # unixorn/fzf-zsh-plugin
  #   source ${pkgs.fetchFromGitHub {
  #     owner = "unixorn";
  #     repo = "fzf-zsh-plugin";
  #     rev = "v1.0.0"; # Pin to a specific version
  #     sha256 = "sha256-0gP1K9P+9z9z9z9z9z9z9z9z9z9z9z9z9z9z9z9z9z="; # Replace with actual hash
  #   }}/fzf-zsh-plugin.zsh

  #   # fzf-tab zstyle configurations
  #   zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'lsd -a --color=always $realpath'
  #   zstyle ':fzf-tab:*' fzf-bindings 'space:accept'
  #   zstyle ':fzf-tab:*' print-query ctrl-c
  #   zstyle ':fzf-tab:*' single-group color header
  #   zstyle ':fzf-tab:complete:(cat|nvim|cp|rm|bat):*' fzf-preview 'bat --color=always -- "$realpath" 2>/dev/null || lsd -a --color=always -- "$realpath"'
  #   zstyle ':fzf-tab:complete:nvim:*' fzf-flags --preview-window=right:65%
  #   zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
  #   zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

  #   # Aliases
  #   alias zf='z "$(zoxide query -l | fzf --preview "ls --color {}" --preview-window "70%:wrap" --border-label="Dir Jump")"'
  #   alias gv="git grep --line-number . | fzf --delimiter : --nth 3.. --bind 'enter:become(nvim {1} +{2})' --border-label='Git Grep'"
  #   alias dfz='docker ps -a | fzf --multi --header "Select container" --preview "docker inspect {1}" --preview-window "40%:wrap" --border-label="Docker Select" | awk "{print \$1}" | xargs -I {} docker start {}'
  #   alias of='fd .md $HOME/Obsidian/ | sed "s|$HOME/Obsidian/||" | fzf --preview "bat --color=always $HOME/Obsidian/{1}" --preview-window "50%:wrap" --border-label="Obsidian Files" --bind "enter:become(nvim $HOME/Obsidian/{1})"'
  #   alias rgf='rg --line-number --no-heading . | fzf --delimiter : --preview "bat --color=always {1} --highlight-line {2}" --preview-window "70%:wrap" --border-label="Ripgrep Files" --bind "enter:become(nvim {1} +{2})"'
  #   alias v='fzf --preview --border-label="Open in Vim" "bat --color always {}" --preview-window "70%:wrap" --multi --bind "enter:become(vim {+})"'
  #   alias mans='man -k . | fzf --border-label="Man Pages" | awk "{print \$1}" | xargs -r man'

  #   # Functions
  #   _fzf_compgen_path() {
  #     fd --hidden --follow --exclude ".git" . "$1"
  #   }

  #   _fzf_compgen_dir() {
  #     fd --type d --hidden --follow --exclude ".git" . "$1"
  #   }

  #   rga-fzf() {
  #     RG_PREFIX="rga --files-with-matches"
  #     local file
  #     file="$(
  #       FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
  #         fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
  #           --phony -q "$1" \
  #           --bind "change:reload:$RG_PREFIX {q}" \
  #           --preview-window="70%:wrap"
  #     )" &&
  #     echo "opening $file" &&
  #     xdg-open "$file"
  #   }

  #   _fzf_docker_select_container() {
  #     docker ps --format "{{.Names}}" | fzf --height=20% --layout=reverse --prompt="Select Container > "
  #   }

  #   dfd() {
  #     local container
  #     container=$(_fzf_docker_select_container)
  #     [ -z "$container" ] && return 1
  #     local finder_cmd="fd . /"
  #     docker exec "$container" which fd >/dev/null 2>&1 || finder_cmd="find / -mindepth 1"
  #     local previewer_cmd="bat --color=always --plain {}"
  #     docker exec "$container" which bat >/dev/null 2>&1 || previewer_cmd="cat {}"
  #     docker exec "$container" sh -c "$finder_cmd 2>/dev/null" | fzf \
  #       --prompt "Finding files in '$container' > " \
  #       --preview "docker exec '$container' sh -c \"$previewer_cmd\"" \
  #       --preview-window "right:60%:wrap"
  #   }

  #   drg() {
  #     if [ -z "$1" ]; then
  #       echo "Usage: drg <search_pattern>"
  #       return 1
  #     fi
  #     local container
  #     container=$(_fzf_docker_select_container)
  #     [ -z "$container" ] && return 1
  #     local searcher_cmd="rg --line-number --no-heading --color=always '$1' /"
  #     docker exec "$container" which rg >/dev/null 2>&1 || searcher_cmd="grep -I -RHn '$1' /"
  #     local previewer_cmd="bat --color=always --highlight-line {2} {1}"
  #     docker exec "$container" which bat >/dev/null 2>&1 || previewer_cmd="cat {1}"
  #     docker exec "$container" sh -c "$searcher_cmd 2>/dev/null" | fzf \
  #       --prompt "Searching for '$1' in '$container' > " \
  #       --delimiter ":" \
  #       --preview "docker exec '$container' sh -c \"$previewer_cmd\"" \
  #       --preview-window "right:60%:wrap"
  #   }

  #   dfx() {
  #     local container
  #     container=$(_fzf_docker_select_container)
  #     [ -z "$container" ] && return 1
  #     local finder_cmd="fd --extension json --extension yml --extension yaml . /"
  #     docker exec "$container" which fd >/dev/null 2>&1 || finder_cmd="find / -mindepth 1 -name '*.json' -o -name '*.yml' -o -name '*.yaml'"
  #     docker exec "$container" sh -c "$finder_cmd 2>/dev/null" | fzf \
  #       --prompt "Select a JSON/YAML file in '$container' > " \
  #       --bind "enter:become(docker exec '$container' cat {} | fx)"
  #   }

  #   dsh() {
  #     local container
  #     container=$(_fzf_docker_select_container)
  #     [ -z "$container" ] && return 1
  #     local rootfs
  #     rootfs=$(docker inspect -f '{{.GraphDriver.Data.MergedDir}}' "$container")
  #     if [ -z "$rootfs" ]; then
  #       echo "Error: Could not find root filesystem for container '$container'." >&2
  #       return 1
  #     fi
  #     local pid
  #     pid=$(docker inspect -f '{{.State.Pid}}' "$container")
  #     sudo nsenter -t "$pid" -n --wd="$rootfs" chroot "$rootfs" "$SHELL"
  #     echo "Exited container '$container'."
  #   }
  # '';
}
