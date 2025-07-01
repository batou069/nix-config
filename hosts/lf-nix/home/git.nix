{
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
      # Create a Git alias to use PathPicker with difftool
      alias = {
        diffpick = "!sh -c 'git diff --name-only | fpp --no-file-checks | xargs -r git difftool'";
      };
    };
  };
}
