set clipboard=unnamedplus " make cliboard the default register
set undofile " Maintain undo history between session
set undodir=~/.vim/undodir
set spell
set nocp
set background=dark
syntax on
set number
set relativenumber
set tabstop=4
set shiftwidth=4
call plug#begin('~/.vim/plugged')

" Executes line written in shells and returns output
nnoremap Q !!$SHELL<CR>
" Space is the new save
nnoremap <Space>  :w<CR>

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
Plug 'tpope/vim-sensible'
Plug 'ledger/vim-ledger'
" Plug 'easymotion/vim-easymotion'
" Plug 'vim-syntastic/syntastic'
Plug 'vimwiki/vimwiki'

call plug#end()

colorscheme gruvbox

" snippets
inoremap (( ()<Esc>i
inoremap (; ();<Esc>hi
inoremap {{ {}<Esc>i
inoremap {; {};<Esc>hi
inoremap [[ []<Esc>i
inoremap "" ""<Esc>i
inoremap '' ''<Esc>i
inoremap `` ``<Esc>i
inoremap {<CR> {}<Esc>i<CR><Esc>kA<CR>
inoremap [<CR> []<Esc>i<CR><Esc>kA<CR>

nnoremap <C-q> "*y
" nnoremap cd :Codi
" vnoremap yc "+y
" map <C-z> "+p
" map <C=P> "+P
" nnoremap gc "+p
" nnoremap Gc "+P

" map escape key to caps lock
au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
au VimLeave * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

" au InsertEnter * set cul
" au InsertLeave * set nocul

" map virtual logical navigation to hjkl
" nnoremap h gh
nnoremap j gj
nnoremap k gk
" nnoremap l gl

" Syntastic defaults
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"get date
inoremap <C-d> <C-r>=strftime('%F')<CR>
