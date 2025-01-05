install:
  ./install

install-binaries:
  SHELL=bash ./install -c install-binaries.conf.yaml

install-fonts:
  ./install -c install-fonts.conf.yaml
