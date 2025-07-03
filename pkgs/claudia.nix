# /home/lf/nix/pkgs/claudia.nix
{ pkgs, pkgs-unstable, claudia-src }:

pkgs.stdenv.mkDerivation {
  pname = "claudia";
  version = "unstable-from-source";

  src = claudia-src;

  # These are the build tools required by the project.
  nativeBuildInputs = with pkgs; [
    rustc
    cargo
    pkgs-unstable.bun # Use bun from unstable
    git
    pkg-config
    # From the "build-essential" package
    gcc
    gnumake
  ];

  # These are the system libraries required for the build,
  # based on the README's apt install command.
  buildInputs = with pkgs; [
    webkitgtk_4_1
    gtk3
    libayatana-appindicator
    librsvg
    patchelf
    openssl
    xdotool
    libsoup_3
    # This is usually part of webkitgtk
    # javascriptcoregtk_4_1
  ];

  # We need to set a HOME directory for bun to work correctly
  # inside the sandboxed build environment.
  preBuild = ''
    export HOME=$(mktemp -d)
    bun install
  '';

  buildPhase = ''
    runHook preBuild
    bun run tauri build
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    # The README says the executable is in this directory.
    # We will install it into the package's bin folder.
    install -Dm755 src-tauri/target/release/claudia $out/bin/claudia

    # We can also grab the AppImage if it exists, as a convenience.
    if [ -f src-tauri/target/release/bundle/appimage/*.AppImage ]; then
      install -Dm755 src-tauri/target/release/bundle/appimage/*.AppImage $out/bin/claudia.AppImage
    fi

    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "A command-line tool for managing AWS Lambda functions and API Gateway APIs";
    homepage = "https://github.com/getAsterisk/claudia";
    # IMPORTANT: Please verify the actual license from the repository.
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = [];
  };
}
