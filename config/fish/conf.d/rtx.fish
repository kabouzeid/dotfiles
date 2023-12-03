if type -q rtx
  rtx activate fish | source

  function pyinit
    echo "\
[tools]
python = {version=\"$argv\", virtualenv=\".venv\"}
    " \
      >? .rtx.toml
  end
end
