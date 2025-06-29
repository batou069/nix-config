{ config, lib, pkgs, ... }:

{
  sops = {
    defaultSopsFile = ../../secrets.yaml;
    gnupg.sshKeyPaths = [
      "/home/lf/.ssh/id_ed25519"
    ];
    age.sshKeyPaths = [
      "/home/lf/.ssh/id_ed25519"
    ];
  };
}
