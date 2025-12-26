# modules/nixos-sops.nix
#
# SOPS configuration for NixOS SYSTEM services that run as root.
{ ... }: {
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/lf/dotfiles/nix/secrets/age-key.txt";
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    secrets = {
      # Secrets needed for NixOS system-level configuration
      "api_keys/github_mcp" = { owner = "root"; };
      "github_pat" = { owner = "root"; };
      "api_keys/openai" = { };
      "api_keys/gemini" = { };
      "api_keys/anthropic" = { };
      "api_keys/openrouter" = { };
      "influxdb" = { };
      "ssh_keys/github" = { };
    };
  };
}
