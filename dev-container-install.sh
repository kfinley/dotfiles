#!/usr/bin/env sh

# shell settings
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
cat $HOME/.dotfiles/zsh/.zshrc >> $HOME/.bashrc

# source $HOME/.dotfiles/system/.path

# source ~/.dotfiles/vscode/install-extensions.sh
