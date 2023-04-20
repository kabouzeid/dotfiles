# source asdf if it's installed
if type -q brew
  source "$(brew --prefix asdf)"/libexec/asdf.fish
else if test -d "$HOME/.asdf"
  source "$HOME/.asdf/asdf.fish"
end

if type -q asdf
  # since we'll be using asdf-direnv, remove shims dir from `$fish_user_paths`
  set -l SHIMS_DIR
  if test -n "$ASDF_DATA_DIR"
      set SHIMS_DIR "$ASDF_DATA_DIR/shims"
  else
      set SHIMS_DIR "$HOME/.asdf/shims"
  end
  set fish_user_paths (string match --invert $SHIMS_DIR $fish_user_paths)

  function usas
    echo "use asdf" >? .envrc
    direnv allow
  end

  function usaspy
    echo "\
    use asdf
    layout python
    " >? .envrc
    direnv allow
  end
end
