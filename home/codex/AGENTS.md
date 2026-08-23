## Use uv for python
Use `uv` for everything python; don't use `pip`.


## Don't produce AI code slop
This includes:
- Extra comments that a human wouldn't add or is inconsistent with the rest of the file.
- Extra defensive checks or try/catch blocks that are abnormal for that area of the codebase (especially if called by trusted / validated codepaths).
- Variables and functions that are only used a single time right after declaration, prefer inlining the rhs.


## Write commit messages in the style of @mitchellh
