#!/bin/bash
set -uo errexit

if [ -z "$HOME" ]; then
    echo "HOME is not set"
    exit 1
fi

project_root=$(git rev-parse --show-toplevel)
if [ -z "$project_root" ]; then
    echo "project_root is not set. are you working outside a git repo?"
    exit 1
fi

source "$project_root/.env"
if [ -z "$DOMAIN" ]; then
    echo "DOMAIN is not set. Expected in $project_root/.env."
    exit 1
fi

source "$project_root/.env.local"
if [ -z "$DIGITALOCEAN_ACCESS_TOKEN" ]; then
    echo "DIGITALOCEAN_ACCESS_TOKEN is not set. Expected in $project_root/.env.local or provided via the command-line with DIGITALOCEAN_ACCESS_TOKEN=<access-token-value>."
    exit 1
fi

private_key_path="$HOME/.ssh/id_rsa.$DOMAIN"
public_key_path="$private_key_path.pub"
ssh_directory="$HOME/.ssh"

# Generate the SSH keypair
__ssh_config="
Host $DOMAIN
  User root
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile $private_key_path
"

mkdir -p "$ssh_directory" # Create the ssh configuration directory, if it does not already exist

# Check for existing SSH key and avoid overwriting
if [[ -f "$private_key_path" || -f "$public_key_path" ]]; then
  echo "[skip] Generation of SSH key. Found an existing key at $public_key_path.

If you want to generate a new SSH key, first remove these keys by running the following command:
> rm $public_key_path $private_key_path

Then rerun this script to proceed.
"
  exit 1
fi

# shellcheck disable=SC2162
read -p "Email address: " email                             # Prompt for email address

echo "Generating your SSH key..."
ssh-keygen -t rsa -b 4096 -C "$email" -f "$private_key_path" # Generate a new SSH key
eval "$(ssh-agent -s)"                                       # Enable the ssh-agent
if [[ ! -f "$ssh_directory" ]]; then                         # Check for a pre-existing SSH config
  echo "$__ssh_config" >> "$ssh_directory"/config            # Add public key to the config
fi
# ssh-add --apple-use-keychain "$private_key_path"             # Add the generated private key to the ssh-agent
echo "Keypair generation complete."
echo "Private key: $private_key_path"
echo "Public key: $public_key_path"
private_key_path=""                                          # Erase private key path to guard against accidental use

# Upload public key to Digital Ocean
echo "Uploading $public_key_path to Digital Ocean as \"root@$DOMAIN SSH public key\"..."
if [[ -f "$project_root"/.env ]]; then
    # shellcheck disable=SC1091
    source "$project_root"/.env                                              # Read the Digital Ocean Access Token into the environment
fi

if [ -z "$DIGITALOCEAN_ACCESS_TOKEN" ]; then
    # shellcheck disable=SC2162
    read -p "Digital Ocean access token: " do_token
else
    do_token=$DIGITALOCEAN_ACCESS_TOKEN
fi

# Reference: https://docs.digitalocean.com/reference/api/api-reference/#operation/create_ssh_key
curl -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $do_token" \
  -d "{\"name\":\"root@$DOMAIN SSH public key\",\"public_key\":\"$(cat "$public_key_path")\"}" \
  "https://api.digitalocean.com/v2/account/keys"
echo "Upload of $public_key_path complete."

echo "root SSH key is now available in DigitalOcean. Please proceed to initialization via Terraform."