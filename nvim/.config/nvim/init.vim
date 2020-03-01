" plugin auto install
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugin
call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'jiangmiao/auto-pairs'
Plug 'ctrlpvim/ctrlp.vim'

call plug#end()

" ctrlp
let g:ctrlp_working_path_mode = 'wra'

" colors
if &t_Co == 256
    colorscheme pixelmuerto
endif

" basic settings
let mapleader=" "
syntax on

set noswapfile
set number
set relativenumber
set cursorline
set wrap
set wildmenu

set hlsearch
exec "nohlsearch"
set incsearch

set ignorecase
set smartcase

set nocompatible
set showcmd
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set mouse-=a
set encoding=utf-8
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set scrolloff=5
set tw=0
set indentexpr=
set backspace=indent,eol,start
set path=.,**

set laststatus=2
set autochdir
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" basic map
noremap J 5j
noremap K 5k
noremap <LEADER><CR> :nohlsearch<CR>
noremap ; :
noremap s <nop>
noremap S :w<CR>
noremap Q :q<CR>
noremap R :source $MYVIMRC<CR>
inoremap jj <ESC>
vnoremap <LEADER>y "+y

" window resize
map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

" Enable true color
" if exists('+termguicolors')
"   let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"   let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"   set termguicolors
"   set t_Co=256
"   endif

" auto compile and run cpp file
autocmd filetype cpp nnoremap <C-c> :w <bar> !clear && g++ -std=c++11 % -Wall -o %.exe && ./%.exe<CR>
