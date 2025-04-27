{ lib, stdenv }:

stdenv.mkDerivation {
  pname = "sayo-udev-rules";
  version = "unstable-2025-04-27";

  src = [ ./sayo.rules ];

  dontUnpack = true;

  installPhase = ''
    install -Dpm644 $src $out/lib/udev/rules.d/70-sayo-device.rules
  '';

  meta = {
    homepage = "https://github.com/Sayobot/Sayo_CLI";
    description = "udev rules that give NixOS permission to communicate with Sayo Device macro pads";
    license = lib.licenses.mit;
  };
}
