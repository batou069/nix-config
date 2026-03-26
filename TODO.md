# TODO / OPEN ISSUES

IMPORTANT: When trying to solve those problems, always think step-by step and explain your reasoning

## treefmt, precommit, autoformat

im confused if we currently auto-format files prior to comitting
i see the treefmt.toml file disabled (file: `treefmt.toml.disabled` in project root) but i see the `.pre-commit-config.yaml` file in the projects root
when rebuilding i see this warning: "hint: The '.git/hooks/pre-commit' hook was ignored because it's not set as executable."

## variables.nix

im confused about the `variables.nix` files:

- hosts/default/variables.nix
- hosts/viech/variables.nix

1. hosts/lf/variables.nix is not existing
2. default is shared by both users/machines
3. do i even import the variables files anywhere? I only know about `hosts/default/core.nix` for keyboardLayouts
4. how can we make use of it to be more efficient?
