{
  pkgs,
  ...
}: {
  # Configure Git
  programs.git = {
    enable = true;
    userName = "Laurent Flaster";
    userEmail = "laurentf84@gmail.com";
    extraConfig = {
      # Configure Meld as the default diff tool
      diff = {
        tool = "meld";
      };
      difftool = {
        meld = {
          cmd = ''meld "$LOCAL" "$REMOTE"'';
        };
        prompt = false;
      };
      credential.helper = "${
        pkgs.git.override { withLibsecret = true; }
      }/bin/git-credential-libsecret";

      # Create a Git alias to use PathPicker with difftool
      alias = {
        diffpick = "!sh -c 'git diff --name-only | fpp --no-file-checks | xargs -r git difftool'";
      };
      core = {
        pager = "delta";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
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
          b ="branch";
          co = "checkout";
          cob = "checkout -b";
          mrg = "merge";
          bd = "branch -d";
          bD = "branch -D";
          # gu = "git reset HEAD --mixed";
        };
    color = {
      ui = "always";
      branch = "always";
      interactive = "always";
      status = "always";
    };
    column = {
      ui = "auto";
    };
    commit = {
      verbose = true;
    };
    push = {
      autoSetupRemote = true;
      default = "simple";
    };
    rebase = {
      autosquash = true;
      autostash = true;
    };
    delta = {
      features = "side-by-side line-numbers decorations";
      syntax-theme = "GitHub";
      "commit-decoration-style" = "bold yellow box ul";
      "file-decoration-style" = "none";
      "file-style" = "bold yellow ul";
    };
  };
  };
}
