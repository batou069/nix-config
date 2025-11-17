{ ... }: {
  programs.fd = {
    enable = true;
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
