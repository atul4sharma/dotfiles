" ----------------------------------------------
" FZF plugin settings
" ----------------------------------------------
nnoremap <C-F> :Files<CR>
nnoremap <C-B> :Buffers<CR>

" Always enable preview window on the right with 40% width
let g:fzf_layout={'down':'~40%'}
" let g:fzf_colors={'border':  ['fg', 'Conditional', 'Bright']}
"
command! -nargs=? Tabe :tabe|Files <args>

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" install fzf on system first and add config directory as runtime path
set rtp+=/usr/local/opt/fzf

