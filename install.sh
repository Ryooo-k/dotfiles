#!/usr/bin/env bash

set -e

DOTFILES="$HOME/dotfiles"

ln -sfn "$DOTFILES/.gitconfig" "$HOME/.gitconfig"
ln -sfn "$DOTFILES/.vim" "$HOME/.vim"
ln -sfn "$DOTFILES/.zshrc" "$HOME/.zshrc"
ln -sfn "$DOTFILES/.zprofile" "$HOME/.zprofile"

echo "Dotfiles installed."
