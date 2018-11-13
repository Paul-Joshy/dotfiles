syntax on
set autoindent
set nocompatible
set noexpandtab
set number
set relativenumber
set shiftwidth=4
set softtabstop=4
set tabstop=4

inoremap "" ''<Esc>i
inoremap '' ''<Esc>i
inoremap (( ()<Esc>i
inoremap [[ []<Esc>i
inoremap {{ {}<Esc>i
nnoremap cl "+
" nnoremap cd :Codi
" vnoremap yc "+y
" map <C-z> "+p
" map <C=P> "+P
" nnoremap gc "+p
" nnoremap Gc "+P

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'

call plug#begin('~/.vim/plugged')
" Plug 'kien/ctrlp.vim' Depreciated
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-system-copy'
Plug 'christoomey/vim-titlecase'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'leafgarland/typescript-vim'
Plug 'mattn/emmet-vim'
Plug 'metakirby5/codi.vim'
Plug 'moll/vim-node'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-jdaddy'
Plug 'Quramy/tsuquyomi'
" Initialize plugin system
call plug#end()

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:syntastic_javascript_checkers = ['jshint']
