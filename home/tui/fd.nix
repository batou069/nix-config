{ pkgs-unstable, ... }: {
  programs.fd = {
    enable = true;
    package = pkgs-unstable.fd;
    hidden = true;
    ignores = [
      ".git/"
      "__pycache__/"
      ".ipynb_checkpoints/"
      ".mypy_cache/"
      ".vscode/"
      ".tmp/"
    ];
    extraOptions = [
      "--color=auto"
    ];
  };
}
