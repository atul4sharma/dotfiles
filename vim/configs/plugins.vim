

" this needs vim-plug to be installed
" https://github.com/junegunn/vim-plug
" call :PlugInstall to install all the mentioned plugins
call plug#begin()

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'chrisbra/unicode.vim'

Plug 'rust-lang/rust.vim'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'dag/vim-fish'

" -----------------------------------------
" vim lsp 
" -----------------------------------------
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" -----------------------------------------

call plug#end()

" airline theme
let g:airline_theme='molokai'

