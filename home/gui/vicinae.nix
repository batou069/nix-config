{ inputs
, pkgs
, lib
, ...
}: {
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  services.vicinae = {
    enable = true;
    autoStart = true;
    settings = {
      popToRootOnClose = true;

      window.csd = true;
      window.opacity = 0.9;
    };
  };
  systemd.user.services.vicinae.Service.ExecStart = lib.mkForce "${inputs.vicinae.packages.${pkgs.system}.default}/bin/vicinae server --replace";

  # theme.name = "catppuccin-machiato";
  # theme.iconTheme = "Papirus-Dark";
}
