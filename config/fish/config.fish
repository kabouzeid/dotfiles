# put your local config in ./conf.d/0-.local.fish

if status is-login
    if type -q hx
        set -gx EDITOR hx
    else if type -q nvim
        set -gx EDITOR nvim
    else
        set -gx EDITOR vim
    end

    set -gx fish_greeting
    set -gx VIRTUAL_ENV_DISABLE_PROMPT 1

    ! set -q LANG; and set -gx LANG "en_US.UTF-8"
end

if status is-interactive
    alias v $EDITOR
    type -q xdg-open; and type -q setsid; and alias open="setsid xdg-open"
    type -q lazygit; and alias lzg lazygit
    type -q eget; and abbr egeti 'eget --to=~/.local/bin'

    type -q hx; and function hx
        PATH="$HOME/.local/share/nvim/mason/bin:$PATH" command hx $argv
    end

    function uve --wraps $EDITOR
        PATH="$HOME/.local/share/nvim/mason/bin:$PATH" uv run $EDITOR $argv
    end

    type -q zoxide; and zoxide init fish | source
    type -q starship; and starship init fish | source
    type -q atuin; and atuin init fish --disable-up-arrow | source

    function fishc
        cd $__fish_config_dir; and $EDITOR conf.d/0-.local.fish; and cd -
    end

    function nvimc
        cd ~/.config/nvim; and $EDITOR init.lua; and cd -
    end

    type -q pip; and function gpip
        PIP_REQUIRE_VIRTUALENV="false" pip "$argv"
    end

    function pycfg
        echo '{
    "exclude": ["**/__pycache__", "**/.*", "data", "exp", "wandb", "vis"],
    "typeCheckingMode": "standard",
}' >pyrightconfig.json
    end

    abbr --set-cursor nohup "nohup % > (date +%Y%m%d_%H%M%S).log 2>&1 & disown"
end
