if &compatible
  set nocompatible
endif

language message C

" Key mapping
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Encoding
scriptencoding utf-8
set encoding=utf-8
set fileformat=unix
set fileformats=unix,dos,mac
set ambiwidth=double
set fileencoding=utf8
set fileencodings=utf-8,sjis,iso-2022-jp,euc-jp

augroup MyAutoCmd
  autocmd!
augroup END

set runtimepath^=~/.vim/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim'))

call dein#add('Shougo/dein.vim')

call dein#add('itchyny/lightline.vim')
call dein#add('Yggdroot/indentLine')

" HTML / CSS / Javascript
call dein#add('hail2u/vim-css3-syntax')
call dein#add('othree/html5.vim')
call dein#add('cakebaker/scss-syntax.vim')

" TypeScript
call dein#add('leafgarland/typescript-vim') 

" Elixir
call dein#add('elixir-lang/vim-elixir')

" Python
call dein#add('tell-k/vim-autopep8')

" Go
if filereadable("${GOROOT}/misc/vim")
  set rtp+=$GOROOT/misc/vim
endif

if filereadable("${GOPATH}/src/github.com/nsf/gocode/vim")
  exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
endif

call dein#add('dgryski/vim-godef')
call dein#add('fatih/vim-go')
call dein#add('vim-jp/vim-go-extra')

set rtp^=$GOPATH/src/github.com/nsf/gocode/vim

let g:go_fmt_command = "goimports"

" Ruby
call dein#add('vim-ruby/vim-ruby')
call dein#add('tpope/vim-rails')
call dein#add('scrooloose/syntastic')
call dein#add('alpaca-tc/vim-endwise.git')

call dein#end()

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

set laststatus=2
set t_Co=256
let g:lightline = {'colorscheme': 'wombat'}

" Search
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

cnoremap <expr> / getcmdtype() == "/" ? "\/" : "/"
cnoremap <expr> ? getcmdtype() == "?" ? "\?" : "?"

" Edit
set smarttab
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set autoread
set infercase
set autoindent
set copyindent
set virtualedit=all
set modeline
set showmatch
set matchtime=3

set formatoptions-=o

if has("unnamedplus")
  set clipboard& clipboard+=unnamedplus
else
  set clipboard& clipboard+=unnamed
endif

set backspace=indent,eol,start
set cpoptions-=m
set matchpairs& matchpairs+=<:>

set grepprg=grep\ -nH
set isfname-==

set timeout timeoutlen=3000 ttimeoutlen=100
set updatetime=1000

" set swap directory
set directory=/tmp
set undofile
let &undodir=&directory

" set tag file. don"t search tags in pwd and search upward
set tags& tags-=tags tags+=./tags;

set keywordprg=:help

" hide buffer insted of closing to prevent Undo history
set hidden
" use opend buffer insted of create new buffer
set switchbuf=useopen

" do not create backup
set nowritebackup
set nobackup
set noswapfile
set backupdir=~/tmp

" set default lang for spell check
set spelllang=en_us
set nospell

set list
set number
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:%,eol:¬

" disable bells
set t_vb=
set novisualbell

" open quickfix after make,grep, etc.
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen
" quit quickfix, help ... with q
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" save the file as root with "sudo"
cmap w!! w !sudo tee > /dev/null %

" automatically create the directory if it does not exist
function! s:mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force || input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)

" automatically change the directory when starting the vim
autocmd MyAutoCmd VimEnter * call s:ChangeCurrentDir('', '')
function! s:ChangeCurrentDir(directory, bang)
  if a:directory == ''
    lcd %:p:h
  else
    execute 'lcd' . a:directory
  endif

  if a:bang == ''
    pwd
  endif
endfunction

autocmd MyAutoCmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction
