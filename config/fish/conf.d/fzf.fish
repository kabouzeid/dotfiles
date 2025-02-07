if type -q fzf
    # don't bind C+R for history, and don't bind A+C for dir switcher
    fzf --fish | sed 's/bind \\\cr fzf-history-widget//' | sed 's/bind -M insert \\\cr fzf-history-widget//' | FZF_ALT_C_COMMAND= source
end
