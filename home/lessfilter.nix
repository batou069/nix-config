{ pkgs, ... }:
let
  # A list of packages required by your original script
  scriptPkgs = with pkgs; [
    eza
    chafa
    exiftool
    csvkit # Provides in2csv
    xan # Maintained fork of xsv
    bat
    lesspipe
    file # for the `file` command itself
  ];
in
{
  # This defines the script and makes it available in the user's environment
  home.file.".local/bin/lessfilter.sh" = {
    executable = true;
    # Ensure all necessary packages are in the script's PATH
    # Replaced shebang below, was `#!${pkgs.zsh}/bin/zsh`
    text = ''
      #!/usr/bin/env bash
      export PATH=${pkgs.lib.makeBinPath scriptPkgs}:$PATH

      mime=$(file -bL --mime-type "$1")
      category=''${mime%%/*}
      kind=''${mime##*/}

      if [ -d "$1" ]; then
        eza --git -hl --color=always --icons "$1"
      elif [ "$category" = image ]; then
        chafa "$1"
        exiftool "$1"
      elif [ "$kind" = vnd.openxmlformats-officedocument.spreadsheetml.sheet ] || \
        [ "$kind" = vnd.ms-excel ]; then
        in2csv "$1" | xan table | bat -ltsv --color=always
      elif [ "$category" = text ]; then
        bat --color=always "$1"
      else
        # Use lesspipe as the powerful fallback
        lesspipe.sh "$1" | bat --color=always
      fi
    '';
  };
}
