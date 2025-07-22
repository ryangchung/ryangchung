#!/bin/sh

set -eu

# 1. Prompt to install Lix
printf "Do you want to install Lix? (y/n): "
read install_lix
if [ "$install_lix" = "y" ] || [ "$install_lix" = "Y" ]; then
    echo "Installing Lix..."
    curl -sSf -L https://install.lix.systems/lix | sh -s -- install
else
    echo "Skipping Lix installation."
fi

# 2. Build nix flake using nix-darwin
sudo darwin-rebuild switch --flake ~/ryangchung/nix
