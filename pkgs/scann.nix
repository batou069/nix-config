{ lib, buildPythonPackage, fetchurl, numpy, tree, absl-py, unzip }:

buildPythonPackage rec {
  pname = "scann";
  version = "1.4.2";
  format = "wheel";

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/c0/f8/6ecec0c496a1f771c6874dbb00f619ab4ac1e434fa7661e4eedc4e959623/scann-1.4.2-cp312-cp312-manylinux_2_27_x86_64.whl";
    sha256 = "c0f45d810e629fdcdf8da546d1e25bde4664d27dcf5c3399aa335b4934a0734c";
  };

  nativeBuildInputs = [ unzip ];

  propagatedBuildInputs = [
    numpy
    tree
    absl-py
  ];

  # The wheel is pre-compiled, so we just need to unpack it.
  # buildPythonPackage doesn't have a standard way to handle this,
  # so we override the install phase.
  installPhase = ''
    unzip $src -d $out/$PYTHON_SITE_PACKAGES
  '';

  # This is needed because we are not using a standard source distribution
  dontBuild = true;
  dontConfigure = true;

  meta = with lib; {
    description = "ScaNN: Scalable Nearest Neighbors";
    homepage = "https://github.com/google-research/google-research/tree/master/scann";
    license = licenses.asl20;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ]; # Specific to the downloaded wheel
  };
}