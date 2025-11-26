# /home/lf/nix/overlays/default.nix
# This file centralizes all overlays for your Nix configurations.
{ inputs
, libOverlay
, ...
}: [
  # Use the libOverlay helper for flake inputs
  (libOverlay inputs.nur)
  (libOverlay inputs.mcp-servers-nix)
  (libOverlay inputs.emacs-overlay)
  (libOverlay inputs.nix-doom-emacs-unstraightened)

  # Keep custom overlay functions as they are
  (_final: prev: {
    claudia = inputs.claudia.packages.${prev.system}.default;
    firefox-addons = inputs.firefox-addons.packages.${prev.system};
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
