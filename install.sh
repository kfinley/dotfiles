#!/usr/bin/env sh

echo "Installing packages..."
brew install --cask iterm2
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Cloning zsh plugins"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "dotfiles..."

# shell settings
ln -sv $HOME/.dotfiles/zsh/.zshrc ~/.zshrc

# git configurations
ln -sv $HOME/.dotfiles/git/.gitconfig ~/.gitconfig

# vscode settings
ln -sv $HOME/.dotfiles/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
ln -sv $HOME/.dotfiles/vscode/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings.json
ln -sv $HOME/.dotfiles/vscode/snippets/ $HOME/Library/Application\ Support/Code/User

cat ~/.dotfiles/vscode/extensions | while read extension
do
    code --install-extension $extension --force
done