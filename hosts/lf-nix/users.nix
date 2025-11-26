{ pkgs
, username
, ...
}:
# users.nix
{
  users = {
    groups.influxdb = { };
    mutableUsers = true;
    users = {
      "${username}" = {
        homeMode = "755";
        isNormalUser = true;
        description = "Laurent Flaster";
        extraGroups = [
          "networkmanager"
          "wheel"
          "libvirtd"
          "scanner"
          "lp"
          "video"
          "input"
          "audio"
          "docker"
          "nix-users"
          "mpd"
        ];
      };
      # influxdb = {
      #   isSystemUser = true;
      #   group = "influxdb";
      # };
      # telegraf.extraGroups = [ "disk" "storage" "network" ];
    };
    defaultUserShell = pkgs.zsh;
  };

  # systemd.services."telegraf" = {
  #   after = [ "influxdb3.service" ];
  #   requires = [ "influxdb3.service" ];
  # };

  # systemd.services.influxdb3 = {
  #   description = "InfluxDB 3 Core Server";
  #   wantedBy = [ "multi-user.target" ];
  #   after = [ "network.target" ];
  #   serviceConfig = {
  #     ExecStart = ''
  #       ${pkgs.influxdb3}/bin/influxdb3 serve \
  #         --node-id 'lf-nix-1' \
  #         --object-store=file \
  #         --data-dir=/var/lib/influxdb3/data \
  #         --http-bind='127.0.0.1:8181'
  #     '';
  #     User = "influxdb";
  #     Group = "influxdb";
  #     Restart = "always";
  #     NoNewPrivileges = true;
  #     PrivateTmp = true;
  #     ProtectSystem = "full";
  #     ProtectHome = true;
  #   };
  # };
  #
  # systemd.tmpfiles.rules = [
  #   # Type, Path, Mode, User, Group, Age, Argument
  #   "d /var/lib/influxdb3 0755 influxdb influxdb -"
  #   "d /var/lib/influxdb3/data 0755 influxdb influxdb -"
  # ];

  systemd.user.services.install-pre-commit = {
    description = "Install pre-commit hooks for dotfiles";
    wantedBy = [ "default.target" ];
    script =
      let
        preCommit = pkgs.pre-commit;
      in
      ''
        PRE_COMMIT="${pkgs.pre-commit}/bin/pre-commit"
        "${preCommit}/bin/pre-commit" install --install-dir "$HOME/nix"
      '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      PrivateTmp = false;
      ProtectHome = false;
    };
  };
}
