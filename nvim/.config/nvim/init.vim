let mapleader=" "

" Plugin auto install
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'

" Auto completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fuzzy find
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Syntax highlight
Plug 'sheerun/vim-polyglot'

call plug#end()

" Colors
if &t_Co == 256
    " If we're on a 256-color terminal, use pixelmuerto color scheme
    colorscheme pixelmuerto
else
    " Else fall back to ron
    colorscheme ron
    hi CursorLine term=bold cterm=bold guibg=Grey40
endif

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
filetype indent plugin on
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

set colorcolumn=80
" highlight colorcolumn ctermbg=236

" Basic map
noremap <LEADER><CR> :nohlsearch<CR>
noremap ; :
noremap s <nop>
noremap S :w<CR>
noremap Q :q<CR>
noremap R :source $MYVIMRC<CR>
inoremap jj <ESC>
nnoremap Y y$
vnoremap <LEADER>y "+y

" Terminal
autocmd TermOpen term://* startinsert
tnoremap <Esc> <C-\><C-n>
nnoremap <silent> <LEADER>t :bo 15sp +term<CR>
" tnoremap <LEADER>t <C-\><C-n><C-w>q

" Window resize
map <up> :res +2<CR>
map <down> :res -2<CR>
map <left> :vertical resize-2<CR>
map <right> :vertical resize+2<CR>

" Fzf mappings
nnoremap <silent> <leader>o :Files<CR>
nnoremap <silent> <leader>p :GFiles<CR>
nnoremap <silent> <leader>b :Buffers<CR>

" Nerdtree
map <LEADER>n :NERDTreeToggle<CR>

" Customize our status line
set statusline=%f%m%r%h%w\
set statusline+=[%{&ff}]
set statusline+=%=
set statusline+=%{coc#status()}
set statusline+=%=
set statusline+=[\%03.3b/\%02.2B]\ [POS=%04v]

" Coc
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
" set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" coc code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-s>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories= [$HOME.'/.config/nvim/UltiSnips', 'UltiSnips']

" python provider
let g:python3_host_prog="$HOME/anaconda3/bin/python3"

" Vim commentary
autocmd filetype cpp setlocal commentstring=//\ %s

" yaml file indent
autocmd filetype yaml setlocal ts=2 sts=2 sw=2 expandtab

" Compile function
noremap <LEADER>r :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ -std=c++11 % -Wall -o %<"
        :bo 10sp
        :term ./%<
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        :bo sp
        :term python %
    elseif &filetype == 'html'
        silent! exec "!".g:mkdp_browser." % &"
    elseif &filetype == 'markdown'
        exec "MarkdownPreview"
    elseif &filetype == 'tex'
        silent! exec "VimtexStop"
        silent! exec "VimtexCompile"
    elseif &filetype == 'dart'
        CocCommand flutter.run
    elseif &filetype == 'go'
        :bo sp
        :term go run %
    endif
endfunc
