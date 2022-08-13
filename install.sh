#!/usr/bin/env bash

if [[ "$OSTYPE" == "darwin"* ]]; then   # MacOS section
    export DOTFILES="$HOME/dotfiles"

    which -s brew
    if [[ $? != 0 ]] ; then
        echo "Installing Home brew..."
        # Install Homebrew
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        brew update
    fi

    echo ""
    echo "Installing software packages..."

    if [ ! -d /Applications/iTerm.app ]; then
        # proceed with installing iTerm
        brew install --cask iterm2
    fi

    if [ ! -d /Applications/Fluor.app ]; then
        echo ""
        echo "Installing Flour..."
        brew install --cask fluor
    fi

    if [ ! -d /Applications/Hermes.app ]; then
        echo ""
        echo "Installing hermes..."
        brew install --cask hermes
    fi

    if [ ! -d /Applications/Visual\ Studio\ Code.app ]; then
        echo ""
        echo "Installing VSCode..."
        brew install --cask visual-studio-code
    fi

    if [ ! -d /Applications/Docker.app ]; then
        echo ""
        echo "Installing Docker..."
        # brew install docker # Installs Docker engine but not desktop
        brew install --cask docker # install docker desktop
    fi

    if [ ! -d /Applications/Firefox.app ]; then
        echo ""
        echo "Installing Firefox..."
        brew install --cask firefox
    fi

    if [ ! -d /Applications/Chromium.app ]; then
        echo ""
        echo "Installing Chromium..."
        brew install --cask chromium
        brew upgrade --cask chromium
        xattr -dr com.apple.quarantine /Applications/Chromium.app/
    fi

    which -s aws
    if [[ $? != 0 ]] ; then
        echo ""
        echo "Installing AWS-CLI"
        brew install awscli
        brew update
        echo ""
    else
        echo "AWS-CLI installed"
    fi

    which -s node
    if [[ $? != 0 ]] ; then
        echo ""
        echo "Installing node..."
        brew install node
        brew update
        echo ""
    else
        echo "Node installed"
    fi

    which -s python
    if [[ $? != 0 ]] ; then
        echo ""
        echo "Installing Python3..."
        brew install python
    else
        echo "Python installed"
    fi

    which -s dotnet
    if [[ $? != 0 ]] ; then
        echo ""
        echo "Installing dotnet SDK..."
        brew install --cask dotnet-sdk
    else
        brew update
    fi

    which -s jq
    if [[ $? != 0 ]] ; then
        echo ""
        echo "Installing jq..."
        brew install jq
    fi

    which -s dsq
    if [[ $? != 0 ]] ; then
        echo ""
        echo "Installing dsq.."
        brew install dsq
    fi

    which -s yarn
    if [[ $? != 0 ]] ; then        
        echo ""
        echo "Installing Yarn"
        brew install yarn
    fi

    if [ ! -d ~/.oh-my-zsh ]; then
        echo ""
        echo "Installing oh-my-zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
    
    # vscode settings
    if [ -f $HOME/Library/Application\ Support/Code/User/settings.json ]; then
        mv $HOME/Library/Application\ Support/Code/User/settings.json $HOME/Library/Application\ Support/Code/User/settings_backup.json
    fi 
    ln -sfn $HOME/dotfiles/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json

    if [ -f $HOME/Library/Application\ Support/Code/User/keybindings.json ]; then
        mv $HOME/Library/Application\ Support/Code/User/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings_backup.json
    fi 
    ln -sfn $HOME/dotfiles/vscode/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings.json

    source ~/dotfiles/.macos

    # install vscode extensions
    # source ~/dotfiles/vscode/install-extensions.sh

    echo ""
    echo "Manual tasks..."
    echo ""
    echo "- Enable F Keys in Keyboard Settings"
    echo "- Disable Show Desktop F11 shortcut in Settings > Keyboard > Shortcuts > Mission Control"

else # Linux section (codespaces and VS remote dev container)
    if [ -d "/workspaces/.codespaces/.persistedshare/dotfiles" ] ; then # in Codespaces
        export DOTFILES="/workspaces/.codespaces/.persistedshare/dotfiles"
    else # in a VSCode dev container
        export DOTFILES="$HOME/dotfiles"
        source ~/dotfiles/vscode/install-extensions.sh
    fi
fi

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
    echo "Cloning zsh plugins"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

echo ""
echo "Linking dotfiles..."

# shell settings
if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc_backup
fi

ln -sfn $DOTFILES/zsh/.zshrc ~/.zshrc

# git configurations
if [ -f ~/.gitconfig ]; then
    mv ~/.gitconfig ~/.gitconfig_backup
fi 

ln -sfn $DOTFILES/git/.gitconfig ~/.gitconfig

source $DOTFILES/system/.path
