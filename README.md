# 🏠 dotfiles
```bash
# clone and link dotfiles
git clone https://github.com/kabouzeid/dotfiles ~/.dotfiles && cd ~/.dotfiles && ./install
```

## Optional
```bash
# commonly used binaries such as nvim, fd, rg, ...
SHELL=bash ./install -vv -c install-binaries.conf.yaml
```

```bash
# patched symbol fonts
./install -c install-fonts.conf.yaml
```
