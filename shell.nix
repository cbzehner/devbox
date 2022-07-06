{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  # nativeBuildInputs is usually what you want
  nativeBuildInputs = [
    # -- tools you need to run go here
    pkgs.cacert # provide certificate authority certs for pkgs.curl
    pkgs.curl
    pkgs.fd
    pkgs.fzf
    pkgs.git
    pkgs.just
    pkgs.rsync
    pkgs.nixfmt
    pkgs.openssh
    pkgs.ripgrep
    pkgs.shellcheck
    pkgs.terraform
  ];
}
