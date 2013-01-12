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

syntax enable
filetype plugin indent on

runtime macros/editexisting.vim
