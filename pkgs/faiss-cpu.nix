{ lib, buildPythonPackage, fetchPypi, numpy, packaging, cmake }:

buildPythonPackage rec {
  pname = "faiss-cpu";
  version = "1.12.0";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    sha256 = "2f87cbcd603f3ed464ebceb857971fdebc318de938566c9ae2b82beda8e953c0";
  };

  nativeBuildInputs = [
    cmake
  ];

  propagatedBuildInputs = [
    numpy
    packaging
  ];

  meta = with lib; {
    description = "A library for efficient similarity search and clustering of dense vectors (CPU version).";
    homepage = "https://github.com/facebookresearch/faiss";
    license = licenses.mit;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}
