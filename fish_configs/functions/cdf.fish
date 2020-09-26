function cdf --description "cd to the directory mentioned by you by the fzf"
  if test (count $argv) -lt 1
    set wdir .
  else
    set wdir $argv
  end
  set dir (find $wdir -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) && cd "$dir"
end
