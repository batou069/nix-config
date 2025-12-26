{ ... }:
let
  pythonEnv312 = pkgs.python312.withPackages (ps:
    with ps; [
      tkinter
      pnglatex
      plotly
      kaleido
      pyperclip
      flask
      black
      isort
      alive-progress
      # spacy
      # spacy-models.en_core_web_sm
      nltk
      huggingface-hub
      torchvision
      torchaudio
      diffusers
      transformers
      tokenizers
      accelerate
      imageio
      imageio-ffmpeg
      easydict
      ftfy
      addict
      beautifulsoup4
      tensorboard
      torchvision
      deepface
      facenet-pytorch
      torch
      tsfresh
      optuna
      pyquery
      imbalanced-learn
      scipy
      requests
      rich
      polars
      pandas
      numpy
      matplotlib
      pymilvus
      #     scann
      pygame
      jupyterlab
      jupyter
      pillow
      # opencv-python
      tqdm
      pytest
      imageio
      seaborn
      python-dotenv
      regex
      tabulate
      ipykernel
      aiofiles
      pip
      scikit-learn
      scikit-image
      debugpy
      sqlalchemy
      pkgs.pyprland
      google-auth-oauthlib
      google-auth-httplib2
      google-api-python-client
      # llama-index
      # chromadb
      mcp
      httpx
      fastmcp
      pnglatex
      kaleido
      pyperclip
    ]);
in
{
  home.packages = [
    pythonEnv312
  ];
}
