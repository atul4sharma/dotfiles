
nnoremap <F2>  :setlocal number! <bar> setlocal relativenumber!<CR>
nnoremap <F5>  :source $MYVIMRC<CR>
nnoremap <F9>  gT
nnoremap <F10> gt

" better moving in split windows
nnoremap <c-j> <c-w>j
nnoremap <c-h> <c-w>h
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l


" resize current buffer by +/- 5 (used in split windows)
" M corresponds to Option key(⌥) in mac and alt key
nnoremap <M-left> :vertical resize -5<cr>
nnoremap <M-down> :resize +5<cr>
nnoremap <M-up> :resize -5<cr>
nnoremap <M-right> :vertical resize +5<cr>
