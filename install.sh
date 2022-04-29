#!/usr/bin/env sh
#!/bin/sh
export DOTFILES="/workspaces/.codespaces/.persistedshare/dotfiles"

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
    echo "Cloning zsh plugins"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

echo "Linking dotfiles..."

if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc_backup
fi 

ln -sfn /workspaces/.codespaces/.persistedshare/dotfiles/zsh/.zshrc ~/.zshrc
