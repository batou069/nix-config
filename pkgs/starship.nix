{ lib, ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableTransience = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    settings =
      let
        darkgray = "242";
        flamingo = "#f2cdcd";
        mauve = "#cba6f7";
        red = "#f38ba8";
        maroon = "#eba0ac";
        peach = "#fab387";
        green = "#a6e3a1";
        teal = "#94e2d5";
        sky = "#89dceb";
      in
      {
        scan_timeout = 30;
        add_newline = true;
        command_timeout = 300;
        continuation_prompt = "[∙ ∙ ∙ ](Subtext1) ";
        format = lib.concatStrings [
          "$username"
          "$os"
          " in "
          "$directory"
          "$character"
        ];
        right_format = lib.concatStrings [
          "$git_branch"
          "$git_status"
          "$git_state"
          "$git_metrics"
          " "
          "$cmd_duration"
        ];

        directory = {
          format = "[$path]($style)[$read_only]($read_only_style) ";
          home_symbol = " ";
          # style = "blue";
          style = "bold ${peach}";
          truncate_to_repo = true;
          truncation_length = 3;
          truncation_symbol = "";
          repo_root_format = "[$before_root_path]($style)[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) ";
          # read_only = " !";
          # read_only = "";
          read_only = " ";
          read_only_style = "bold ${sky}";
          use_logical_path = true;
          use_os_path_sep = true;
          substitutions = {
            "Documents" = "󱔗 ";
            "Downloads" = " ";
            "Music" = " ";
            "Pictures" = " ";
            "nix" = " ";
            "git" = " ";
            "config" = "  ";
            ".config" = "  ";
            "repos" = "󰳏 ";
          };
        };

        # ❮❯  󰳆 ≡ 󱚟

        character = {
          success_symbol = "[](peach)";
          error_symbol = "[#](red)";
          vicmd_symbol = "[](Subtext1)";
        };

        git_branch = {
          format = "[$branch]($style) ";
          # style = darkgray;
          symbol = " ";
          style = "${teal}";
        };

        git_status = {
          ahead = " ";
          behind = " ";
          deleted = "x ";
          diverged = " ";
          style = "text";
          format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted )](218)($ahead_behind$stashed)]($style) ";
          conflicted = "󱚠";
          untracked = "";
          modified = "";
          staged = "󰆨";
          renamed = "";
          stashed = "󰈚";
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

        sudo = {
          disabled = false;
        };

        git_metrics = {
          disabled = false;
          added_style = "bold ${green}";
          format = "[+$added]($added_style)/[-$deleted]($deleted_style)";
        };

        cmd_duration = {
          # format = "[$duration]($style)";
          #        style = "yellow";
          disabled = true;
          style = "bold ${flamingo}";
          format = "󱎫 [$duration]($style)";
          show_milliseconds = true;
          show_notifications = true;
          min_time_to_notify = 999999; # 30000;
        };

        python = {
          symbol = "🐍 ";
          style = darkgray;
          format = "[$symbol$pyenv_prefix($version )(($virtualenv) )]($style)";
          python_binary = [
            "python"
            "python3"
            "python2"
          ];
          # pyenv_prefix = "pyenv ";
          pyenv_version_name = true;
          version_format = "v$raw";
          disabled = false;
          detect_extensions = [ "py" ];
          detect_files = [
            "requirements.txt"
            ".python-version"
            "pyproject.toml"
            "Pipfile"
            "tox.ini"
            "setup.py"
            "__init__.py"
          ];
          detect_folders = [ ];
        };

        nix_shell = {
          format = "[$symbol($version )]($style)";
          symbol = "❄️ ";
          style = darkgray;
          heuristic = true;
          #        format = "via [$symbol(($name))]($style)";
        };

        direnv = {
          format = "[($loaded/$allowed)]($style)";
          style = darkgray;
          disabled = false;
          loaded_msg = "direnv...";
          allowed_msg = "";
        };

        username = {
          format = "󰔁 [$user]($style)";
          show_always = true;
          style_root = "bold ${red}";
          style_user = "bold ${mauve}";
        };

        hostname = {
          format = "@[$hostname]($style) in";
          disabled = false;
          ssh_only = true;
          style = "bold ${maroon}";
          ssh_symbol = " ";
        };

        battery = {
          charging_symbol = "󰂄 ";
          discharging_symbol = "󱊢 ";
          empty_symbol = "󰂎 ";
          full_symbol = "󱊣 ";
          unknown_symbol = "󱃌 ";
          display = [
            {
              # 0% to 15%
              style = "bold ${red}";
              threshold = 15;
            }
            {
              # 15% to 50%
              style = "bold ${peach}";
              threshold = 50;
            }
            {
              # 50% to 90%
              style = "bold ${green}";
              threshold = 90;
            }
          ];
        };

        status = {
          disabled = false;
          format = "[\[$symbol$status_common_meaning$status_signal_name$status_maybe_int\ = {($style)";
          map_symbol = true;
          pipestatus = true;
          symbol = "✖";
          not_executable_symbol = "";
          not_found_symbol = "";
          sigint_symbol = "󰟾";
          signal_symbol = "";
        };

        os = {
          disabled = false;
          format = " [$symbol]($style)";
          style = "bold ${mauve}";
        };
        #	character = {
        #	error_symbol = "";
        #	success_symbol = "❯(bold green)";
        #	};
        # SYMBOLS
        git_commit = {
          tag_symbol = "  ";
        };
        golang = {
          symbol = " ";
        };
        guix_shell = {
          symbol = " ";
        };
        haskell = {
          symbol = " ";
        };
        haxe = {
          symbol = " ";
        };
        hg_branch = {
          symbol = " ";
        };
        java = {
          symbol = " ";
        };
        julia = {
          symbol = " ";
        };
        kotlin = {
          symbol = " ";
        };
        lua = {
          symbol = " ";
        };
        memory_usage = {
          symbol = "󰍛 ";
        };
        meson = {
          symbol = "󰔷 ";
        };
        nim = {
          symbol = "󰆥 ";
        };
        nodejs = {
          symbol = " ";
        };
        ocaml = {
          symbol = " ";
        };
        os.symbols = {
          Alpaquita = " ";
          Alpine = " ";
          AlmaLinux = " ";
          Amazon = " ";
          Android = " ";
          Arch = " ";
          Artix = " ";
          CentOS = " ";
          Debian = " ";
          DragonFly = " ";
          Emscripten = " ";
          EndeavourOS = " ";
          Fedora = " ";
          FreeBSD = " ";
          Garuda = "󰛓 ";
          Gentoo = " ";
          HardenedBSD = "󰞌 ";
          Illumos = "󰈸 ";
          Kali = " ";
          Linux = " ";
          Mabox = " ";
          Macos = " ";
          Manjaro = " ";
          Mariner = " ";
          MidnightBSD = " ";
          Mint = " ";
          NetBSD = " ";
          NixOS = " ";
          OpenBSD = "󰈺 ";
          openSUSE = " ";
          OracleLinux = "󰌷 ";
          Pop = " ";
          Raspbian = " ";
          Redhat = " ";
          RedHatEnterprise = " ";
          RockyLinux = " ";
          Redox = "󰀘 ";
          Solus = "󰠳 ";
          SUSE = " ";
          Ubuntu = " ";
          Unknown = " ";
          Void = " ";
          Windows = "󰍲 ";
        };

        package = {
          symbol = "󰏗 ";
        };
        perl = {
          symbol = " ";
        };
        php = {
          symbol = " ";
        };
        pijul_channel = {
          symbol = " ";
        };
        # python = {
        # symbol = " ";
        # };
        rlang = {
          symbol = "󰟔 ";
        };
        ruby = {
          symbol = " ";
        };
        rust = {
          symbol = "󱘗 ";
        };
        scala = {
          symbol = " ";
        };
        swift = {
          symbol = " ";
        };
        zig = {
          symbol = " ";
        };
        gradle = {
          symbol = " ";
        };
      };
  };
}
