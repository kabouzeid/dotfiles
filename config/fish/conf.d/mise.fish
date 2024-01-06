if type -q mise
  mise activate fish | source

  function pyinit
    echo "\
[tools]
python = {version=\"$argv\", virtualenv=\".venv\"}
    " \
      >? .mise.toml; and mise install
  end
end
