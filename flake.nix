{
  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system} = rec {
        default = v2;
        v2 = pkgs.callPackage ./package/v2 { };
      };
    };
}
