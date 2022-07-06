default:
  @just --choose

help:
  @just --list

deploy:
  ./../scripts/deploy-nixos
  
# init:
  
validate:
  nixfmt --check *.nix