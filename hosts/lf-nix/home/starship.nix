{lib, ...}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    settings = let
      darkgray = "242";
    in {
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
}
