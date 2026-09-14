#!/opt/homebrew/bin/fish

# Manages the symlinks between this repo and their live locations on the machine.
# Configs live here; the machine gets symlinks pointing back, so an edit in either
# place is the same file and the repo is never stale.
#
#   ./dotfile_repo_updater.fish            report the state of every link
#   ./dotfile_repo_updater.fish link       create/repair the links
#   ./dotfile_repo_updater.fish brew       dump the Brewfile from installed packages

set -g DOTFILE_REPO (path resolve (path dirname (status filename)))

# "live_location,path_relative_to_repo"
# Directories are linked whole where the repo owns everything in them. nvim is linked
# per entry instead, because nvim writes lazy-lock.json next to init.lua.
# clangd reads its user config from Library/Preferences on macOS, not ~/.config.
set -g managed_links \
    "$HOME/.vimrc,vim/vimrc" \
    "$HOME/.vim/coc-settings.json,vim/coc-settings.json" \
    "$HOME/.config/vim,vim/configs" \
    "$HOME/.tmux.conf,tmux/tmux.conf" \
    "$HOME/.gitconfig,git_configs/gitconfig" \
    "$HOME/.gitignore_global,git_configs/gitignore_global" \
    "$HOME/.config/alacritty,alacritty" \
    "$HOME/.config/fish,fish_configs" \
    "$HOME/.config/nvim/init.lua,nvim/init.lua" \
    "$HOME/.config/nvim/lua,nvim/lua" \
    "$HOME/Library/Preferences/clangd/config.yaml,clangd/config.yaml"

function link_state --description 'Classify $argv[1] against wanted target $argv[2] without touching anything'
    set -l __live $argv[1]
    set -l __target $argv[2]

    if test -L $__live
        set -l __current (readlink $__live)
        if test (path resolve $__current) = (path resolve $__target)
            echo ok
        else
            echo wrong
        end
    else if test -e $__live
        echo exists
    else
        echo missing
    end
end

function label --description 'Print a coloured [state] live -> target line'
    set -l __color $argv[1]
    printf '[%s%s%s] %s\n' (set_color -o $__color) $argv[2] (set_color normal) (string join ' ' $argv[3..-1])
end

function link_one --description 'Point $argv[1] at $argv[2], backing up whatever is in the way'
    set -l __live $argv[1]
    set -l __target $argv[2]
    set -l __state (link_state $__live $__target)

    switch $__state
        case ok
            label green ok "$__live -> $__target"
        case wrong
            label red error "$__live is a link to "(readlink $__live)", not the repo -- leaving it alone"
            return 1
        case exists
            set -l __backup $__live.bak.(date +%Y%m%d-%H%M%S)
            mv $__live $__backup
            label yellow 'backed up' "$__live -> $__backup"
            mkdir -p (path dirname $__live)
            ln -sfn $__target $__live
            label green linked "$__live -> $__target"
        case missing
            mkdir -p (path dirname $__live)
            ln -sfn $__target $__live
            label green linked "$__live -> $__target"
    end
    return 0
end

function report_one --description 'Report the state of $argv[1] without changing it'
    set -l __live $argv[1]
    set -l __target $argv[2]

    switch (link_state $__live $__target)
        case ok
            label green ok "$__live -> $__target"
        case wrong
            label red wrong "$__live -> "(readlink $__live)" (want $__target)"
            return 1
        case exists
            label yellow 'not linked' "$__live is a real file/dir (want -> $__target)"
            return 1
        case missing
            label yellow missing "$__live does not exist (want -> $__target)"
            return 1
    end
    return 0
end

function walk_links --description 'Run $argv[1] over every managed entry, returning non-zero if any failed'
    set -l __action $argv[1]
    set -l __failed 0

    for item in $managed_links
        set -l __elements (string split ',' $item)
        $__action $__elements[1] $DOTFILE_REPO/$__elements[2]
        or set __failed 1
    end
    return $__failed
end

function update_brewfile
    printf '\n*************** Updating Brewfile ***************\n'
    pushd $DOTFILE_REPO/brew_packages
    command brew bundle dump -f
    set -l __status $status
    popd
    return $__status
end

function usage
    printf 'Usage: dotfile_repo_updater.fish [status|link|brew]\n\n'
    printf '  status   (default) report whether each config is linked into the repo\n'
    printf '  link     create or repair the links (install is accepted as an alias)\n'
    printf '  brew     dump brew_packages/Brewfile from the installed packages\n'
end

function main_fn
    set -l __command status
    if test (count $argv) -gt 0
        set __command $argv[1]
    end

    switch $__command
        case link install
            printf 'Linking configs into %s\n' $DOTFILE_REPO
            walk_links link_one
        case status
            printf 'Checking links against %s\n' $DOTFILE_REPO
            walk_links report_one
        case brew
            update_brewfile
        case '*'
            usage
            return 2
    end
end

main_fn $argv
