#!/usr/bin/env bash

if test ! $(which brew); then
    echo "Installing Homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

echo "Installing Homebrew packages"

brew install autoconf
brew install automake
brew install bat
brew install ccls
brew install cmake
brew install colordiff
brew install ctags
brew install curl
brew install fd
brew install ffmpeg
brew install flint
brew install fzf
brew install git
brew install gmp
brew install gnu-sed
brew install gnu-time
brew install go
brew install grep
brew install htop
brew install make
brew install mkvtoolnix
brew install mpfr
brew install neovim
brew install nmap
brew install node
brew install ntl
brew install octave
brew install python
brew install ranger
brew install rbenv
brew install reattach-to-user-namespace
brew install rename
brew install singular
brew install speedtest-cli
brew install sshfs
brew install swift-sh
brew install the_silver_searcher
brew install tmux
brew install unrar
brew install vim
brew install watch
brew install watchman
brew install wget
brew install yarn
brew install z
brew install zsh
brew install zsh-autosuggestions
