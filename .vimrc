" andrewwang2161's vimrc — defaults, no plugins.

set nocompatible
syntax on
filetype plugin indent on

set number
set relativenumber
set tabstop=2 shiftwidth=2 expandtab
set autoindent smartindent
set hlsearch incsearch ignorecase smartcase
set backspace=indent,eol,start
set laststatus=2
set ruler
set showcmd
set wildmenu
set t_Co=256
colorscheme desert

" fix paste-mode annoyance: F2 toggles paste
set pastetoggle=<F2>

" strip trailing whitespace on save for code files
autocmd BufWritePre *.py,*.js,*.sh,*.yml,*.yaml :%s/\s\+$//e
