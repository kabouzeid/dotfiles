# 🏠 dotfiles

```bash
# link dotfiles and install ohmyzsh + plugins, tpm and packer
git clone https://github.com/kabouzeid/dotfiles ~/.dotfiles
  && cd ~/.dotfiles
  && ./install
```

```bash
# (optional) download and link essential binaries
./install -vv -c install-binaries.conf.yaml
```

```bash
# (optional) link bundled fonts (including symbol fonts for neovim)
./install -c install-fonts.conf.yaml
```
