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

user := env_var_or_default("USER", "root")
connect:
  @echo "connecting to $DOMAIN production instance..."
  @mosh {{user}}@"$DOMAIN"

deploy:
  @just nix deploy

fix:
  @just tf fix

init:
  @just scripts init
  @just tf init
  @echo "Waiting 5 min to allow cloud configuration to complete..."
  @sleep 60
  @echo "Waiting 4 min to allow cloud configuration to complete..."
  @sleep 60
  @echo "Waiting 3 min to allow cloud configuration to complete..."
  @sleep 60
  @echo "Waiting 2 min to allow cloud configuration to complete..."
  @sleep 60
  @echo "Waiting 1 min to allow cloud configuration to complete..."
  @sleep 60
  @just nix init

provision:
  @just tf apply

validate:
  @just nix validate
  @just scripts validate
  @just tf validate