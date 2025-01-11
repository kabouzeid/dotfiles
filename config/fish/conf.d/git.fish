# modified version of https://github.com/jhillyerd/plugin-git/blob/1697adf8861a15178f4794de566d14d295c79b39/functions/__git.init.fish

function __git.create_abbr -d "Create Git plugin abbreviation"
    set -l name $argv[1]
    set -l body $argv[2..-1]
    abbr --set-cursor="%%" -a -g $name $body
end

# git abbreviations
__git.create_abbr g git
__git.create_abbr ga git add
__git.create_abbr gaa git add --all
__git.create_abbr gb git branch -vv
__git.create_abbr gba git branch -a -v
__git.create_abbr gc git commit -v
__git.create_abbr gc! git commit -v --amend
__git.create_abbr gcn! git commit -v --no-edit --amend
__git.create_abbr gca git commit -v -a
__git.create_abbr gca! git commit -v -a --amend
__git.create_abbr gcan! git commit -v -a --no-edit --amend
__git.create_abbr gcm git commit -m \"%%\"
__git.create_abbr gcam git commit -a -m \"%%\"
__git.create_abbr gcl git clone --recurse-submodules
__git.create_abbr gclean git clean -di
__git.create_abbr gclean! git clean -dfx
__git.create_abbr gclean!! "git reset --hard; and git clean -dfx"
__git.create_abbr gcount git shortlog -sn
__git.create_abbr gd git diff
__git.create_abbr gdto git difftool
__git.create_abbr gignore git update-index --assume-unchanged
__git.create_abbr gf git fetch
__git.create_abbr gl git pull
__git.create_abbr glr git pull --rebase
__git.create_abbr glg git log --stat
__git.create_abbr glgg git log --graph
__git.create_abbr glgga git log --graph --decorate --all
__git.create_abbr glo git log --oneline --decorate --color
__git.create_abbr glog git log --oneline --decorate --color --graph
__git.create_abbr gloga git log --oneline --decorate --color --graph --all
__git.create_abbr gloo "git log --pretty=format:'%C(yellow)%h %Cred%ad %Cblue%an%Cgreen%d %Creset%s' --date=short"
__git.create_abbr gm git merge
__git.create_abbr gp git push
__git.create_abbr gp! git push --force-with-lease
__git.create_abbr gr git reset
__git.create_abbr grh git reset --hard
__git.create_abbr grv git remote -v
__git.create_abbr gsh git show
__git.create_abbr gst git status
__git.create_abbr gsta git stash
__git.create_abbr gstd git stash drop
__git.create_abbr gstl git stash list
__git.create_abbr gstp git stash pop
__git.create_abbr gsts git stash show --text

# git checkout abbreviations
__git.create_abbr gco git checkout
__git.create_abbr gcb git checkout -b

# git worktree abbreviations
__git.create_abbr gwt git worktree
__git.create_abbr gwta git worktree add
__git.create_abbr gwtl git worktree list
__git.create_abbr gwtr git worktree remove

# Cleanup declared functions
functions -e __git.create_abbr
