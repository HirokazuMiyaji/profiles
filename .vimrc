" =============================================================================
" .vimrc
" =============================================================================
" Initialize {{{

set nocompatible

let s:is_windows = has('win32') || has('win64')


" }}}

augroup MyAutoCmd
  autocmd!
augroup END

" Vundle {{{

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'git@github.com:vim-ruby/vim-ruby.git'
Bundle 'git@github.com:tpope/vim-rails.git'
Bundle 'git@github.com:Shougo/neocomplcache.git'
Bundle 'git@github.com:Shougo/unite.vim.git'
Bundle 'git@github.com:thinca/vim-quickrun.git'
Bundle 'git@github.com:Shougo/vimshell.git'
Bundle 'git@github.com:mattn/zencoding-vim.git'
Bundle 'git@github.com:jmcantrell/vim-virtualenv.git'
Bundle 'git@github.com:davidhalter/jedi-vim.git'
Bundle 'git@github.com:tpope/vim-repeat.git'
Bundle 'git@github.com:tpope/vim-surround.git'

" }}}

" Ignore the case of normal letters
set ignorecase
" If the search pattern contains uppter case characters, override the 'ignorecase' option.
set smartcase
" Use incremental search.
set incsearch
" Do not highlight search result.
set hlsearch
nohlsearch
" Searches wrap around the end of the file.
set wrapscan

" Tab and spaces

" Number of spaces that a <Tab> in the file counts for.
set tabstop=2
" Number of spaces to use for each step of indent.
set shiftwidth=2
" Expand tab to spaces.
set expandtab
" Smart autoindenting.
set autoindent
set smartindent
" Round indent to multiple of 'shiftwidth'.
set shiftround
" Enable modeline.
set modeline

set number

syntax enable
filetype plugin indent on

runtime macros/editexisting.vim
