

## These were mentioned by the llvm installation
set -x PATH /usr/local/opt/llvm/bin $PATH
set -x LDFLAGS "-L/usr/local/opt/llvm/lib" $LDFLAGS
set -x CPPFLAGS "-I/usr/local/opt/llvm/include" $CPPFLAGS

## icu4c is keg-only, which means it was not symlinked into /usr/local,
## because macOS provides libicucore.dylib (but nothing else).
##
## If you need to have icu4c first in your PATH run:
##   echo 'set -g fish_user_paths "/usr/local/opt/icu4c/bin" $fish_user_paths' >> ~/.config/fish/config.fish
##   echo 'set -g fish_user_paths "/usr/local/opt/icu4c/sbin" $fish_user_paths' >> ~/.config/fish/config.fish
##
## For compilers to find icu4c you may need to set:
##   set -gx LDFLAGS "-L/usr/local/opt/icu4c/lib"
##   set -gx CPPFLAGS "-I/usr/local/opt/icu4c/include"

## Sourcing $HOME/.profile for rust tools availability
source $HOME/.profile
alias cb='cargo build'
alias cr='cargo run'

# alias MAIN="cp -r /home/atul/cpp_practice_github/skeleton_code/ ./ && mv skeleton_code/* . && rmdir skeleton_code"

alias vp="vim -p"
alias nv="nvim"
alias tmux="tmux -u"

alias ...="cd ../../"

alias download="aria2c -s16 -x16"

## git aliases
alias gst="git status"
alias gd="git diff"
alias gds="git diff --staged"
alias glog="git log --pretty=format:'%C(bold blue)%><(10)%h %C(green)%<(15)%cr %C(red)%><(20)%an %C(cyan)|%C(reset) %s %C(bold yellow)%d'"
alias gcm="git checkout master"
alias gl="glog -20"

## golang paths
## https://medium.com/@jimkang/install-go-on-mac-with-homebrew-5fa421fc55f5
set -x GOROOT (brew --prefix golang)/libexec
set -x PATH $PATH {$GOROOT}/bin
## this is for golibraries
set -x GOPATH $HOME/code/go/golib
set -x PATH $PATH {$GOPATH}/bin
## this is for my local binaries
set -x GOPATH $GOPATH $HOME/code/go/development

########################################
## qt installation
#
#  steps done:
#  brew install qt
#  brew link qt --force
#  returned -> /usr/local/Cellar/qt/5.15.1
#  /usr/local/Cellar/qt/6.1.0_1
#
# qt is keg-only, which means it was not symlinked into /usr/local,
# because Qt 5 has CMake issues when linked.
#
# If you need to have qt first in your PATH run:
#   echo 'set -g fish_user_paths "/usr/local/opt/qt/bin" $fish_user_paths' >> ~/.config/fish/config.fish
set -g fish_user_paths "/usr/local/opt/qt/bin" $fish_user_paths
#
# For compilers to find qt you may need to set:
set -gx LDFLAGS "-L/usr/local/opt/qt/lib"
set -gx CPPFLAGS "-I/usr/local/opt/qt/include"
#
# For pkg-config to find qt you may need to set:
set -gx PKG_CONFIG_PATH "/usr/local/opt/qt/lib/pkgconfig"
#
########################################


########################################
## qt@5 installation
#
#  steps done:
#  brew install qt@5
#
#qt@5 is keg-only, which means it was not symlinked into /usr/local,
#because this is an alternate version of another formula.

#If you need to have qt@5 first in your PATH, run:
#echo 'fish_add_path /usr/local/opt/qt@5/bin' >> ~/.config/fish/config.fish

#For compilers to find qt@5 you may need to set:
set -gx LDFLAGS "-L/usr/local/opt/qt@5/lib"
set -gx CPPFLAGS "-I/usr/local/opt/qt@5/include"

#For pkg-config to find qt@5 you may need to set:
set -gx PKG_CONFIG_PATH "/usr/local/opt/qt@5/lib/pkgconfig"
#
fish_add_path /usr/local/opt/qt@5/bin
########################################

########################################
## docker aliases to make application call easier
#
# https://github.com/asciinema/asciicast2gif
alias asciicast2gif 'docker run --rm -v $PWD/:/data --workdir /data asciinema/asciicast2gif'
alias jupyter 'docker run --rm -v $HOME/:/home/jovyan --rm -p 8888:8888 jupyter/datascience-notebook'
alias linux_gcc 'docker run --rm -v $PWD/:/home/ --interactive --tty -w /home/ gcc /bin/bash'
########################################

# invoke_gcc is a custom function in ~/.config/fish/functions/
alias g11 'invoke_gcc 11'
alias g14 'invoke_gcc 14'
alias g17 'invoke_gcc 17'
alias g20 'invoke_gcc 2a'

#######################################
# required by binutils package
set -g fish_user_paths "/usr/local/opt/binutils/bin" $fish_user_paths
set -gx LDFLAGS "-L/usr/local/opt/binutils/lib"
set -gx CPPFLAGS "-I/usr/local/opt/binutils/include"


#######################################
# fzf default options
set -x FZF_DEFAULT_OPTS "-m --height 40% --layout=reverse"
#set -x FZF_DEFAULT_OPTS "--height 40% --layout=reverse --preview='bat --style=numbers --color=always --line-range :20 {}'"
set -x FZF_DEFAULT_COMMAND "rg --glob '!{llvm-project/*}' --glob '!{code/go/golib/*}' --glob '!{Movies/*}' --glob '!{Music/*}' --glob '!{Applications/*}' --files --color never"


#######################################
# Added a tool compiledb to generate compile_commands.json for non-cmake systems
# https://github.com/nickdiego/compiledb
#######################################


#######################################
# Set PATH for ruby
fish_add_path /usr/local/opt/ruby/bin
#######################################
#For compilers to find ruby you may need to set:
#set -gx LDFLAGS "-L/usr/local/opt/ruby/lib"
#set -gx CPPFLAGS "-I/usr/local/opt/ruby/include"
#
#For pkg-config to find ruby you may need to set:
#set -gx PKG_CONFIG_PATH "/usr/local/opt/ruby/lib/pkgconfig"

fish_add_path /Users/atul/.local/share/gem/ruby/3.0.0/bin
#fish_add_path /usr/local/lib/ruby/gems/3.0.0/bin/


