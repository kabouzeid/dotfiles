# 🏠 dotfiles

```bash
# link dotfiles and install tmux-plugin-manager (tpm) and packer.nvim
git clone https://github.com/kabouzeid/dotfiles ~/.dotfiles
  && cd ~/.dotfiles
  && ./install
```

```bash
# (optional) download and link common programs
./install -vv -c install-binaries.conf.yaml
```

```bash
# (optional) link bundled fonts (symbol fonts for neovim)
./install -c install-fonts.conf.yaml
```
