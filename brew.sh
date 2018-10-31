#!/usr/bin/env bash

if test ! $(which brew); then
    echo "Installing Homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

echo "Installing Homebrew packages"

brew install neovim
brew install fzf
brew install git
brew install grep
brew install reattach-to-user-namespace
brew install the_silver_searcher
brew install tmux
brew install wget
brew install curl
brew install zsh
brew install zsh-autosuggestions
brew install python2
brew install python3
brew install make
brew install z
