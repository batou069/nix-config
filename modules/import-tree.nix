# Import all .nix files recursively from a directory, excluding files/dirs starting with "_"
lib: modulesPath:
let
  allFiles = lib.filesystem.listFilesRecursive modulesPath;
  nixFiles = lib.filter (lib.hasSuffix ".nix") allFiles;
  filterHidden = path:
    let
      relativePath = lib.path.removePrefix modulesPath path;
      components = lib.path.subpath.components relativePath;
    in
    lib.all (component: !(lib.hasPrefix "_" component)) components;
in
lib.filter filterHidden nixFiles
