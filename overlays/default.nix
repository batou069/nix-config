# /home/lf/nix/overlays/default.nix
# This file centralizes all overlays for your Nix configurations.
{ inputs, ... }: [
  # WORKAROUND: The nixvim flake contains a definition for the `atopile` LSP
  # server, but the `atopile` package does not exist in nixpkgs. This causes
  # an evaluation error when nixvim tries to generate documentation for all
  # possible LSP servers. This overlay creates an empty placeholder package
  # to satisfy the dependency and allow the build to succeed.
  # (final: prev: {
  #   atopile = prev.stdenv.mkDerivation {
  #     name = "atopile-placeholder";
  #     version = "0.0.0";
  #     src = prev.lib.sources.sourceByRegex ./../. ["flake.nix"]; # Trivial source
  #     installPhase = "mkdir -p $out/bin; touch $out/bin/atopile";
  #   };
  # })
  inputs.nur.overlays.default
  inputs.mcp-servers-nix.overlays.default
  # inputs.nix-mcp-servers.overlays.default
  inputs.emacs-overlay.overlay
  # inputs.nix-doom-emacs-unstraightened.overlays.homeModule
  # inputs.nix-doom-emacs-unstraightened.overlay
  inputs.nix-doom-emacs-unstraightened.overlays.default
  (_final: prev: {
    claudia = inputs.claudia.packages.${prev.system}.default;
    # ags = inputs.ags.packages.${prev.system}.default;
    firefox-addons = inputs.firefox-addons.packages.${prev.system};
    # pyprland = inputs.pyprland.packages.${prev.system}.default;
    vimPlugins =
      prev.vimPlugins
      // {
        none-ls-nvim = inputs.none-ls-nvim;
        blink-cmp = inputs.blink-cmp.packages.${prev.system}.default;
      };
  })
  (_final: prev: {
    python312 = prev.python312.override {
      packageOverrides = self: super: {
        scann = self.callPackage ../pkgs/scann.nix { };
        opencv4 = super.opencv4.override { enableGtk2 = true; };
      };
    };
  })
  (_final: prev: {
    faiss = prev.faiss.override { cudaSupport = false; };
    python311 = prev.python311.override {
      packageOverrides = pfinal: pprev: {
        gensim = pprev.gensim.overrideAttrs (oldAttrs: {
          nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ pfinal.cython ];
          postPatch =
            (oldAttrs.postPatch or "")
            + ''
              sed -i '/Extension("gensim.similarities.fastss",/d' setup.py
            '';
          preBuild = ''
            rm -f gensim/models/word2vec_inner.c
            rm -f gensim/models/doc2vec_inner.c
            rm -f gensim/models/fasttext_inner.c
          '';
        });
      };
    };
  })
]
