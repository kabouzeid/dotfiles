#!/usr/bin/env bash

# Oh My ZSH
echo "Installing Oh My ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Link the dotfiles
echo "Linking dotfiles"
source install/link.sh -cinstall/link.conf "$@"

# Install vim plugins
echo "Installing vim plugins"
vim -c "execute \"PlugInstall!\" | qa"

# perform macOS specific install
if [ "$(uname)" == "Darwin" ]; then
    echo "Installing macOS specific stuff"
    source install/brew.sh
    source install/osx.sh
fi