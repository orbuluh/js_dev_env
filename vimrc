set undofile
set undodir=~/.vim/undo


" --- Vundle Header ---
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" --- Plugins ---

" 1. Appearnce related
Plugin 'tomasr/molokai'
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes' 
Plugin 'godlygeek/tabular'
Plugin 'preservim/vim-markdown'

" 2. IDE-like
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'vim-syntastic/syntastic'
"Plugin 'Valloric/YouCompleteMe'


" --- Vundle footer ---
call vundle#end()            " required
filetype plugin indent on    " required


" --- General Setting ---
set ruler
set number
" set mouse=a

" --- tab related ---
set tabstop=4
set softtabstop=0 expandtab
set shiftwidth=4
set smarttab
set backspace=indent,eol,start
set autoindent

" --- IDE like setting ---

set colorcolumn=110
highlight ColorColumn ctermbg=darkgray
if !exists("g:syntax_on")
	syntax enable
endif

" Automatically removing all trailing whitespace
autocmd FileType cc,c,cpp,java,h,C,H
	\ autocmd BufWritePre <buffer> %s/\s\+$//e

" Return to last edit position
autocmd BufReadPost * 
	\ if line("'\"") > 0 && line("'\"") <= line("$") | 
		\ exe "normal g`\"" | 

" Folding
" set foldmethod=syntax
" set foldcolumn=4


set ttyfast
set showcmd
set showmode
set wildmenu

set incsearch
set hlsearch
set showmatch
set wrapscan


" --- Appearance ---
" set background=dark
" colorscheme desert " solarized
set laststatus=2
let g:molokai_original = 1


" Use UTF-8 in default
set termencoding=utf-8
set encoding=utf-8
"language messages en_US
set fileencodings=utf-8,big5,ucs-bom,latin1     "when reading files
set fileencoding=utf-8      "when creating files
set nobomb                  "no BOM in the file head

" Fix home/end key in all modes
map <esc>OH <home>
cmap <esc>OH <home>
imap <esc>OH <home>
map <esc>OF <end>
cmap <esc>OF <end>
imap <esc>OF <end>

" \c: toggle cursorline
nnoremap <Leader>c :set invcursorline<CR>
" \n: count search match
nnoremap <Leader>n :%s///gn<CR>
" \s: source vimrc
nnoremap <Leader>s :source ~/.vimrc<CR>
" \p: switch paste mode
nnoremap <Leader>p :set paste!<CR>:set paste?<CR>


" --- Package: airline ---
let g:airline_powerline_fonts=1
let g:airline_detect_paste=1
" let g:airline#extensions#tabline#enabled=1
let g:airline_theme='jellybeans'


" --- Package: nerdTree ---
map <C-n> :NERDTreeToggle<CR>
map <Leader>n <plug>NERDTreeTabsToggle<CR>
" let g:nerdtree_tabs_open_on_console_startup = 1

" --- Package: syntastic ---

let g:syntastic_cpp_checkers = ['clang_check', 'gcc']
let g:syntastic_cpp_compiler = 'clang'
let g:syntastic_cpp_compiler_options = '-std=c++20'
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END

"let g:ycm_server_keep_logfiles = 1
"let g:ycm_server_log_level = 'debug'

set  wrap
