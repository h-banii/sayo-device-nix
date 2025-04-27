{
  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system} = rec {
        default = sayo-cli-v2;
        sayo-cli-v1 = pkgs.callPackage ./package/sayo-cli/v1 { };
        sayo-cli-v2 = pkgs.callPackage ./package/sayo-cli/v2 { };
        sayo-udev-rules = pkgs.callPackage ./package/sayo-udev-rules { };
      };
    };
}
