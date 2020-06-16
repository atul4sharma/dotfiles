

## These were in my zshrc
set -x GYP_GENERATORS ninja
set -x PATH /home/atul/.gem/ruby/2.7.0/bin $PATH
set -x PATH /home/atul/.local/bin $PATH
set -x QT_QUICK_CONTROLS_STYLE org.kde.desktop

set -x PATH /home/atul/perl5/bin $PATH
set -x PERL5LIB /home/atul/perl5/lib/perl5 $PERL5LIB
set -x PERL_LOCAL_LIB_ROOT /home/atul/perl5 $PERL_LOCAL_LIB_ROOT
set -x PERL_MB_OPT "--install_base \"/home/atul/perl5\""
set -x PERL_MM_OPT INSTALL_BASE=/home/atul/perl5


alias wifi='sudo wifi-menu'
alias mysql='mysql -u root -p'

alias g11='g++ -std=c++11 -Wall'
alias g14='g++ -std=c++14 -Wall'
alias g17='g++ -std=c++17 -Wall'

alias MAIN="cp -r /home/atul/cpp_practice_github/skeleton_code/ ./ && mv skeleton_code/* . && rmdir skeleton_code"

alias vp="vim -p"
alias tmux="tmux -u"

## git aliases
alias gits="git status"
