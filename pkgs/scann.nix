{ lib, stdenv, buildPythonPackage, fetchPypi, numpy, tree, absl-py }:

buildPythonPackage rec {
  pname = "scann";
  version = "1.4.2";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    sha256 = ""; # This will be filled in after the first build attempt
  };

  propagatedBuildInputs = [
    numpy
    tree
    absl-py
  ];

  # ScaNN is a C++ library and may require additional setup if the build fails.
  # For now, we'll start with this basic definition.

  meta = with lib; {
    description = "ScaNN: Scalable Nearest Neighbors";
    homepage = "https://github.com/google-research/google-research/tree/master/scann";
    license = licenses.asl20;
    maintainers = [ ]; # No maintainer in nixpkgs
  };
}
