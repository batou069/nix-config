{
  pkgs,
  lib,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    # Define your VS Code settings here
    profiles.default = {
      userSettings = {
        # "editor.fontFamily" = "FantasqueSansM Nerd Font Mono Italic";
        "editor.fontFamily" = lib.mkForce "Maple Mono NF Italic, Cascadia Mono PL Italic";
        "editor.fontLigatures" = "'calt', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'zero', 'onum'";
        "editor.tokenColorCustomizations" = {
          "textMateRules" = [
            {
              "scope" = [
                "source"
                "text"
              ];
              "settings" = {
                "fontStyle" = "italic";
              };
            }
          ];
        };
        "editor.tabSize" = 2;
        "[docker-compose]" = {
          "editor.defaultFormatter" = "KilianJPopp.docker-compose-support";
          "editor.formatOnSave" = true;
        };
        "docker-compose.format.enabled" = true;
        "nix.serverPath" = "nixd";
        "nix.enableLanguageServer" = true;
        "nix.serverSettings" = {
          "nixd.formatting.command" = ["alejandra"];
        };
        "[nix]" = {
          "editor.defaultFormatter" = "kamadorueda.alejandra";
          "editor.formatOnSave" = true;
        };
        "git.openRepositoryInParentFolders" = "always";
        "workbench.iconTheme" = "vscode-icons";
        "vsicons.dontShowNewVersionMessage" = true;
        # "workbench.colorTheme" = "Catppuccin Mocha";
        "python.defaultInterpreterPath" = "${pkgs.python312}/bin/python3";
      };
      languageSnippets = {
        python = {
          "AI3 Header" = {
            "body" = [
              "\"\"\""
              "Title = \${1: 'Enter a Title'}"
              "\${2|Exercise,Quiz|} = $3"
              "Description = \${4: 'And now a description'}"
              ""
              "Author = Laurent Flaster"
              "Reviewer = \${6: 'Lucky who?'}"
              ""
              "Infinity Labs R&D AI3"
              "\"\"\""
              ""
              "\${7: import} $0"
            ];
            "description" = ["Insert AI3 Doc string."];
            "prefix" = ["ai3"];
          };
        };
      };
      extensions = with pkgs.vscode-extensions; [
        vscode-icons-team.vscode-icons
        github.copilot
        github.copilot-chat
        ms-python.python
        ms-python.debugpy
        charliermarsh.ruff
        # ms-python.pylint
        ms-python.vscode-pylance
        ms-python.mypy-type-checker
        jnoortheen.nix-ide
        kamadorueda.alejandra
        jeff-hykin.better-nix-syntax
        sumneko.lua
        ms-toolsai.jupyter
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.jupyter-keymap
        ms-azuretools.vscode-docker
        zainchen.json
        vscodevim.vim
        visualstudioexptteam.intellicode-api-usage-examples
        tekumara.typos-vscode
        rubymaniac.vscode-paste-and-indent
        richie5um2.snake-trail
        naumovs.color-highlight
        mongodb.mongodb-vscode
        mishkinf.goto-next-previous-member
        catppuccin.catppuccin-vsc
        njpwerner.autodocstring
      ];
    };
  };
}
