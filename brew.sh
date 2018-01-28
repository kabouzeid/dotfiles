#!/usr/bin/env bash

if test ! $(which brew); then
    echo "Installing Homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

echo "Installing Homebrew packages"

brew install vim --with-override-system-vi --with-lua --with-python3
brew install neovim
brew install fzf
brew install git
brew install grep
brew install reattach-to-user-namespace
brew install the_silver_searcher
brew install tmux
brew install tree
brew install wget
brew install zsh
brew install zsh-autosuggestions
brew install python3
brew install sshfs
brew install make
brew install gdb
