{ pkgs
, pkgs-stable
, ...
}: {
  environment.systemPackages =
    (with pkgs; [
    ])
    ++ (with pkgs-stable; [
    ]);
}
