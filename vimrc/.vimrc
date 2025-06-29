set nocp

" Set font for GUI clients
set guifont=JetBrainsMono\ Nerd\ Font:h12

call plug#begin()
Plug 'itchyny/lightline.vim'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'preservim/vim-pencil'
Plug 'scrooloose/syntastic'
Plug 'dylanaraps/wal.vim'

call plug#end()

colorscheme catppuccin_mocha

let g:lightline = {}
let g:lightline.colorscheme = 'catppuccin_mocha'
let g:lightline.active = {}
let g:lightline.active.left = [['mode', 'paste'], ['filename']]
let g:lightline.active.right = [['lineinfo']]

" Configure Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" State tracking variables
let g:write_mode_active = 0
let g:edit_mode_active = 0

function! WriteMode()
  if g:write_mode_active
    " Disable write mode features
    Goyo!
    Limelight!
    SoftPencil
    let g:write_mode_active = 0
  else
    " Enable write mode features
    Goyo
    Limelight
    SoftPencil
    let g:write_mode_active = 1
    " Ensure edit mode is off
    if g:edit_mode_active
      call EditMode()
    endif
  endif
endfunction

function! EditMode()
  if g:edit_mode_active
    " Disable edit mode features
    setlocal nospell
    SyntasticReset
    let g:edit_mode_active = 0
  else
    " Enable edit mode features
    setlocal spell
    setlocal spelllang=en_us
    SyntasticCheck
    let g:edit_mode_active = 1
    " Ensure write mode is off
    if g:write_mode_active
      call WriteMode()
    endif
  endif
endfunction

set number
set relativenumber
set mouse=a
set clipboard=unnamedplus
set expandtab
set shiftwidth=2
set tabstop=2
set smartindent
set wrap
set termguicolors
set signcolumn=yes
set updatetime=300
set splitright
set splitbelow
set scrolloff=5

" Keymaps for comfort
nnoremap <leader>pv :NERDTreeToggle<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <leader>g :Rg<CR>

" Leader key
let mapleader = ' '

nnoremap <leader>w :call WriteMode()<CR>
nnoremap <leader>e :call EditMode()<CR> 

" Visual select keybindings
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Remove background color for Normal mode
hi Normal guibg=NONE ctermbg=NONE
