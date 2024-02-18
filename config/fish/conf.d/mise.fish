if type -q mise
  if status is-interactive
    mise activate fish | source
  else
    mise activate fish --shims | source
  end

  if type -q uv; and type -q sd
    function venv
      mise use python@$argv
      mise x -- uv venv
      sd 'python = "(.*)"' 'python = {version="$1", virtualenv=".venv"}' .mise.toml
    end
  end
end
