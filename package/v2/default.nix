{
  stdenv,
  fetchzip,
  hidapi,
  cc ? stdenv.cc.cc.lib,
  autoPatchelfHook,
}:

stdenv.mkDerivation {
  pname = "sayo";
  version = "2";

  src = fetchzip {
    url = "https://tc1.sayobot.cn:25225/setting_v2.zip";
    hash = "sha256-yLEia0oktrnsW64YAkRN+gQ0kF8NYwxLnefyYQfauBY=";
    stripRoot = false;
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    hidapi
    cc
  ];

  installPhase = ''
    runHook preInstall
    install -m755 -D Sayo_CLI_Linux $out/bin/sayo
    cp -r --reflink=auto html $out/bin
    runHook postInstall
  '';

  meta = {
    homepage = "https://sayodevice.com/";
    description = "Sayo Device CLI";
  };
}
