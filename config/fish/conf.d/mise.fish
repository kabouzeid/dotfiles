if type -q mise
  if status is-interactive
    mise activate fish | source
  else
    mise activate fish --shims | source
  end

  if type -q uv; and type -q sd
    function venv
      mise use python@$argv

      if not test -e .mise.toml
        echo ".mise.toml not found, exiting."
        exit 1
      end

      sd '_.python.venv.*\n' "" .mise.toml

      mise x -- uv venv

      set placeholder __PYTHON_VENV_PLACEHOLDER
      mise set "$placeholder"=PLACEHOLDER
      sd "$placeholder.*" '_.python.venv = ".venv"' .mise.toml

      mise trust
    end
  end
end
