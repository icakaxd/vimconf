syntax on
filetype plugin on
set number
set numberwidth=1
set tabstop=4
set shiftwidth=4
set nocompatible
set nowrap

set title
set wildmenu
set ruler
set cursorline

set smartindent
set autoindent
set expandtab
set pastetoggle=<F2>


if &term =~ '256color'
    set t_ut=
endif

autocmd BufEnter * :syntax sync fromstart



cmap w!! w !sudo tee % >/dev/null

set showcmd
set colorcolumn=180

inoremap # #

set expandtab
set smarttab
set mouse=c

"set ls=2  "Always show status line"

set hidden

set nolazyredraw
set showmatch
set encoding=utf8

set backspace=indent,eol,start

set nobackup
set noswapfile

language en_US

set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'Valloric/YouCompleteMe'
let g:plug_timeout = 120
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" Initialize plugin system
call plug#end()



" Javascript
au BufRead *.js set makeprg=jslint\ %
autocmd filetype javascript set sw=4 ts=4 expandtab
let g:acp_completeoptPreview=1

" HTML
autocmd BufNewFile,BufRead *.mako,*.mak,*.jinja2 setlocal ft=html
autocmd FileType html,xhtml,xml,css setlocal expandtab shiftwidth=4 tabstop=4

" Python
au FileType python set omnifunc=pythoncomplete#Complete
au FileType python setlocal expandtab shiftwidth=4 tabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
au FileType python set foldmethod=indent foldlevel=99

let g:flake8_cmd="/usr/bin/flake8"

let g:pyflakes_use_quickfix = 0
" Run pyflake8
autocmd FileType python map <Leader>8 :call Flake8()<CR>
" Run when saving py files
autocmd BufWritePost *.py call Flake8()

" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**

" Add the virtualenv's site-packages to vim path
if has('python')
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endif

" Load up virtualenv's vimrc if it exists
if filereadable($VIRTUAL_ENV . '/.vimrc')
    source $VIRTUAL_ENV/.vimrc
endif
