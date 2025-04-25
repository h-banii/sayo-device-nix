{
  stdenv,
  fetchFromGitHub,
  pkg-config,
  jsoncpp,
  hidapi,
}:

stdenv.mkDerivation {
  pname = "sayo";
  version = "0-unstable-2023-09-18";

  src = fetchFromGitHub {
    owner = "Sayobot";
    repo = "Sayo_CLI";
    rev = "b8f8176491901e7ad6c44bae0b239cf4809ed2e7";
    hash = "sha256-htlCWhlnfWG9jU70a2cnx5SOlHD5mpJBkgKAOXW5uGw=";
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    hidapi
    jsoncpp
  ];

  buildPhase = ''
    runHook preBuild

    mkdir -p $out/bin

    NIX_CFLAGS_COMPILE="`pkg-config --cflags hidapi-hidraw` $NIX_CFLAGS_COMPILE"
    NIX_CFLAGS_COMPILE="`pkg-config --cflags jsoncpp` $NIX_CFLAGS_COMPILE"

    g++ --std=c++17 $NIX_CFLAGS_COMPILE \
      -I./inc \
      o2_protocol.cpp \
      main.cpp \
      src/http.cpp \
      src/tools.cpp \
      -ljsoncpp \
      -lhidapi-hidraw \
      -lpthread \
      -o $out/bin/sayo

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    cp -r --reflink=auto html $out/bin
    runHook postInstall
  '';

  meta = {
    homepage = "https://sayodevice.com/";
    description = "Sayo Device CLI";
  };
}
