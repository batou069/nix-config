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
      keyFile = builtins.readFile ../../secrets/age-key.txt;
      # sshKeyPaths = ["/home/lf/.ssh/id_ed25519"];
      generateKey = true;
    };

    secrets = {
      "api_keys/openai" = {owner = "${config.users.users.lf.name}";};
      "api_keys/anthropic" = {owner = "${config.users.users.lf.name}";};
      "api_keys/gitlab" = {owner = "${config.users.users.lf.name}";};
      "api_keys/gemini" = {owner = "${config.users.users.lf.name}";};
    };
  };
}
