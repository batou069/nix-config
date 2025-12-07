{ pkgs, ... }: {
  programs.fd = {
    enable = true;
    package = pkgs.fd;
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
