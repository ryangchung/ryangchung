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

# 2. Symlink .zshrc config
echo "Deleting current .zshrc..."
rm ~/.zshrc
echo "Linking .zshrc..."
ln -sfn /Users/ryan/ryangchung/zsh/.zshrc "$HOME/.zshrc"
echo "Linked ~/.zshrc -> ~/Users/ryan/ryangchung/.zshrc"

# 3. Build nix flake using nix-darwin
sudo nix --extra-experimental-features nix-command --extra-experimental-features flakes run nix-darwin/master#darwin-rebuild -- switch --flake ~/ryangchung/nix
