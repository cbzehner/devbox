{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  # nativeBuildInputs is usually what you want
  nativeBuildInputs = [
    # -- tools you need to run go here
    pkgs.git
    pkgs.just
    pkgs.nixfmt
    pkgs.terraform
  ];
}
