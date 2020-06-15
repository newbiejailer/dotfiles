let mapleader=" "

" Basic settings
syntax on

set noswapfile
set number
set relativenumber
" set cursorline
set wrap
set wildmenu

set hlsearch
exec "nohlsearch"
set incsearch

set ignorecase
set smartcase

set nocompatible
set showcmd
filetype plugin indent on
set mouse-=a
set encoding=utf-8
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set scrolloff=5
set tw=0
set indentexpr=
set backspace=indent,eol,start
set path=.,**
set cino+=g0

set list
set listchars=tab:▸\ ,eol:¬

set laststatus=2
set autochdir
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Basic map
noremap J 5j
noremap K 5k
noremap <LEADER><CR> :nohlsearch<CR>
noremap ; :
noremap s <nop>
noremap S :w<CR>
noremap Q :q<CR>
noremap R :source $MYVIMRC<CR>
inoremap jj <ESC>
nnoremap Y y$
vnoremap <LEADER>y "+y

" Window resize
map <up> :res +2<CR>
map <down> :res -2<CR>
map <left> :vertical resize-2<CR>
map <right> :vertical resize+2<CR>
