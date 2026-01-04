{ inputs
, lib
, ...
}: {
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  programs.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
    };
    settings = {
      misc.focus_on_activate = true;
      popToRootOnClose = true;
      font.size = 11;
      faviconService = "twenty"; # twenty | google | none
      window = {
        # csd = false;
        # opacity = 0.95;
        # rounding = 10;
      };
      # window.opacity = 0.9;
    };
  };

  systemd.user.services.vicinae.Service.Environment = lib.mkForce "QT_QPA_PLATFORM=xcb";

  # systemd.user.services.vicinae.Service.ExecStart = lib.mkForce "${libPkg inputs.vicinae}/bin/vicinae server --replace";
  # extensions = [
  #     (inputs.vicinae.mkVicinaeExtension.${pkgs.system} {
  #       inherit pkgs;
  #       name = "extension-name";
  #       src = pkgs.fetchFromGitHub { # You can also specify different sources other than github
  #         owner = "repo-owner";
  #         repo = "repo-name";
  #         rev = "v1.0"; # If the extension has no releases use the latest commit hash
  #         # You can get the sha256 by rebuilding once and then copying the output hash from the error message
  #         sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  #       }; # If the extension is in a subdirectory you can add ` + "/subdir"` between the brace and the semicolon here
  #     })
  #   ];
  # theme.name = "catppuccin-machiato";
  # theme.iconTheme = "Papirus-Dark";
}
