# source asdf if it's installed
if type -q brew
  source "$(brew --prefix asdf)"/libexec/asdf.fish
else if test -d "$HOME/.asdf"
  source "$HOME/.asdf/asdf.fish"
end

# since we'll be using asdf-direnv, remove shims dir from `$fish_user_paths`
if test -n "$ASDF_DATA_DIR"
    set -l SHIMS_DIR "$ASDF_DATA_DIR/shims"
else
    set -l SHIMS_DIR "$HOME/.asdf/shims"
end
set fish_user_paths (string match --invert $fish_user_paths)
