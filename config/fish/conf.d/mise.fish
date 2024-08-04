if type -q mise
    if status is-interactive
        mise activate fish | source
    else
        mise activate fish --shims | source
    end

    if type -q uv; and type -q sd
        function venv
            if count $argv >/dev/null
                uv venv --python $argv
            else
                uv venv
            end

            # remove existing venv entry
            if test -e .mise.toml
                sd '_.python.venv.*\n' "" .mise.toml
            end

            # add new venv entry
            set placeholder __PYTHON_VENV_PLACEHOLDER
            mise set "$placeholder"=PLACEHOLDER
            sd "$placeholder.*" '_.python.venv = ".venv"' .mise.toml

            mise trust -q
        end
    end
end
