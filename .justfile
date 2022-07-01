default:
  @just --choose

help:
  @just --list

tf COMMAND:
  @cd tf/ && just {{COMMAND}}

init:
  @cd terraform && just init