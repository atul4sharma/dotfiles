" ----------------------------------------------
" FZF plugin settings
" ----------------------------------------------

" Always enable preview window on the right with 40% width
let g:fzf_layout={'down':'~40%'}
" let g:fzf_colors={'border':  ['fg', 'Conditional', 'Bright']}
"
command! -nargs=? Tabe :tabe|Files <args>

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" install fzf on system first and add config directory as runtime path
set rtp+=/usr/local/opt/fzf

command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)


" key mappings
" https://dev.to/iggredible/how-to-search-faster-in-vim-with-fzf-vim-36ko
" <leader> key is \
nnoremap <C-f> :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>f :Rg<CR>
nnoremap <Leader>/ :Lines<CR>
nnoremap <Leader>' :Marks<CR>
nnoremap <Leader>g :Commits<CR>
nnoremap <Leader>H :Helptags<CR>
nnoremap <Leader>hh :History<CR>
nnoremap <Leader>h: :History:<CR>
nnoremap <Leader>h/ :History/<CR>

