{ pkgs ? import <nixpkgs> { }, target }:
pkgs.mkShell {
  # Get dependencies from the main package
  inputsFrom = [
    (pkgs.callPackage ./default.nix {
      inherit target;
    })
  ];
  # Additional tooling
  buildInputs = with pkgs; [
    rust-analyzer # LSP Server
    rustfmt # Formatter
    clippy # Linter
  ];
}

