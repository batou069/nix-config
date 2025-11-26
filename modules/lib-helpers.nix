# modules/lib-helpers.nix
{ system
, ...
}: {
  libOverlay = input:
    input.overlays.default or input.overlay or (_: _: { });

  libPkg = input:
    input.packages.${system}.default
      or (throw "Flake ${input.name or "<unknown>"} has no packages.${system}.default");
}
