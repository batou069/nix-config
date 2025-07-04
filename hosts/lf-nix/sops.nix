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
      keyFile = "/home/lf/nix/secrets/age-key.txt";
      # sshKeyPaths = ["/home/lf/.ssh/id_ed25519"];
    };

    secrets = {
      "api_keys/openai" = {owner = "${config.users.users.lf.name}";};
      "api_keys/anthropic" = {owner = "${config.users.users.lf.name}";};
      "api_keys/gemini" = {owner = "${config.users.users.lf.name}";};
    };
  };
}
