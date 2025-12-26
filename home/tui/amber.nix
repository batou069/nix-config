{ ... }: {
  programs. amber.enable = true;
  amber.ambsSettings = {
    regex = false;
    column = false;
    row = false;
    binary = false;
    statistics = false;
    skipped = false;
    interactive = true;
    recursive = true;
    symlink = true;
    color = true;
    file = true;
    skip_vcs = true;
    skip_gitignore = false;
    fixed_order = true;
    parent_ignore = true;
    line_by_match = false;
  };
}
