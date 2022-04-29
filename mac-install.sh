#!/usr/bin/env sh
which -s brew
if [[ $? != 0 ]] ; then
    echo "Installing Home brew..."
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    brew update
fi

echo "Installing packages..."

if [ ! -d /Applications/iTerm.app ]; then
    # proceed with installing iTerm
    brew install --cask iterm2
fi

if [ ! -d /Applications/Flour.app ]; then
    echo "Installing Flour..."
    brew install --cask fluor
fi

if [ ! -d /Applications/Hermes.app ]; then
    echo "Installing hermes..."
    brew install --cask hermes
fi

if [ ! -d /Applications/Visual\ Studio\ Code.app ]; then
    echo "Installing VSCode..."
    brew install --cask visual-studio-code
fi

if [ ! -d /Applications/Docker.app ]; then
    echo "Installing Docker..."
    brew install docker
fi

which -s dotnet
if [[ $? != 0 ]] ; then
    echo "Installing dotnet SDK..."
    brew install --cask dotnet-sdk
else
    brew update
fi

if [ ! -d ~/.oh-my-zsh ]; then
	echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
    echo "Cloning zsh plugins"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

echo "Linking dotfiles..."

if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc_backup
fi 

# shell settings
ln -sv $HOME/dotfiles/zsh/.zshrc ~/.zshrc

if [ -f ~/.gitconfig ]; then
    mv ~/.gitconfig ~/.gitconfig_backup
fi 

# git configurations
ln -sv $HOME/dotfiles/git/.gitconfig ~/.gitconfig

# vscode settings
if [ -f $HOME/Library/Application\ Support/Code/User/settings.json ]; then
    mv $HOME/Library/Application\ Support/Code/User/settings.json $HOME/Library/Application\ Support/Code/User/settings_backup.json
fi 
ln -sv $HOME/dotfiles/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json

if [ -f $HOME/Library/Application\ Support/Code/User/keybindings.json ]; then
    mv $HOME/Library/Application\ Support/Code/User/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings_backup.json
fi 
ln -sv $HOME/dotfiles/vscode/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings.json

source ~/dotfiles/system/.path

source ~/dotfiles/.macos

source ~/dotfiles/vscode/install-extensions.sh
