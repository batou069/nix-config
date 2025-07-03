{
  config,
  inputs,
  ...
}: {
  imports = [];

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = ../../secrets/age-key.txt;
      sshKeyPaths = ["/home/lf/.ssh/id_ed25519"];
      generateKey = true;
    };

    gnupg.sshKeyPaths = [
      "/home/lf/.ssh/id_ed25519"
    ];

    secrets = {
      "api_keys/openai" = {};
      "api_keys/anthropic" = {};
      "api_keys/github" = {};
    };
  };
}
