"" execute pathogen#infect()
filetype off
call pathogen#infect() 
call pathogen#helptags()

filetype on
syntax on
filetype plugin indent on

"" Paste toggle (autoident screw paste)
set pastetoggle=<F2>

"" Move between windows with alt+arrow
nmap <S-Up> :wincmd k<CR>
nmap <S-Down> :wincmd j<CR>
nmap <S-Left> :wincmd h<CR>
nmap <S-Right> :wincmd l<CR>

"" Fix make file stupid tabs
autocmd FileType make setlocal noexpandtab

"" Easier buffer menu
nnoremap <F5> :buffers<CR>:buffer<Space>

"" NERDTree
autocmd vimenter * NERDTree     " auto open
let NERDTreeIgnore = ['\.pyc$']

autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction


"" Synaptics
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jsxhint']

let g:syntastic_ignore_files = ['\.py$'] " vim-flake8 for python

"" Vim-airline visibile in single files
set laststatus=2


set nocompatible                " choose no compatibility with legacy vi
set number                      " line number
set encoding=utf-8
set showcmd                     " display incomplete commands
set colorcolumn=80              " display vertical line


"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter


"" Whitespace (Python PEP8)
set nowrap
set expandtab                   " space when tab
set textwidth=79                " lines longer than 79 columns will be broken
set shiftwidth=4                " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4                   " a hard TAB displays as 4 columns
set softtabstop=4               " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround                  " round indent to multiple of 'shiftwidth'
set autoindent                  " align the new line indent with the previous line
set backspace=indent,eol,start  " backspace through everything in insert mode


"" Invisible characters
set list
set listchars=tab:▸\ ,eol:¬,trail:·,nbsp:·
