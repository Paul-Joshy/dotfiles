" let g:ctrlp_user_command = [
"     \ '.git', 'cd %s && git ls-files . -co --exclude-standard',
"     \ 'find %s -type f'
"     \ ]

" let g:Powerline_symbols = 'fancy'
set nocompatible              " be iMproved, required
filetype off                  " required
set autoindent
set shiftwidth=4
set softtabstop=4
set paste
set backspace=2
set number
set nowrapscan
set relativenumber
set path+=**
colorscheme wombat256mod
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'isRuslan/vim-es6'
Plugin 'https://github.com/tpope/vim-sensible.git'
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'https://github.com/vim-syntastic/syntastic.git'
Plugin 'https://github.com/pangloss/vim-javascript.git'
Plugin 'https://github.com/kien/ctrlp.vim.git'
Plugin 'https://github.com/907th/vim-auto-save.git'
Plugin 'francoiscabrol/ranger.vim'
Plugin 'https://github.com/Lokaltog/vim-powerline.git'
Plugin 'https://github.com/airblade/vim-gitgutter.git'
Plugin 'mattn/emmet-vim'
Plugin 'https://github.com/ervandew/supertab.git'
Plugin 'https://github.com/tpope/vim-surround.git'
Plugin 'https://github.com/tpope/vim-fugitive.git'
Plugin 'https://github.com/greyblake/vim-preview.git'
Plugin 'https://github.com/terryma/vim-multiple-cursors.git'
Plugin 'VincentCordobes/vim-translate'
Plugin 'echuraev/translate-shell.vim'
Plugin 'https://github.com/mattn/googletranslate-vim.git'
Plugin 'https://github.com/leafgarland/typescript-vim.git'
Plugin 'https://github.com/tpope/vim-commentary.git'
Plugin 'https://github.com/tpope/vim-jdaddy.git'
" Bundle 'Rykka/trans.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"inoremap {      {}<Left>
"inoremap {<CR>  {<CR>}<Esc>O
"inoremap {{     {
"inoremap {}     {}
"set foldmethod=syntax
set foldcolumn=1
let javaScript_fold=1
set foldlevelstart=99
set pastetoggle=<F2>

"Map Ctrl-C and Ctrl-V
vnoremap <C-c> "+y
noremap <C-z> "+P
noremap <C-x> "+d


nnoremap ejs i<%=  %><Esc>3hi 

"Map caps lock to escape
au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

"Toggle page numbers
map <F2> :set invnumber
map <F3> :set invrelativenumber
nnoremap gi I<CR><Esc>kI

"Map Ctrl-A
map <C-a> gg0VG

let g:syntastic_typescript_tsc_fname = ''
nnoremap cs" Bi"<Esc>Ei"<Esc>

"snipppets
inoremap { {}<Esc>i
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i
