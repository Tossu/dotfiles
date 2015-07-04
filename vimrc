call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'nvie/vim-flake8', { 'for': 'python' }
Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-airline'

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

"" invisible characters
set list
set listchars=tab:▸\ ,eol:¬,trail:·,nbsp:·

"" paste toggle (autoident screw paste)
set pastetoggle=<F2>

"" fix makefile tab identation
autocmd FileType make setlocal noexpandtab

" =======
" PLUGINS
" =======

if !has("gui_running")
    let g:solarized_termtrans=1
    let g:solarized_termcolors=256
endif

set background=dark
try
    colorscheme solarized
catch
endtry

"" let g:airline#extensions#tabline#enabled = 1
set laststatus=2

" List of buffers
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader>b :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>

nnoremap <silent> <Leader>e :FZF<CR>
