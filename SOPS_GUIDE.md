# Guide: Managing Secrets with SOPS

This guide explains how to add new API keys or other secrets to the encrypted `secrets.yaml` file and how to access them within your NixOS or Home Manager configurations.

## Prerequisites

You must have the `sops` command-line tool installed on your system. You can typically install it through Nix, your system's package manager, or by downloading it from the [sops releases page](https://github.com/getsops/sops/releases).

## The Core Concept

Secrets are stored in `secrets/secrets.yaml`, which is encrypted using `age`. The public key for encryption is defined in `secrets/.sops.yaml`. Your local machine must have the corresponding private key (stored in `secrets/age-key.txt`) to decrypt and edit the file.

The `sops-nix` integration automatically decrypts these secrets at build time, making them available within your Nix configurations.

## Step-by-Step: Adding a New Secret

1. **Open the Encrypted File for Editing**:
   To securely edit the secrets file, you must provide the path to the private key. Run the following command from the root of the repository:

   ```bash
   nix-shell -p sops --run "SOPS_AGE_KEY_FILE=secrets/age-key.txt sops secrets/secrets.yaml"
   ```

   This command does two things:
   - `nix-shell -p sops`: Temporarily provides the `sops` command if it's not already in your path.
   - `SOPS_AGE_KEY_FILE=...`: Tells `sops` exactly where to find the private key needed to decrypt the file.

   This will decrypt `secrets.yaml` into a temporary location and open it in your default command-line editor (e.g., `vim`, `nano`).

2. **Add Your New Secret**:
   The file is structured in YAML format. Add your new key-value pair.
   - **For a simple top-level secret**, add a new key:

     ```yaml
     # existing secrets...
     github_pat: ENC[...]
     my_new_secret: "this-is-the-secret-value"
     ```

   - **For a nested secret under `api_keys`**:

     ```yaml
     api_keys:
       gemini: ENC[...]
       openai: ENC[...]
       my_new_api: "another-secret-value"
     # rest of the file...
     ```

3. **Save and Quit**:
   Save the file and exit your editor. `sops` will automatically detect the changes, re-encrypt the file with the new content, and update `secrets/secrets.yaml` in place.

## Using the New Secret in Your Configuration

Once the secret is added and the file is re-encrypted, you can reference it in your Nix configurations (e.g., in `hosts/lf-nix/config.nix`).

The secrets are made available under `config.sops.secrets`.

- **Accessing a top-level secret**:
  For a secret like `my_new_secret`, you would reference it as:

  ```nix
  { config, pkgs, ... }: {
    # Example: setting an environment variable
    home.sessionVariables = {
      MY_NEW_SECRET = config.sops.secrets.my_new_secret.path;
    };
  }
  ```

- **Accessing a nested secret**:
  For a secret nested under `api_keys` like `my_new_api`, the key is represented as a path. You would reference it like this:

  ```nix
  { config, pkgs, ... }: {
    # Example from this repository's configuration
    home.sessionVariables = {
      MY_NEW_API_KEY = config.sops.secrets."api_keys/my_new_api".path;
    };
  }
  ```

The `.path` attribute provides the path to a temporary file containing the decrypted secret at build time. Your configuration can then read this file to access the secret value.

After adding the reference to your configuration, rebuild your system for the changes to take effect:

```bash
nixos-rebuild switch --flake .#your-host
```
