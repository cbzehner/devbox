set dotenv-load	:= true

default:
  @just --choose

help:
  @just --list

nix COMMAND:
  @cd nixos/ && just {{COMMAND}}


tf COMMAND:
  @cd terraform/ && just {{COMMAND}}

scripts COMMAND:
  @cd scripts/ && just {{COMMAND}}

connect:
  @echo "connecting to $DOMAIN production instance..."
  @ssh $DOMAIN

deploy:
  @just nix deploy

fix:
  @just tf fix

init:
  @just scripts init
  @just tf init

provision:
  @just tf apply

validate:
  @just nix validate
  @just scripts validate
  @just tf validate