# Use uv for python

Use `uv` for everything python. Create a venv with `uv venv` and install packages with `uv pip install`. Don't activate venvs, just prefix commands with `uv run` that should run in the venv. if you need one-off dependencies, you can use e.g. `uv run --with imageio`. `uv` commands that need to install packages will not work outside the sandbox unless prefixed with `UV_CACHE_DIR=/tmp/uv-cache` as they need write access to the cache dir and internet access.


# Don't produce AI code slop

This includes:
- Extra comments that a human wouldn't add or is inconsistent with the rest of the file
- Extra defensive checks or try/catch blocks that are abnormal for that area of the codebase (especially if called by trusted / validated codepaths)
- Casts to any to get around type issues
- Variables that are only used a single time right after declaration, prefer inlining the rhs
- Any other style that is inconsistent with the file
