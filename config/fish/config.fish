# put your local config in ./conf.d/0-.local.fish

if status is-login
    if type -q nvim
        set -gx EDITOR nvim
    else
        set -gx EDITOR vim
    end

    set -gx fish_greeting
    set -gx VIRTUAL_ENV_DISABLE_PROMPT 1

    ! set -q LANG; and set -gx LANG "en_US.UTF-8"
end

if status is-interactive
    test -e "$HOME/.iterm2_shell_integration.fish" ; and source "$HOME/.iterm2_shell_integration.fish"

    alias v $EDITOR
    type -q nvr; and set -q NVIM; and alias v "nvr --remote-tab --nostart"
    type -q xdg-open; and type -q setsid; and alias open="setsid xdg-open"
    type -q lazygit; and alias lzg lazygit
    type -q joshuto; and alias josh joshuto
    set -q MISE_DIRENV_BIN; and alias direnv $MISE_DIRENV_BIN

    type -q hx; and function hx
        PATH="$HOME/.local/share/nvim/mason/bin:$PATH" command hx $argv
    end

    type -q zoxide; and zoxide init fish | source
    type -q starship; and starship init fish | source
    type -q atuin; and atuin init fish --disable-up-arrow | source

    abbr fishc "$EDITOR $__fish_config_dir/conf.d/0-.local.fish"
end
