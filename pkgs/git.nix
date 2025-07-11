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
      };
      credential.helper = "${
        pkgs.git.override { withLibsecret = true; }
      }/bin/git-credential-libsecret";

      # Create a Git alias to use PathPicker with difftool
      alias = {
        diffpick = "!sh -c 'git diff --name-only | fpp --no-file-checks | xargs -r git difftool'";
      };
      aliases = {
          ga = "git add";
          g = "git";
          gp = "git push -u origin";
          gpl = "git pull";
          gdc = "git diff --cached";
          gd = "git diff";
          gsh = "git show";
          gl = "git log";
          ggraph = "git log --oneline --decorate --graph --all";
          gcom = "git commit -m";
          gst = "git status";
          gb ="git branch";
          gco = "git checkout";
          gcb = "git checkout -b";
          gbm = "git merge";
          gbd = "git branch -d";
          gbdD = "git branch -D";
          gu = "git reset HEAD --mixed";
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
  };
  };
}
