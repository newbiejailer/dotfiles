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

" Auto completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fuzzy find
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Colorscheme
Plug 'joshdick/onedark.vim'

" Syntax highlight
Plug 'sheerun/vim-polyglot'

call plug#end()

" Colors
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

" onedark.vim override: Don't set a background color when running in a terminal;
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif

colorscheme onedark

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
