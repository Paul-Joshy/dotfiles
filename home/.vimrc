set nocp
set background=dark
syntax on
set number
set relativenumber
set tabstop=4
set shiftwidth=4
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-commentary'
Plug 'morhetz/gruvbox'
Plug 'kien/ctrlp.vim'
Plug 'leafgarland/typescript-vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-abolish'
Plug 'vim-scripts/ReplaceWithRegister'

call plug#end()

colorscheme gruvbox

" snippets
inoremap (( ()<Esc>i
inoremap {{ {}<Esc>i
inoremap [[ []<Esc>i
inoremap "" ""<Esc>i
inoremap '' ''<Esc>i
inoremap `` ``<Esc>i
inoremap {<CR> {}<Esc>i<CR><Esc>kA<CR>
inoremap [<CR> []<Esc>i<CR><Esc>kA<CR>

nnoremap cl "+
" nnoremap cd :Codi
" vnoremap yc "+y
" map <C-z> "+p
" map <C=P> "+P
" nnoremap gc "+p
" nnoremap Gc "+P

" map escape key to caps lock
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
