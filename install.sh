#!/usr/bin/env bash

# perform macOS specific install
if [ "$(uname)" == "Darwin" ]; then
    echo "Installing macOS specific stuff"
    source brew.sh
    source osx.sh
fi

# Oh My ZSH
echo "Installing Oh My ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Link the dotfiles
echo "Linking dotfiles"
source link.sh "$@"

# Install vim plugins
echo "Installing vim plugins"
vim -c "execute \"PlugInstall!\" | qa"

pip3 install neovim
