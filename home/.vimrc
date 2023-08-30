set nocp
set number
syntax on

set autoindent
set nocompatible
set noexpandtab
set relativenumber
set shiftwidth=4
set softtabstop=4
set tabstop=4
filetype on
filetype plugin on
filetype indent on
set cursorline
" set cursorcolumn
set scrolloff=10
set incsearch
set smartcase
set showcmd
set hlsearch
set showmatch
set history=1000
set wildmenu
set wildmode=list:longest
set path+=**

inoremap "" ""<Esc>i
inoremap '' ''<Esc>i
inoremap (( ()<Esc>i
inoremap [[ []<Esc>i
inoremap {{ {}<Esc>i
nnoremap cl "+

" For easy scrolling
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-commentary'
Plug 'morhetz/gruvbox'
" Plug 'kien/ctrlp.vim'
Plug 'leafgarland/typescript-vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-abolish'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'tpope/vim-sensible'
Plug 'ledger/vim-ledger'
Plug 'morhetz/gruvbox'
Plug 'mmai/vim-zenmode'
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'junegunn/goyo.vim'
Plug 'preservim/vim-pencil'
Plug 'preservim/vim-autocorrect'
" Plug 'preservim/vim-litecorrect'
Plug 'junegunn/limelight.vim'

" Plug 'nvim-treesitter/nvim-treesitter'
" Plug 'nvim-orgmode/orgmode'
" Plug 'vim-syntastic/syntastic'
Plug 'mattn/emmet-vim'

call plug#end()

colorscheme gruvbox
set background=dark

" let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" let &t_SR = "\<Esc>]50;CursorShape=2\x7"
" let &t_EI = "\<Esc>]50;CursorShape=0\x7"

let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)


" Zenmode config
let g:zenmode_background = "dark"
let g:zenmode_colorscheme = "gruvbox"
" let g:zenmode_font ="Cousine 12"

" ---------------------------------------------
" Limelight config - Don't touch
" ---------------------------------------------
" let g:limelight_conceal_ctermfg = '#454d5a'
let g:limelight_conceal_guifg = '#454d5a'
let g:limelight_conceal_ctermfg = 240
"
" Fix to allow transparent background
hi Normal ctermbg=NONE guibg=NONE
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 100

" Color name (:help gui-colors) or RGB color
" let g:limelight_conceal_guifg = '#83a598'
" ---------------------------------------------
"  End of Limelight config
" ---------------------------------------------


"litecorrect config

" Disabled settings
" augroup litecorrect
"   autocmd!
"   autocmd FileType markdown,mkd call litecorrect#init()
"   autocmd FileType textile call litecorrect#init()
" augroup END

" nnoremap <C-s> [s1z=<c-o>
" inoremap <C-s> <c-g>u<Esc>[s1z=`]A<c-g>u

" 
