test -e "$HOME/.config/fish/config.local.pre.fish"; and source "$HOME/.config/fish/config.local.pre.fish"

if status is-login
    fish_add_path --global "$HOME/.local/bin" "$HOME/.cargo/bin"

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
