# put your local config in ./conf.d/0.local.fish

fish_add_path --global "$HOME/.local/bin" "$HOME/.cargo/bin"

if status is-login
    if type -q nvim
        set -gx EDITOR nvim
    else
        set -gx EDITOR vim
    end

    set fish_greeting
    set -gx VIRTUAL_ENV_DISABLE_PROMPT 1

    ! set -q LANG; and set -gx LANG "en_US.UTF-8"
end

if status is-interactive
    test -e "$HOME/.iterm2_shell_integration.fish" ; and source "$HOME/.iterm2_shell_integration.fish"

    alias v $EDITOR
    type -q nvr; and set -q NVIM; and alias v "nvr --remote-tab --nostart"
    type -q xdg-open; and type -q setsid; and alias open="setsid xdg-open"
    type -q lazygit; and alias lzg lazygit

    type -q hx; and function hx
        PATH="$HOME/.local/share/nvim/mason/bin:$PATH" command hx $argv
    end

    type -q zoxide; and zoxide init fish | source
    type -q starship; and starship init fish | source
end
