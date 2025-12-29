{ lib, ... }:
let
  # The explicit parentheses resolve path ambiguity for some linters.
  pluginFiles = builtins.readDir (./.);
in
{
  imports = lib.filter (x: x != null) (
    lib.mapAttrsToList
      (
        name: type:
          if name != "default.nix" && type == "regular"
          then
          # Use a relative path reference that Nix correctly imports as a module
            ./${name}
          else null
      )
      pluginFiles
  );
}
