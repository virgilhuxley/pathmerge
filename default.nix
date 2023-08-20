# derived from the following tutorial: https://dev.to/misterio/how-to-package-a-rust-app-using-nix-3lh3
#{ pkgs ? import <nixpkgs> { }, target ? "x86_64-unknown-linux-musl" }:
{ pkgs ? import <nixpkgs> { }, target }:
let
  manifest = (pkgs.lib.importTOML ./Cargo.toml);
in
pkgs.rustPlatform.buildRustPackage rec {
  pname = manifest.package.name;
  version = manifest.package.version;
  cargoLock.lockFile = ./Cargo.lock;
  src = pkgs.lib.cleanSource ./.;
  #target = manifest.package.default-target;
  #target = "x86_64-unknown-linux-musl";
}

