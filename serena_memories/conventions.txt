# Conventions & Best Practices

## Package Access

- **Do NOT use**: `pkgs.system` (e.g., `inputs.foo.packages.${pkgs.system}.default`). This is deprecated.
- **Use**: `libPkg` and `libPkgs` helper functions from `modules/lib-helpers.nix`.
  - `libPkg inputs.foo`: Returns the default package of the flake.
  - `libPkgs inputs.foo`: Returns the package set (`packages.${system}`) of the flake.
  - **Important**: When using `libPkg` inside a list, wrap it in parentheses `(libPkg inputs.foo)` to avoid parsing ambiguity.

## Secrets

- Secrets are stored in `secrets/secrets.yaml` encrypted with sops-age.
- Secrets are exposed via `config.sops.secrets.<name>.path`.
- **Environment Variables**: To expose secrets as env vars in shells, add them to `home/shells/aliae.nix` in the `settings.env` list.
  - Use `if = "match .Shell ..."` to handle syntax differences between Bash/Zsh (`$(cat ...)`) and Fish/Nushell.

## Module Arguments

- Custom helpers (`libPkg`, `libPkgs`, `libOverlay`) are passed to modules via `specialArgs` (NixOS) and `extraSpecialArgs` (Home Manager).
- To use them in a module, declare them in the module arguments: `{ libPkg, ... }:`.

## Formatting

- Run `nix fmt` before committing. This uses `treefmt` to format Nix, Python, Lua, and other files.
