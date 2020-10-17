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

function main_fn
    set -l file_list_to_check \
        "$HOME/.vimrc,$DOTFILE_REPO/vim/vimrc" \
        "$HOME/.config/alacritty/alacritty.yml,$DOTFILE_REPO/alacritty/alacritty.yml" \
        "$HOME/.tmux.conf,$DOTFILE_REPO/tmux/tmux.conf" \
        "$HOME/.gitconfig,$DOTFILE_REPO/git_configs/gitconfig" \
        "$HOME/.gitignore_global,$DOTFILE_REPO/git_configs/gitignore_global" \
        "$HOME/.config/fish/,$DOTFILE_REPO/fish_configs/"

    for item in $file_list_to_check
        set __elements (string split ',' $item)
        printf '********************************************************************************\n'
        check_diff $__elements[1] $__elements[2]
        set -l __diff_status $status
        if test $__diff_status -ne 0
            copy_from_to $__elements[1] $__elements[2]
        end
    end
end

main_fn

