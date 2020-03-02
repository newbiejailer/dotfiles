let mapleader=" "

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
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf'

call plug#end()

" colors
if &t_Co == 256
    colorscheme pixelmuerto
endif

" basic settings
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

" auto compile and run cpp file
autocmd filetype cpp nnoremap <C-c> :w <bar> !clear && g++ -std=c++11 % -Wall -o %.exe && ./%.exe<CR>

" Customize our status line
set statusline=%f%m%r%h%w\
set statusline+=[%{&ff}]
set statusline+=%=
set statusline+=[\%03.3b/\%02.2B]\ [POS=%04v]

" coc
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" nerdtree
map <LEADER>n :NERDTreeToggle<CR>

" ctrlp
let g:ctrlp_working_path_mode = 'wra'
