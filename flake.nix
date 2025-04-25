{
  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system} = rec {
        default = v2-binary;
        # TODO: Try compiling from source
        v2-binary = pkgs.callPackage ./package/v2/binary.nix { };
      };
    };
}
