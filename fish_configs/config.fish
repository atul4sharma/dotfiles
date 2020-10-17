

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


alias g11='g++ -std=c++11 -Wall'
alias g14='g++ -std=c++14 -Wall'
alias g17='g++ -std=c++17 -Wall'

# alias MAIN="cp -r /home/atul/cpp_practice_github/skeleton_code/ ./ && mv skeleton_code/* . && rmdir skeleton_code"

alias vp="vim -p"
alias tmux="tmux -u"

alias ...="cd ../../../"

## git aliases
alias gst="git status"
alias gd="git diff"
alias gds="git diff --staged"
alias gl="git log --pretty=format:'%C(bold blue)%><(10)%h %C(green)%<(15)%cr %C(red)%><(20)%an %C(cyan)|%C(reset) %s %C(bold yellow)%d' -20"
alias gcm="git checkout master"

## golang paths
## https://medium.com/@jimkang/install-go-on-mac-with-homebrew-5fa421fc55f5
set -x GOPATH $HOME/code/go
set -x GOROOT (brew --prefix golang)/libexec
set -x PATH $PATH {$GOPATH}/bin {$GOROOT}/bin


########################################
## qt installation
#
#  steps done: 
#  brew install qt
#  brew link qt --force
#  returned -> /usr/local/Cellar/qt/5.15.1
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
