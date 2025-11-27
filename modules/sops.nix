# modules/sops.nix
{ ... }: {
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/lf/nix/secrets/age-key.txt";
    secrets = {
      "github_pat" = { };
      "api_keys/openai" = { };
      "api_keys/anthropic" = { };
      "api_keys/gemini" = { };
      "bitwarden" = { };
      "api_keys/tavily" = { };
      "api_keys/brave_search" = { };
      "api_keys/github_mcp" = { };
      "influxdb" = { };
      "ssh_keys/github" = { };
    };
  };
}
