call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'neomake/neomake'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'

Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rking/ag.vim'

Plug 'nvie/vim-flake8'

Plug 'benjie/neomake-local-eslint.vim'

Plug 'kchmck/vim-coffee-script'

call plug#end()

imap jj <Esc>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

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

"" fix identations
map <F7> mzgg=G`z

"" change double quote strings to single quote
map <F8> :%s/"\(.\{-}\)"/'\1'/g

nnoremap <leader>; $A;

"" fix makefile tab identation
autocmd FileType make setlocal noexpandtab

let g:solarized_termcolors=256
colorscheme solarized

silent! nmap <F3> :NERDTree<CR>
silent! nmap <F4> :NERDTreeToggle<CR>
let NERDTreeWinSize = 55
let NERDTreeIgnore = ['\.pyc$']
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

"" close nerdtree if last window closed
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
    \ && b:NERDTree.isTabTree()) | q | endif

let g:neomake_javascript_enabled_makers = ['eslint']
autocmd InsertChange * update | Neomake

"" this needs xclip
vnoremap  <leader>y  "+y

let g:indentLine_char = '┆'

 map <F5> :Neomake<CR>
