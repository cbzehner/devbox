default:
  @just --choose

help:
  @just --list

init:
  ./scripts/create-root-ssh-token-and-upload-to-provider.sh
  ./scripts/generate-tfvars.sh

validate:
  shellcheck -x *.sh