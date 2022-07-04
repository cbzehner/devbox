default:
  @just --choose

help:
  @just --list

apply:
  terraform apply

fix:
  terraform fmt -recursive

init:
  terraform init

plan:
  terraform plan

validate:
  terraform fmt -check -recursive
  terraform validate