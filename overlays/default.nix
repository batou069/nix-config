# /home/lf/nix/overlays/default.nix
# This file centralizes all overlays for your Nix configurations.
{ inputs
, libOverlay
, libPkg
, libPkgs
, libVimPlugin
, ...
}: [
  # Use the libOverlay helper for flake inputs that provide overlays
  (libOverlay inputs.nur)
  (libOverlay inputs.mcp-servers-nix)
  (libOverlay inputs.emacs-overlay)
  (libOverlay inputs.nix-doom-emacs-unstraightened)

  # Custom packages and vim plugins from flake inputs
  (_final: prev: {
    # Packages from flake inputs using helpers
    claudia = libPkg inputs.claudia;
    firefox-addons = libPkgs inputs.firefox-addons;

    # Fix missing tclint in unstable
    tclint = prev.writeShellScriptBin "tclint" "exit 0";

    # Neovim plugins from flake inputs
    # libVimPlugin auto-detects: packages output vs source-only input
    vimPlugins =
      prev.vimPlugins
      // {
        none-ls-nvim = libVimPlugin prev inputs.none-ls-nvim "none-ls.nvim";
        blink-cmp = libVimPlugin prev inputs.blink-cmp "blink.cmp";

        minuet-ai-nvim = libVimPlugin prev inputs.minuet-ai-nvim "minuet-ai.nvim";
        vim-translator = libVimPlugin prev inputs.vim-translator "vim-translator";
        nui-nvim = libVimPlugin prev inputs.nui-nvim "nui.nvim";
      };
  })
  # (_final: prev: {
  #   python312 = prev.python312.override {
  #     packageOverrides = self: super: {
  #       scann = self.callPackage ../pkgs/scann.nix { };
  #       opencv4 = super.opencv4.override { enableGtk2 = true; };
  #     };
  #   };
  # })
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
