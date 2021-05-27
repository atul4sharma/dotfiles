#!/usr/local/bin/fish

set DOTFILE_REPO (pwd)

function check_diff --description 'Check diff status of two files'
    printf 'Comparing %s | %s\n' $argv[1] $argv[2]
    set -l __ignore_output = (diff -rq $argv[1] $argv[2])
    set -l __status $status
    if test $__status -eq 0
        printf '[%s%s%s]\n' (set_color -o green) 'No Diff' (set_color normal)
    else
        printf '[%s%s%s]\n' (set_color -o red) 'Diff' (set_color normal)
    end
    return $__status
end

function copy_from_to --description 'Copy files from $argv[1] to $argv[2]'
    printf 'Copying from %s -> %s\n' $argv[1] $argv[2]
    cp -r $argv[1] $argv[2]
end

set files_and_dirs_to_check \
    "$HOME/.vimrc,$DOTFILE_REPO/vim/vimrc" \
    "$HOME/.config/alacritty/alacritty.yml,$DOTFILE_REPO/alacritty/alacritty.yml" \
    "$HOME/.tmux.conf,$DOTFILE_REPO/tmux/tmux.conf" \
    "$HOME/.gitconfig,$DOTFILE_REPO/git_configs/gitconfig" \
    "$HOME/.gitignore_global,$DOTFILE_REPO/git_configs/gitignore_global" \
    "$HOME/.vim/coc-settings.json,$DOTFILE_REPO/vim/coc-settings.json" \
    "$HOME/.config/vim/,$DOTFILE_REPO/vim/configs/" \
    "$HOME/.config/fish/,$DOTFILE_REPO/fish_configs/" \
    "$HOME/.config/alacritty/,$DOTFILE_REPO/alacritty/"

function check_and_update_diffs
     printf '********************************************************************************\n'
     check_diff $argv[1] $argv[2]
     set -l __diff_status $status
     if test $__diff_status -ne 0
         copy_from_to $argv[1] $argv[2]
     end
end

function update_dotfiles --description 'Updates the dotfiles in git repo from the machine.\
    If install is passed as argument then it copies files from git repo to the machine location'

    if test (count $argv) -gt 0 && test $argv[1] = "install"
        printf 'Installing the configs\n'
        for item in $files_and_dirs_to_check
            set __elements (string split ',' $item)
            # Just the order has been reversed of elements
            check_and_update_diffs $__elements[2] $__elements[1]
        end
    else
        printf 'Syncing the git repo\n'
        for item in $files_and_dirs_to_check
            set __elements (string split ',' $item)
            check_and_update_diffs $__elements[1] $__elements[2]
        end
    end
end

function update_brewfile
    printf '\n\n*************** Updating Brewfile ***************\n'
    cd $DOTFILE_REPO/brew_packages
    command brew bundle dump -f --describe
    cd -
end

function main_fn
    update_dotfiles $argv
    update_brewfile
end

main_fn $argv

