if type -q mise
  if status is-interactive
    mise activate fish | source
  else
    mise activate fish --shims | source
  end

  if type -q uv; and type -q sd
    function venv
      if test -e .mise.toml
        sd '_.python.venv.*\n' "" .mise.toml
      end

      mise x python@$argv -- uv venv

      set placeholder __PYTHON_VENV_PLACEHOLDER
      mise set "$placeholder"=PLACEHOLDER
      sd "$placeholder.*" '_.python.venv = ".venv"' .mise.toml

      mise trust -q
    end
  end
end
