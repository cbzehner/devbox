default:
  @just --choose

help:
  @just --list

init:
  ./scripts/create-root-ssh-token-and-upload-to-provider
  ./scripts/generate-tfvars

validate:
  shellcheck -x *