#!/usr/bin/env bash

WHITE="\e[0m"
RED="\e[01;31m"
GREEN="\e[01;32m"
YELLOW="\e[01;33m"
BLUE="\e[01;34m"

# perform macOS specific install
if [ "$(uname)" == "Darwin" ]; then
    echo "${GREEN}Installing macOS specific stuff${WHITE}"
    source brew.sh
    source osx.sh
fi

# Link the dotfiles
echo "${GREEN}Linking dotfiles${WHITE}"
source link.sh "$@"

# Install vim plugins
echo "${GREEN}Installing vim plugins${WHITE}"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
echo "You can ignore this vim error:"
vim -c "execute \"PlugInstall!\" | qa"

pip3 install neovim
pip3 install neovim-remote

echo "${GREEN}Installing TPM (for tmux)${WHITE}"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "${YELLOW}Open tmux and type <prefix>I${WHITE}"

# Oh My ZSH
echo "${GREEN}Installing Oh My ZSH${WHITE}"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

