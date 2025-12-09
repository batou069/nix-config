{ config, ... }: {
  programs.mbsync.enable = true;
  programs.msmtp.enable = true;
  programs.notmuch.enable = true;
  programs.astroid.enable = true;

  services.mbsync = {
    enable = true;
    frequency = "*:0/15"; # Run every 15 minutes
  };

  accounts.email = {
    maildirBasePath = "Mail";
    accounts.lf = {
      enable = true;
      primary = true;
      realName = "Laurent Flaster";
      userName = "laurentf84";
      address = "laurentf84@gmail.com";
      flavor = "gmail.com";

      # Password configuration
      # You need to generate an App Password from your Google Account settings
      # (Security -> 2-Step Verification -> App Passwords)
      # Store it in a file or password manager.
      # Example using a simple file (ensure this file is secure/encrypted!):
      passwordCommand = "cat ${config.sops.secrets."email/password".path}";

      mbsync = {
        enable = true;
        create = "maildir";
        expunge = "both";
        patterns = [ "*" ]; # Sync all folders
      };

      msmtp.enable = true;

      notmuch.enable = true;

      astroid = {
        enable = true;
        sendMailCommand = "msmtp -t";
      };
    };
  };
  # Set default application for email links
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/mailto" = "astroid.desktop";
  };
}
