install:
  ./install

install-binaries:
  SHELL=bash ./install -vv -c install-binaries.conf.yaml

install-fonts:
  ./install -c install-fonts.conf.yaml
