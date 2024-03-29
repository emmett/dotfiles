syntax on
set background=dark
autocmd vimenter * silent! lcd %:p:h
set autochdir

" Remap j/k and :
nnoremap j gj
nnoremap k gk
nnoremap ; :

scriptencoding utf-8
set encoding=utf-8

filetype on
filetype plugin on
filetype indent on
set ft=html.javascript

set textwidth=0
set wrapmargin=0
set wrap


highlight ColorColumn ctermbg=White ctermfg=Black
call matchadd('ColorColumn', '\%81v', 100)

onoremap <silent> j gj
onoremap <silent> k gk

" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=.,$TEMP
if exists("&undodir")
  set undodir=~/.vim/undo
endif

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Highlight current line
set cursorline
" Make tabs as wide as four spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
" Set autoindent to 4 spaces
set shiftwidth=4
" Show “invisible” characters
set listchars=tab:\|\ ,trail:·,eol:¬,nbsp:_
set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
set title titlestring=
" Show the (partial) command as it’s being typed
set showcmd
" Use relative line numbers
if exists("&relativenumber")
  set relativenumber
  au BufReadPost * set relativenumber
endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Strip trailing whitespace (,ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Change newlines
function! MetaChar()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\r\(\n\)/\1/g
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction

noremap <leader>m :call MetaChar()<CR>

function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  else
    if (expand("%:t") != '')
      exe ":NERDTreeFind"
    else
      exe ":NERDTreeToggle"
    endif
  endif
endfunction
" Set Nerd Tree Toggle

map <Tab> :call NERDTreeToggleInCurDir()  <CR>
" Set clear highlight
map _ :nohl<CR>
"
" In ~/.vim/vimrc, or somewhere similar.
let g:ale_linters = {
            \   'javascript': ['eslint'],
            \   'python': ['flake8']
            \ }

" Automatic commands
if has("autocmd")
  " Enable file type detection
  filetype on
  " Treat .json files as .js
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
endif

noremap <leader>n :lnext<CR>
noremap <leader>b :lprevious<CR>
set wildignore=*.swp,*.bak,*.pyc,*.class,*.jar,*.gif,*.png,*.jpg
