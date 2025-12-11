# Suggested Commands

## System Management

- **Apply Configuration (NixOS + Home Manager)**:
  ```bash
  nh os switch /home/lf/nix
  # OR standard method:
  sudo nixos-rebuild switch --flake /home/lf/nix#lf-nix
  ```
- **Update Flake Inputs**:
  ```bash
  nix flake update
  ```
- **Garbage Collect**:
  ```bash
  nh clean all
  ```

## Development

- **Format Code**:
  ```bash
  nix fmt
  ```
- **Check Flake**:
  ```bash
  nix flake check
  ```

## Secrets (Sops)

- **Edit Secrets**:
  ```bash
  nix shell nixpkgs#sops --command sops secrets/secrets.yaml
  ```
  _(Note: Requires `secrets/age-key.txt`)_

## Debugging

- **Build with Trace**:
  ```bash
  nixos-rebuild build --flake .#lf-nix --show-trace -vv
  ```
