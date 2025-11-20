{ config, ... }: {
  imports = [ ];

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "${config.users.users.lf.home}/nix/secrets/age-key.txt";
      # sshKeyPaths = ["/home/lf/.ssh/id_ed25519"];
    };

    secrets = {
      "github_pat" = {
        owner = config.users.users.lf.name;
      };
      "api_keys/openai" = {
        owner = "${config.users.users.lf.name}";
      };
      "api_keys/anthropic" = {
        owner = "${config.users.users.lf.name}";
      };
      "api_keys/gemini" = {
        owner = "${config.users.users.lf.name}";
      };
      "bitwarden" = {
        owner = "${config.users.users.lf.name}";
      };
      # MCP Server Keys
      "api_keys/tavily" = {
        owner = "${config.users.users.lf.name}";
      };
      "api_keys/brave_search" = {
        owner = "${config.users.users.lf.name}";
      };
      "api_keys/github_mcp" = {
        owner = "${config.users.users.lf.name}";
      };
      "influxdb" = {
        owner = "${config.users.users.lf.name}";
      };
      "ssh_keys/github" = {
        owner = "${config.users.users.lf.name}";
      };
    };
  };
}
