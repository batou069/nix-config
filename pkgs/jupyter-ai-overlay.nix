{ lib
, python312Packages
, fetchurl
, nodejs
, git
,
}:
python312Packages.buildPythonPackage rec {
  pname = "jupyter-ai";
  version = "2.31.6";
  format = "pyproject";
  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/74/30/3d4b7d2988b3652f714fbc9351cd1d4c2ff72f5343a221b41e54bb1049b0/jupyter_ai-2.31.6.tar.gz";
    sha256 = "1s98s9a9w7nvnspl47dy2ahfg29vznqy11ayddkgx0hwq3j0haah";
  };
  # Dependencies needed to BUILD the package
  nativeBuildInputs = with python312Packages; [
    hatchling
    hatch-jupyter-builder
    hatch-nodejs-version
    nodejs
    git
  ];
  # Dependencies needed to RUN the package
  propagatedBuildInputs = with python312Packages; [
    jupyterlab
    jupyter-server
    deepmerge
    faiss
    langchain
    langchain-community
    pydantic
    click
    jsonpath-ng
    ipython
    watchdog
    importlib-metadata
    torch
  ];
  # This hook runs before the main build starts.
  # We navigate into the magics sub-directory and install it first.
  preBuild = ''
    pip install --prefix=$out ./packages/jupyter-ai-magics
  '';
  doCheck = false;
  meta = with lib; {
    description = "Jupyter AI connects generative AI with Jupyter notebooks.";
    homepage = "https://github.com/jupyterlab/jupyter-ai";
    license = licenses.bsd3;
  };
}
