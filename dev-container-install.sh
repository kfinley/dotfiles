#!/usr/bin/env sh


echo "Linking dotfiles..."


# shell settings
cat $HOME/.dotfiles/zsh/.zshrc >> ~/.bashrc

source ~/.dotfiles/system/.path

# source ~/.dotfiles/vscode/install-extensions.sh
