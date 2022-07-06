#!/bin/bash
set -uo errexit

echo "Generating Terraform variables..."

project_root=$(git rev-parse --show-toplevel)
if [ -z "$project_root" ]; then
    echo "project_root is not set. are you working outside a git repo?"
    exit 1
fi

# Find the terraform.tfvar file or default to /terraform/terraform.tfvars
file=$(fd terraform.tfvars -1 --no-ignore-vcs --exclude '*.example')
if [ -z "$file" ]; then
    file="$project_root/terraform/terraform.tfvars"
fi

# Source TF_VAR_* variables from dotfiles
source "$project_root/.env"
source "$project_root/.env.local"

# Collect the variables from the environment
variables=($(set | rg TF_VAR_ | cut -c 8-))

# Transform the environment variables into the expected tfvars style
for item in "${variables[@]}"; do
    key=$(echo $item | cut -f 1 -d = | tr '[:upper:]' '[:lower:]')
    value=$(echo $item | cut -f 2 -d =)

    echo "$key = \"$value\""
done >"$file"

echo "Generated: $file"