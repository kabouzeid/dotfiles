if type -q uv
    abbr pip 'uv pip'
    abbr pir 'uv pip install -r requirements.txt'
    abbr pil 'uv pip list'

    abbr uvr 'uv run'
    abbr uva 'uv add'
    abbr uvar 'uv add -r requirements.txt'

    abbr uvs 'uv run $SHELL'

    abbr python 'uv run python'
    abbr debugpy 'uv run debugpy'
    abbr pytest 'uv run pytest'
    abbr rerun 'uv run rerun'
end
