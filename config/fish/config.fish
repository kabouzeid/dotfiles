test -e "$HOME/.config/fish/config.local.pre.fish"; and source "$HOME/.config/fish/config.local.pre.fish"

if type -q pyenv
    set -gx PYENV_ROOT "$HOME/.pyenv"
    set -gx PYENV_VIRTUALENV_DISABLE_PROMPT=1
    pyenv init - | source
    pyenv virtualenv-init - | source
end

set -gx PATH "$HOME/.local/bin" "$HOME/.cargo/bin" $PATH

if status is-interactive
    set fish_greeting
    set -gx VIRTUAL_ENV_DISABLE_PROMPT 1

    if type -q nvim
        set -gx EDITOR nvim
    else
        set -gx EDITOR vim
    end
    alias v $EDITOR

    test -e "$HOME/.iterm2_shell_integration.fish" ; and source "$HOME/.iterm2_shell_integration.fish"

    type -q zoxide; and zoxide init fish | source

    type -q nvr; and set -q NVIM; and alias v "nvr --remote-tab --nostart"
    type -q xdg-open; and type -q setsid; and alias open="setsid xdg-open"
    type -q lazygit; and alias lzg lazygit
    type -q hx; and function hx
        PATH="$HOME/.local/share/nvim/mason/bin:$PATH" command hx $argv
    end

    starship init fish | source
end

test -e "$HOME/.config/fish/config.local.post.fish"; and source "$HOME/.config/fish/config.local.post.fish"
