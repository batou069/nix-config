{ pkgs
, lib
, ...
}:
let
  # Simple toggle to enable or disable delta features.
  enableDelta = true;

  # Inherit the delta package from the gitAndTools package set for easy access.
  inherit (pkgs) delta;
in
{
  # Configure Git
  programs.git = {
    enable = true;
    package = pkgs.git;

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
          diff = true;
        };
        column.ui = "auto";
        commit.verbose = true;
        push = {
          autoSetupRemote = true;
          default = "simple";
        };
        pull = {
          ff = "only";
          rebase = false;
          autostash = true;
        };
        init.defaultBranch = "main";
        merge.conflictstyle = "diff3";
        fetch.prune = true;
        rebase = {
          autosquash = true;
          autostash = true;
        };
        pager = {
          # The option name is the sub-key (e.g., log)
          log = "emojify";
        };
        core = {
          quotePath = false;
          ignorecase = false;
          autocrlf = false;
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

  # programs.lazygit = {
  #   enable = true;
  #   settings = {
  #     gui = {
  #       language = "en";
  #       nerdFontsVersion = "3";
  #       sidePanelWidth = 0.30;
  #       expandFocusedSidePanel = true;
  #       commitLogSize = 2;
  #       showUntrackedFiles = true;
  #       authorColors = {"*" = "#b7bdf8";};
  #       theme = {
  #         lightTheme = true;
  #         activeBorderColor = ["#f5a97f" "bold"];
  #         inactiveBorderColor = ["#494d64"];
  #         optionsTextColor = ["#8aadf4"];
  #         selectedLineBgColor = ["#363a4f"];
  #         cherryPickedCommitBgColor = ["#363a4f"];
  #         cherryPickedCommitFgColor = ["#cad3f5"];
  #         unstagedChangesColor = ["#ed8796"];
  #         defaultFgColor = ["#cad3f5"];
  #         searchingActiveBorderColor = ["#eed49f"];
  #       };
  #     };
  #     git.pagers = [
  #       {
  #         pager = "delta --paging=never";
  #       }
  #     ];
  #   };
  # };

  # Conditionally add the delta package to the user's environment.
  home.packages = lib.mkIf enableDelta [ delta ];
}
