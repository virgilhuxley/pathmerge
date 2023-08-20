{
  description = "Path(s) Merging Tool";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05"; # Stable
  };
  outputs = { self, nixpkgs }:
    let
      #supportedSystems = [ "x86_64-linux" ];
      #supportedTargets = [ "x86_64-unknown-linux-musl" "x86_64-unknown-linux-gnu" ];
      pkgsFor = nixpkgs.legacyPackages;
      #forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      packages = {
        x86_64-linux = rec {
          x86_64-unknown-linux-gnu = pkgsFor.x86_64-linux.callPackage ./default.nix { target = "x86_64-unknown-linux-gnu"; };
          x86_64-unknown-linux-musl = pkgsFor.x86_64-linux.callPackage ./default.nix { target = "x86_64-unknown-linux-musl"; };
          default = x86_64-unknown-linux-musl;
        };
      };
      devShells = {
        x86_64-linux = rec {
          x86_64-unknown-linux-gnu = pkgsFor.x86_64-linux.callPackage ./shell.nix { target = "x86_64-unknown-linux-gnu"; };
          x86_64-unknown-linux-musl = pkgsFor.x86_64-linux.callPackage ./shell.nix { target = "x86_64-unknown-linux-musl"; };
          default = x86_64-unknown-linux-gnu;
        };
      };
    };
}
