default:
  @just --choose

help:
  @just --list

tf COMMAND:
  @cd terraform/ && just {{COMMAND}}

scripts COMMAND:
  @cd scripts/ && just {{COMMAND}}

fix:
  @just tf fix

init:
  @just scripts init
  @just tf init

provision:
  @just tf apply

validate:
  @just scripts validate
  @just tf validate