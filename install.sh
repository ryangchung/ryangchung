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

# 2. Symlink nvim config
echo "Deleting current Neovim config..."
rm -rf ~/.config/nvim
echo "Linking new Neovim config..."
ln -sfn /Users/ryan/ryangchung/nvim "$HOME/.config/nvim"
echo "Linked ~/.config/nvim -> /Users/ryan/ryangchung/nvim"

# 3. Symlink .aerospace.toml
echo "Deleting current .aerospace.toml"
rm ~/.aerospace.toml
echo "Linking .aerospace.toml..."
ln -sfn /Users/ryan/ryangchung/aerospace/.aerospace.toml "$HOME/.aerospace.toml"
echo "Linked ~/.aerospace -> ~/Users/ryan/ryangchung/.aerospace.toml"

# 4. Build nix flake using nix-darwin
sudo nix --extra-experimental-features nix-command --extra-experimental-features flakes run nix-darwin/master#darwin-rebuild -- switch --flake ~/ryangchung/nix
