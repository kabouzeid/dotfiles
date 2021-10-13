#!/usr/bin/env bash
set -e

cd "$HOME/bin"

# neovim
curl -L -o nvim "https://github.com/neovim/neovim/releases/latest/download/nvim.appimage"
chmod +x nvim

# delta
curl -L -o delta.tar.gz "https://github.com/dandavison/delta/releases/download/0.8.3/delta-0.8.3-x86_64-unknown-linux-gnu.tar.gz"
tar -xzf delta.tar.gz
ln -s delta-0.8.3-x86_64-unknown-linux-gnu/delta .

# gh
curl -L -o gh.tar.gz "https://github.com/cli/cli/releases/download/v2.0.0/gh_2.0.0_linux_amd64.tar.gz"
tar -xzf gh.tar.gz
ln -s gh_2.0.0_linux_amd64/bin/gh .

# node
curl -L -o node.tar.xz "https://nodejs.org/dist/v16.11.1/node-v16.11.1-linux-x64.tar.xz"
tar -xf node.tar.xz
ln -sf node-v16.11.1-linux-x64/bin/* .
