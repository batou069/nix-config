{ pkgs
, pkgs-unstable
,
}:
let
  # Path to the dedicated config file for ipython-ai
  # This will be copied into the derivation.
  ipython_ai_config_file = ./ipython_ai_config.py;

  # Path to the custom provider file
  # This will also be copied into the derivation.
  custom_gemini_provider_file = ./custom-gemini-provider.py;

  # Path to the dummy provider file
  dummy_provider_file = ./dummy_provider.py;

  # The core script logic that sets up the venv and runs ipython
  # --- OLD IMPERATIVE SCRIPT (COMMENTED OUT FOR PRESERVATION) ---
  # ipython-ai-script-old = pkgs.writeShellScriptBin "ipython-ai-unwrapped-old" ''
  #      #!/usr/bin/env bash
  #      set -e
  #      VENV_DIR="$HOME/.cache/ipython-ai-venv"
  #
  #      if [ ! -f "$VENV_DIR/nix-setup-complete" ]; then
  #        echo "Setting up Python virtual environment for IPython-AI..."
  #        python -m venv "$VENV_DIR"
  #
  #        "$VENV_DIR/bin/pip" install --no-cache-dir \
  #   'tensorboard' \
  #   'torchvision' \
  #        	'torch' \
  #          'optuna' \
  #          'ipython' \
  #          'google-generativeai' \
  #          'langchain-google-genai' \
  #          'prompt_toolkit' \
  #          'jupyter-ai-magics' \
  #          'jupyter-ai' \
  #          'langchain-core' \
  #          'line-profiler' \
  #          'memory-profiler' \
  #          'pyquery' \
  #          'imbalanced-learn' \
  #          'scipy' \
  #          'requests' \
  #          'rich' \
  #          'polars' \
  #          'matplotlib' \
  #          'seaborn' \
  #          'tsfresh' \
  #          'prophet' \
  #          'jupyterlab' \
  #          'jupyter' \
  #          'pillow' \
  #          'pygments' \
  #          'opencv-python' \
  #          'plotly' \
  #          'pytest' \
  #          'python-dotenv' \
  #          'cycler' \
  #          'regex' \
  #          'pyqtgraph' \
  #          'statsmodels' \
  #          'tabulate' \
  #          'ipykernel' \
  #          'aiofiles' \
  #          'kaggle' \
  #          'scikit-image' \
  #          'scikit-learn' \
  #          'imageio' \
  #          'debugpy' \
  #          'numpy' \
  #          'pandas' \
  #          'sqlalchemy'
  #
  #        touch "$VENV_DIR/nix-setup-complete"
  #        echo "Setup complete."
  #      fi
  #
  #      # Create package directory inside venv
  #      mkdir -p "$VENV_DIR/my_providers"
  #      touch "$VENV_DIR/my_providers/__init__.py"
  #
  #      # Copy config and provider files into the venv with correct permissions
  #        install -m 644 ${ipython_ai_config_file} "$VENV_DIR/ipython_ai_config.py"
  #        install -m 644 ${custom_gemini_provider_file} "$VENV_DIR/my_providers/custom_gemini_provider.py"
  #        install -m 644 ${dummy_provider_file} "$VENV_DIR/my_providers/dummy_provider.py"
  #
  #      # Add the venv root to PYTHONPATH so my_providers can be found
  #      export PYTHONPATH="$VENV_DIR:$PYTHONPATH"
  #
  #      # Execute IPython as a module using the venv's specific python interpreter,
  #      # and pass it the dedicated config file.
  #      # The config file is now relative to the venv.
  #      exec "$VENV_DIR/bin/python" -m IPython --config="$VENV_DIR/ipython_ai_config.py" "$@"
  # '';

  # --- NEW DECLARATIVE SCRIPT ---
  ipython-ai-script = pkgs.writeShellScriptBin "ipython-ai-unwrapped" ''
    #!/usr/bin/env bash
    set -e
    # The Python environment is now provided by the Nix wrapper,
    # so we don't need to create a venv or use pip.

    # The config and provider files will be placed in a known location by Nix.
    CONFIG_DIR="$HOME/.config/ipython-ai-nix"
    mkdir -p "$CONFIG_DIR/my_providers"
    touch "$CONFIG_DIR/my_providers/__init__.py"

    # Copy config and provider files
    install -m 644 ${ipython_ai_config_file} "$CONFIG_DIR/ipython_ai_config.py"
    install -m 644 ${custom_gemini_provider_file} "$CONFIG_DIR/my_providers/custom_gemini_provider.py"
    install -m 644 ${dummy_provider_file} "$CONFIG_DIR/my_providers/dummy_provider.py"

    # Add the providers to PYTHONPATH
    export PYTHONPATH="$CONFIG_DIR:$PYTHONPATH"

    # Execute IPython with the correct config.
    # The 'python' executable will be the one from the nix-provided environment.
    exec python -m IPython --config="$CONFIG_DIR/ipython_ai_config.py" "$@"
  '';
  # --- OLD WRAPPER (COMMENTED OUT) ---
  # # The packages needed at runtime by the script and the python packages
  # runtimePackages = with pkgs; [
  #   python312
  #   python312Packages.pip
  #   python312Packages.virtualenv
  #   cmake
  #   ninja
  #   gcc
  #   git
  #   stdenv.cc.cc.lib
  # ];
  # in
  # # Create the final wrapped executable
  # (pkgs.symlinkJoin {
  #   name = "ipython-ai";
  #   paths = [
  #     ipython-ai-script
  #   ];
  #   nativeBuildInputs = [ pkgs.makeWrapper ];
  #   postBuild = ''
  #     makeWrapper $out/bin/ipython-ai-unwrapped $out/bin/ipython-ai \
  #       --prefix PATH : "${pkgs.lib.makeBinPath runtimePackages}" \
  #       --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath runtimePackages}"
  #   '';
  # })
  # --- NEW, CORRECT, SELF-CONTAINED WRAPPER ---
in
let
  # Define the dedicated Python environment for the ipython-ai script
  ipythonAiEnv = pkgs.python312.withPackages (ps:
    with ps; [
      # Core dependency from your overlay
      (pkgs.callPackage ./jupyter-ai-overlay.nix { })

      # Other dependencies that were previously in the pip install list
      ipython
      google-generativeai
      (pkgs-unstable.python312Packages.langchain-google-genai)
      prompt_toolkit
      langchain-core
      line-profiler
      memory-profiler
      prophet
      pygments
      cycler
      pyqtgraph
      statsmodels
      kaggle
      # Note: Other packages like pandas, numpy, etc., are dependencies
      # of the above and will be included automatically.
    ]);
in
# Create the final wrapped executable
(pkgs.symlinkJoin {
  name = "ipython-ai";
  paths = [
    ipython-ai-script
  ];
  nativeBuildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    # Wrap the script so it runs with our dedicated Python environment
    makeWrapper $out/bin/ipython-ai-unwrapped $out/bin/ipython-ai
      --prefix PATH : "${pkgs.lib.makeBinPath [ipythonAiEnv]}"
  '';
})
