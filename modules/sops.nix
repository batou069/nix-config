{ ... }: {
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/lf/nix/secrets/age-key.txt";

    # This block is for the NixOS module to know what's in the file.
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

  # This is the CRITICAL part for the standalone Home Manager module.
  # Each secret must be declared individually here.
  sops.secrets = {
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
}
