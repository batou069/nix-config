{ pkgs
, lib
, ...
}:
let
  # Simple toggle to enable or disable delta features.
  enableDelta = true;

  # Inherit the delta package from the gitAndTools package set for easy access.
  inherit (pkgs.gitAndTools) delta;
in
{
  # Configure Git
  programs.git = {
    enable = true;

    # We merge the base settings with the conditional delta config.
    settings = lib.mkMerge [
      # Base Config
      {
        user = {
          name = "Laurent Flaster";
          email = "laurentf84@gmail.com";
        };

        diff.tool = "meld";
        difftool = {
          "meld".cmd = ''meld "$LOCAL" "$REMOTE"'';
          prompt = false;
        };
        credential.helper = "${pkgs.git.override {withLibsecret = true;}}/bin/git-credential-libsecret";
        alias.diffpick = "!sh -c 'git diff --name-only | fpp --no-file-checks | xargs -r git difftool'";
        aliases = {
          a = "add";
          p = "push -u origin";
          pl = "pull";
          dc = "diff --cached";
          d = "diff";
          sh = "show";
          l = "log";
          graph = "log --oneline --decorate --graph --all";
          com = "commit -m";
          st = "status";
          b = "branch";
          co = "checkout";
          cob = "checkout -b";
          mrg = "merge";
          bd = "branch -d";
          bD = "branch -D";
          undo = "reset --soft HEAD~1";
        };
        color = {
          ui = "always";
          branch = "always";
          interactive = "always";
          status = "always";
        };
        column.ui = "auto";
        commit.verbose = true;
        push = {
          autoSetupRemote = true;
          default = "simple";
        };
        rebase = {
          autosquash = true;
          autostash = true;
        };
        pager = {
          # The option name is the sub-key (e.g., log)
          log = "emojify";
        };
      }

      # Conditional Delta Config
      (lib.mkIf enableDelta {
        core.pager = "${delta}/bin/delta";
        interactive.diffFilter = "${delta}/bin/delta --color-only";
        delta = {
          features = "side-by-side line-numbers decorations";
          syntax-theme = "GitHub";
          "commit-decoration-style" = "bold yellow box ul";
          "file-decoration-style" = "none";
          "file-style" = "bold yellow ul";
        };
      })
    ];
  };

  # Conditionally add the delta package to the user's environment.
  home.packages = lib.mkIf enableDelta [ delta ];
}
