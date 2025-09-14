# /home/lf/nix/overlays/default.nix
# This file centralizes all overlays for your Nix configurations.
{inputs, ...}: [
  # (final: prev: {
  #   # FIX: Provide the correct package for khanelivim's docker LSP
  #   dockerfile-language-server = prev.nodePackages.dockerfile-language-server-nodejs;
  # })
  inputs.neovim-nightly-overlay.overlays.default
  inputs.mcp-servers-nix.overlays.default
  (final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (prev) system;
      config.allowUnfree = true;
    };
  })
  (final: prev: {
    claudia = inputs.claudia.packages.${prev.system}.default;
    ags = inputs.ags.packages.${prev.system}.default;
    firefox-addons = inputs.firefox-addons.packages.${prev.system};
  })
  (final: prev: {
    python312 = prev.python312.override {
      packageOverrides = self: super: {
        scann = self.callPackage ../pkgs/scann.nix {};
        opencv4 = super.opencv4.override {enableGtk2 = true;};
      };
    };
  })
  (final: prev: {
    faiss = prev.faiss.override {cudaSupport = false;};
  })
]
