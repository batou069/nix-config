{ pkgs, ... }:
let
  pythonEnv314 = pkgs.python314.withPackages (ps:
    with ps; [
      #     scann
      # beautifulsoup4
      # chromadb
      # deepface
      # facenet-pytorch
      # google-api-python-client
      # google-auth-httplib2
      # google-auth-oauthlib
      # imageio
      # imageio
      # imageio-ffmpeg
      ipykernel
      # isort
      jupyterlab
      # kaleido
      # llama-index
      # opencv-python
      # pillow
      # pip
      # plotline
      # pnglatex
      # pygame
      # pymilvus
      # scikit-image
      # spacy
      # spacy-models.en_core_web_sm
      # sqlalchemy
      # tensorboard
      # tkinter
      # torchaudio
      # torchvision
      # transformers
      # accelerate
      # addict
      # aiofiles
      # alive-progress
      # black
      # debugpy
      # diffusers
      # easydict
      # fastmcp
      # flask
      # ftfy
      # httpx
      # huggingface-hub
      imbalanced-learn
      jupyter
      # kaleido
      matplotlib
      # mcp
      # nltk
      numpy
      # optuna
      pandas
      pandas-ta
      # # pkgs.pyprland
      plotly
      polars
      # pyperclip
      # pyquery
      # pytest
      # python-dotenv
      regex
      # requests
      # rich
      scikit-learn
      scipy
      seaborn
      # siuba
      # tabulate
      # tokenizers
      # torch
      # tqdm
      # tsfresh
    ]);
  pythonEnv313 = pkgs.python313.withPackages (ps:
    with ps; [
#     scann
      # beautifulsoup4
      # chromadb
      # deepface
      # facenet-pytorch
      # google-api-python-client
      # google-auth-httplib2
      # google-auth-oauthlib
      # imageio
      # imageio
      # imageio-ffmpeg
      ipykernel
      # isort
      jupyterlab
      # kaleido
      # llama-index
      # opencv-python
      # pillow
      # pip
      # plotline
      # pnglatex
      # pygame
      # pymilvus
      # scikit-image
      # spacy
      # spacy-models.en_core_web_sm
      # sqlalchemy
      # tensorboard
      # tkinter
      # torchaudio
      # torchvision
      # transformers
      accelerate
      addict
      aiofiles
      alive-progress
      black
      debugpy
      diffusers
      easydict
      fastmcp
      flask
      ftfy
      httpx
      huggingface-hub
      imbalanced-learn
      jupyter
      kaleido
      matplotlib
      mcp
      nltk
      numpy
      optuna
      pandas
      pandas-ta
      # pkgs.pyprland
      plotly
      polars
      pyperclip
      pyquery
      pytest
      python-dotenv
      regex
      requests
      rich
      scikit-learn
      scipy
      seaborn
      siuba
      tabulate
      tokenizers
      torch
      tqdm
      tsfresh
    ]);
in
{
  home.packages = [
    pythonEnv314
    (pkgs.lib.lowPrio pythonEnv313)
  ];
}
