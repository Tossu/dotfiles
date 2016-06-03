call plug#begin('~/.vim/plugged')

Plug 'nvie/vim-flake8'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree'
Plug 'kchmck/vim-coffee-script'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'rking/ag.vim'

call plug#end()

" ================
" GENERAL SETTINGS
" ================

imap jj <Esc>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

filetype on
syntax on
filetype plugin indent on

let mapleader = ","

set nocompatible                " choose no compatibility with legacy vi
set number                      " line number
set encoding=utf-8
set showcmd                     " display incomplete commands

"" searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"" whitespace (Python PEP8)
set nowrap
set expandtab                   " space when tab
set textwidth=79                " lines longer than 79 columns will be broken
set shiftwidth=4                " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4                   " a hard TAB displays as 4 columns
set softtabstop=4               " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround                  " round indent to multiple of 'shiftwidth'
set autoindent                  " align the new line indent with the previous line
set backspace=indent,eol,start  " backspace through everything in insert mode

"" displays vertical line
if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

"" invisible characters (ttf-droid)
set list
set listchars=tab:▸\ ,eol:¬,trail:·,nbsp:·

"" paste toggle (autoident screw paste)
set pastetoggle=<F2>

"" fix makefile tab identation
autocmd FileType make setlocal noexpandtab

"" statusline

set laststatus=2

set statusline=%f                               " file name
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, " file encoding
set statusline+=%{&ff}]                         " file format
set statusline+=%y                              " filetype
set statusline+=%h                              " help file flag
set statusline+=%m                              " modified flag
set statusline+=%r                              " read only flag

set statusline+=\ %=                        " align left
set statusline+=Line:%l/%L[%p%%]            " line X of Y [percent of file]
set statusline+=\ Col:%c                    " current column
set statusline+=\ Buf:%n                    " Buffer number
set statusline+=\ [%b][0x%B]\               " ASCII and byte code under cursor


" =======
" PLUGINS
" =======

""" if !has("gui_running")
"    let g:solarized_termtrans=1
let g:solarized_termcolors=256
" endif

set background=light
try
    colorscheme solarized
catch
endtry

nnoremap <silent> <Leader>e :FZF<CR>

"" NERDTree toggle
silent! nmap <F3> :NERDTreeToggle<CR>
let NERDTreeWinSize = 55
let NERDTreeIgnore = ['\.pyc$']
