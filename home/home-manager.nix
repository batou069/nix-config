{ pkgs
, config
, lib
, ...
}: {
  news.display = "show";
  programs.home-manager.package = pkgs.home-manager;
  services = {
    home-manager.autoUpgrade.useFlake = true;
    home-manager.autoUpgrade.flakeDir = "${config.home.homeDirectory}/nix";
  };
  home = {
    enableNixpkgsReleaseCheck = true;
    stateVersion = "24.11";

    # User information
    username = "lf";
    homeDirectory = "/home/lf";
    file = {
      ".pre-commit-config.yaml" = {
        source = ../.pre-commit-config.yaml; # Path to the file in your dotfiles
        target = ".pre-commit-config.yaml";
      };
      ".gitignore" = {
        text = ''
          keys.txt
          example_config/
          example_config/*
          secrets.pt.yaml
        '';
      };
      # ".ipython/extensions/custom_gemini_provider.py".source = ./custom-gemini-provider.py;

      # Declaratively load Hyprland plugins as a workaround for the NixOS module bug
      # ".config/hypr/plugins-load.conf" = {
      #   text = ''
      #     exec-once = hyprctl plugin load ${inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo}/lib/libhyprexpo.so
      #     exec-once = hyprctl plugin load ${inputs.hyprland-plugins.packages.${pkgs.system}.xtra-dispatchers}/lib/libxtra-dispatchers.so
      #     exec-once = hyprctl plugin load ${inputs.hy3.packages.${pkgs.system}.hy3}/lib/libhy3.so
      #   '';
      # };
    };
    activation = {
      updateVSCodePythonPath = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        set -e # Exit immediately if a command exits with a non-zero status.
        python_path="${pkgs.python312}/bin/python3"
        settings_file="$HOME/.config/Code/User/settings.json"
        tmp_file="$settings_file.tmp"

        printf "Ensuring VSCode Python path is set to: %s\n" "$python_path" >&2

        # Ensure the directory exists
        mkdir -p "$(dirname \"$settings_file\")"

        # Create an empty JSON object if the file doesn't exist
        if [ ! -f "$settings_file" ]; then
          printf "{}\n" > "$settings_file"
          printf "Created empty settings file: %s\n" "$settings_file" >&2
        fi

        # Use jq to update the file, handling errors
        if ${pkgs.jq}/bin/jq \
          --arg path "$python_path" \
          '.["python.defaultInterpreterPath"] = $path' \
          "$settings_file" > "$tmp_file"; then
          # Check if the content has actually changed before moving
          if ! cmp -s "$settings_file" "$tmp_file"; then
            mv "$tmp_file" "$settings_file"
            printf "Updated VSCode Python path in: %s\n" "$settings_file" >&2
          else
            rm "$tmp_file"
            printf "VSCode Python path already correct in: %s\n" "$settings_file" >&2
          fi
        else
          printf "ERROR: Failed to update %s with jq.\n" "$settings_file" >&2
          rm "$tmp_file"
          exit 1
        fi
      '';
      linkMcpConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        set -e
        # Ensure the target directory exists
        mkdir -p "$HOME/.gemini"

        MCP_JSON="$HOME/.config/mcp/mcp.json"
        SETTINGS_JSON="$HOME/.gemini/settings.json"
        SECRET_PATH="${config.sops.secrets."api_keys/gemini".path}"

        # If we have both the MCP config and the secret, merge them.
        # This injects the apiKey into the settings file so gemini-cli picks it up.
        if [ -f "$MCP_JSON" ] && [ -f "$SECRET_PATH" ]; then
          # Force remove the symlink (from HM or previous fallback) to allow writing
          rm -f "$SETTINGS_JSON"
          API_KEY=$(cat "$SECRET_PATH")
          ${pkgs.jq}/bin/jq --arg key "$API_KEY" 'del(.security) | . + {apiKey: $key}' "$MCP_JSON" > "$SETTINGS_JSON"
          chmod 600 "$SETTINGS_JSON"
        else
          # Fallback to symlink if something is missing
          rm -f "$SETTINGS_JSON"
          ln -sf "$MCP_JSON" "$SETTINGS_JSON"
        fi
      '';
    };
  };
}
