/bin/cat ~/.dotfiles/vscode/extensions | while read extension
do
    echo $extension
    code --install-extension $extension --force
done