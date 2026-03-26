# /home/lf/nix/overlays/default.nix
# This file centralizes all overlays for your Nix configurations.
{ inputs
, libOverlay
, libPkgs
, libVimPlugin
, ...
}: [
  # Use the libOverlay helper for flake inputs that provide overlays
  (libOverlay inputs.nur)
  (libOverlay inputs.mcp-servers-nix)
  (libOverlay inputs.emacs-overlay)
  (libOverlay inputs.nix-doom-emacs-unstraightened)
  (libOverlay inputs.claude-desktop)
  # Custom packages and vim plugins from flake inputs
  (_final: prev: {
    # Packages from flake inputs using helpers
    # claude-desktop = prev.claude-desktop;
    # or FHS variant:
    claude-desktop-fhs = prev.claude-desktop-fhs;

    firefox-addons = libPkgs inputs.firefox-addons;

    ib-tws = prev.callPackage ../pkgs/ib-tws { };

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
  #   python314 = prev.python314.override {
  #     packageOverrides = self: super: {
  #       scann = self.callPackage ../pkgs/scann.nix { };
  #       opencv4 = super.opencv4.override { enableGtk2 = true; };
  #     };
  #   };
  # })

  (_final: prev: {
    gtksourceview5 = prev.gtksourceview5.overrideAttrs (_old: {
      doCheck = false;
    });

    pythonPackagesExtensions =
      prev.pythonPackagesExtensions
      ++ [
        (python-final: python-prev: {
          imbalanced-learn = python-prev.imbalanced-learn.overrideAttrs (old: {
            propagatedBuildInputs = (old.propagatedBuildInputs or [ ]) ++ [ python-final.sklearn-compat ];
          });

          # cfscrape 2.1.1 uses DEFAULT_CIPHERS removed in urllib3 2.x
          # Patch: let OpenSSL choose default ciphers (more secure anyway)
          cfscrape = python-prev.cfscrape.overrideAttrs (old: {
            postPatch =
              (old.postPatch or "")
              + ''
                sed -i 's/from urllib3.util.ssl_ import create_urllib3_context, DEFAULT_CIPHERS/from urllib3.util.ssl_ import create_urllib3_context/' cfscrape/__init__.py
                sed -i '/DEFAULT_CIPHERS +=/d' cfscrape/__init__.py
                sed -i 's/\.set_ciphers(DEFAULT_CIPHERS)//' cfscrape/__init__.py
                sed -i 's/create_urllib3_context(ciphers=DEFAULT_CIPHERS)/create_urllib3_context()/' cfscrape/__init__.py
              '';
          });
        })
      ];
  })

  (_final: prev: {
    faiss = prev.faiss.override { cudaSupport = false; };
    python314 = prev.python314.override {
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
