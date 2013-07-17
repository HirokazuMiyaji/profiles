" =============================================================================
" .vimrc
" =============================================================================
" Initialize {{{
set nocompatible

if !exists($MYGVIMRC)
  let $MYGVIMRC = expand("~/.gvimrc")
endif

let s:is_windows = has("win32") || has("win64")
let s:is_cygwin = has("win32unix")
let s:is_darwin = has("mac") || has("macunix") || has("gui_macvim")
let s:is_linux = !s:is_windows && !s:is_cygwin && !s:is_darwin

let s:config_root = expand("~/.vim")
let s:bundle_root = s:config_root . "/bundle"

if s:is_windows
  language message en
  set shellslash
else
  language message C
endif

" }}}


augroup MyAutoCmd
  autocmd!
augroup END


let g:mapleader = ";"
let g:maplocalleader = ","


nnoremap ; <Nop>
xnoremap ; <Nop>
nnoremap , <Nop>
xnoremap , <Nop>


if has("vim_starting")
  if s:is_windows
    let &runtimepath = join([s:config_root, expand("$VIM/runtime"), s:config_root . "/after"]. ",")
  else
    set runtimepath&
  endif
endif


" KeyMapping {{{

inoremap jj <Esc>

nmap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>

vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v,"\/"),"\n","\\n","g")<CR><CR>

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

nnoremap j gj
nnoremap k gk

vnoremap v $h

nnoremap <Tab> %
vnoremap <Tab> %

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" toggle
nnoremap [toggle] <Nop>
nmap T [toggle]
nnoremap <silent> [toggle]s :<C-u>setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]l :<C-u>setl list!<CR>:setl list?<CR>
nnoremap <silent> [toggle]t :<C-u>setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :<C-u>setl wrap!<CR>:setl wrap?<CR>

" }}}


" Plugins {{{

let s:noplugin = 0
let s:neobundle_root = s:bundle_root . "/neobundle.vim"
if !isdirectory(s:neobundle_root) || v:version < 702
  let s:noplugin = 1
else
  if has("vim_starting")
    execute "set runtimepath+=" . s:neobundle_root
  endif

  call neobundle#rc(s:bundle_root)

  NeoBundleFetch "Shougo/neobundle.vim"

  NeoBundle "Shougo/vimproc", {
    \ "build": {
    \   "windows": "make -f make_mingw32.mak",
    \   "cygwin": "make -f make_cygwn.mak",
    \   "mac": "make -f make_mac.mak",
    \   "unix": "make -f make_unix.mak",
    \ }}

  " git
  NeoBundleLazy "tpope/vim-git", {
    \ "autoload": {
    \   "filetypes": "git",
    \ }}

  " syntax for CSS3
  NeoBundleLazy "hail2u/vim-css3-syntax", {
    \ "autoload": {
    \   "filetypes": "css"
    \ }}

  " syntax for HTML5
  NeoBundleLazy "othree/html5.vim", {
    \ "autoload": {
    \   "filetypes": ["html", "djangohtml"],
    \ }}

  " syntax /indent /omnicomplete for LESS
  NeoBundleLazy "groenewege/vim-less.git", {
    \ "autoload": {
    \   "filetypes": "less"
    \ }}

  " syntax for SASS
  NeoBundleLazy "cakebaker/scss-syntax.vim", {
    \ "autoload": {
    \   "filetypes": "sass"
    \ }}

  " Unite {{{

  NeoBundleLazy "Shougo/unite.vim", {
    \ "autoload": {
    \   "commands": ["Unite", "UniteWithBufferDir"]
    \ }}
  NeoBundleLazy "h1mesuke/unite-outline", {
    \ "autoload": {
    \   "unite_sources": ["outline"],
    \ }}
  nnoremap [unite] <Nop>
  nmap U [unite]
  nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
  nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
  nnoremap <silent> [unite]r :<C-u>Unite register<CR>
  nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
  nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
  nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
  nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
  nnoremap <silent> [unite]w :<C-u>Unite window<CR>
  let s:hooks = neobundle#get_hooks("unite.vim")
  function! s:hooks.on_source(bundle)
    " start unite in insert mode
    let g:unite_enable_start_insert = 1
    " use vimfiler to open directory
    call unite#custom_default_action("source/bookmark/directory", "vimfiler")
    call unite#custom_default_action("directory", "vimfiler")
    call unite#custom_default_action("directory_mru", "vimfiler")
    autocmd MyAutoCmd FileType unite call s:unite_settings()
    function! s:unite_settings()
      imap <buffer> <Esc><Esc> <Plug>(unite_exit)
      nmap <buffer> <Esc> <Plug>(unite_exit)
      nmap <buffer> <C-n> <Plug>(unite_select_next_line)
      nmap <buffer> <C-p> <Plug>(unite_select_previous_line)
    endfunction
  endfunction

  " }}}

  " Vim Filer {{{

  NeoBundleLazy "Shougo/vimfiler", {
    \ "depends": ["Shougo/unite.vim"],
    \ "autoload": {
    \   "commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
    \   "mappings": ['<Plug>(vimfiler_switch)'],
    \   "explorer": 1,
    \ }}
  nnoremap <Leader>e :VimFilerExplorer<CR>
  " close vimfiler automatically when there are only vimfiler open
  autocmd MyAutoCmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
  let s:hooks = neobundle#get_hooks("vimfiler")
  function! s:hooks.on_source(bundle)
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_enable_auto_cd = 1

    " ignore swap, backup, temporary files
    let g:vimfiler_ignore_pattern = '\.pyc$'

    " vimfiler specific key mappings
    autocmd MyAutoCmd FileType vimfiler call s:vimfiler_settings()
    function! s:vimfiler_settings()
      " ^^ to go up
      nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
      " use R to refresh
      nmap <buffer> R <Plug>(vimfiler_redraw_screen)
      " overwrite C-l ignore <Plug>(vimfiler_redraw_screen)
      nmap <buffer> <C-l> <C-w>l
      " overwrite C-j ignore <Plug>(vimfiler_switch_to_history_directory)
      nmap <buffer> <C-j> <C-w>j
    endfunction
  endfunction

  " }}}

  NeoBundleLazy "mattn/gist-vim", {
    \ "depends": ["mattn/webapi-vim"],
    \ "autoload": {
    \   "commands": ["Gist"],
    \ }}

  NeoBundle "tpope/vim-surround"
  NeoBundle "vim-scripts/Align"
  NeoBundle "vim-scripts/YankRing.vim"
  let s:hooks = neobundle#get_hooks("YankRing.vim")
  function! s:hooks.on_source(bundle)
    let yankring_history_file = ".yankring_history"
  endfunction

  " NeoCompelte or NeoComplCache {{{

  if has("lua") && v:version > 703
    NeoBundleLazy "Shougo/neocomplete.vim", {"autoload": {"insert": 1}}
    let s:hooks = neobundle#get_hooks("neocomplete.vim")
    function! s:hooks.on_source(bundle)
      let g:acp_enableAtStartup = 0
      let g:neocomplete#enable_smart_case = 1
      let g:neocomplete#sources#syntax#min_keyword_length = 3
      NeoCompleteEnable
    endfunction
  else
    NeoBundleLazy "Shougo/neocomplcache.vim", {"autoload": {"insert": 1}}
    let s:hooks = neobundle#get_hooks("neocomplcache.vim")
    function! s:hooks.on_source(bundle)
      let g:acp_enableAtStartup = 0
      let g:neocomplcache_enable_smart_case = 1
      let g:neocomplcache_min_syntax_length = 3
      NeoComplCacheEnable
    endfunction
  endif

  " }}}

  " NeoSnippet {{{

  NeoBundleLazy "Shougo/neosnippet.vim", {"depends": ["honza/vim-snippets"], "autoload": {"insert": 1}}
  let s:hooks = neobundle#get_hooks("neosnippet.vim")
  function! s:hooks.on_source(bundle)
    " Plugin key-mappings.
    imap <C-k> <Plug>(neosnippet_expand_or_jump)
    smap <C-k> <Plug>(neosnippet_expand_or_jump)
    xmap <C-k> <Plug>(neosnippet_expand_target)
    " SuperTab like snippets behavior.
    imap <expr><TAB>
    neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB>
    neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
    " For snippet_complete marker.
    if has("conceal")
      set conceallevel=2 concealcursor=i
    endif
    " Enable snipMate compatibility feature.
    let g:neosnippet#enable_snipmate_compatibility = 1
    " Tell Neosnippet about the other snippets
    let g:neosnippet#snippets_directory=s:bundle_root . "/vim-snippets/snippets"
  endfunction

  " }}}

  " QuickRun {{{

  NeoBundleLazy "thinca/vim-quickrun", {
    \ "autoload": {
    \   "mappings": [["nxo", "<Plug>(quickrun)"]],
    \ }}
  nmap <Leader>r <Plug>(quickrun)
  let s:hooks = neobundle#get_hooks("vim-quickrun")
  function! s:hooks.on_source(bundle)
    if has("clientserver")
      let g:quickrun_config = {"*": {"runner": "remote/vimproc"}}
    else
      let g:quickrun_config = {"*": {"runner": "remote/vimproc"}}
    endif
    let g:quickrun_config["qml/qmlscene"] = {"command": "qmlviewer", "exec": "%c %s:p", "quickfix/errorformat": "file:\/\/%f:%l %m"}
    let g:quickrun_config["qml"] = g:quickrun_config["qml/qmlscene"]
  endfunction

  " }}}

  NeoBundle "scrooloose/syntastic", {
    \ "build": {
    \   "mac": ["pip install pyflake", "npm -g install coffeelint"],
    \   "unix": ["pip install pyflake", "npm -g install coffeelint"],
    \ }}

  " jQuery
  NeoBundleLazy "jQuery", {
    \ "autoload": {
    \   "filetypes": ["coffee", "coffeescript", "javascript", "html", "djangohtml"],
    \ }}

  " CoffeeScript
  NeoBundleLazy "kchmck/vim-coffee-script", {
    \ "autoload": {
    \   "filetypes": ["coffee", "coffeescript"],
    \ }}
  NeoBundleLazy "mattn/zencoding-vim", {
    \ "autoload": {
    \   "filetypes": ["html", "djangohtml"],
    \ }}

  " Python {{{

  NeoBundleLazy "lambdalisue/vim-django-support", {
    \ "autoload": {
    \   "filetypes": ["python", "python3", "djangohtml"],
    \ }}
  NeoBundleLazy "jmcantrell/vim-virtualenv", {
    \ "autoload": {
    \   "filetypes": ["python", "python3", "djangohtml"],
    \ }}
  NeoBundleLazy "davidhalter/jedi-vim", {
    \ "autoload": {
    \   "filetypes": ["python", "python3", "djangohtml"],
    \   "build": {
    \     "mac": "pip install jedi", "unix": "pip install jedi"
    \   }
    \ }}
  let s:hooks = neobundle#get_hooks("jedi-vim")
  function! s:hooks.on_source(bundle)
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#popup_select_first = 0
    let g:jedi#show_function_definition = 1
    let g:jedi#rename_command = "<Leader>R"
    let g:jedi#goto_command = "<Leader>G"
  endfunction

  " }}}

  " PanDoc {{{

  NeoBundleLazy "vim-pandoc/vim-pandoc", {
    \ "autoload": {
    \   "filetypes": ["text", "pandoc", "markdown", "rst", "textile"]
    \  }}
  NeoBundleLazy "lambdalisue/shareboard.vim", {
    \ "autoload": {
    \   "commands": ["ShareboardPreview", "ShareboardCompile"]
    \ },
    \ "build": {
    \   "mac": "pip install shareboard",
    \   "unix": "pip install shareboard",
    \ }}
  function! s:shareboard_settings()
    nnoremap <buffer>[shareboard] <Nop>
    nmap <buffer><Leader> [shareboard]
    nnoremap <buffer><silent> [shareboard]v :ShareboardPreview<CR>
    nnoremap <buffer><silent> [shareboard]c :ShareboardCompile<CR>
  endfunction
  autocmd MyAutoCmd FileType rst,text,pandoc,markdown,textile call s:shareboard_settings()
  let s:hooks = neobundle#get_hooks("shareboard.vim")
  function! s:hooks.on_source(bundle)
    let g:shareboard_command = expand("~/.vim/shareboard/command.sh markdown+autolink_bare_uris+abbreviations")
    " add ~/.cabal/bin to PATH
    let $PATH=expand("~/.cabal/bin:") . $PATH
  endfunction

  " }}}

  filetype plugin indent on

  " install missing plugins
  NeoBundleCheck

  unlet s:hooks
endif


" }}}


" Encoding {{{

if s:noplugin == 1
  set encoding=utf-8
  if !has("gui_running")
    set termencoding=
    if s:is_windows
      set termencoding=cp932
    endif
  endif

  set fileformat=unix
  set fileformats=unix,dos,mac
  set ambiwidth=double
  set fileencoding=utf8
  set fileencodings=utf-8,sjis,iso-2022-jp,euc-jp

  command! -bang -bar -complete=file -nargs=? Utf8 edit<bang> ++enc=utf-8 <args>
  command! -bang -bar -complete=file -nargs=? Iso2022jp edit<bang> ++enc=iso-2022-jp <args>
  command! -bang -bar -complete=file -nargs=? Cp932 edit<bang> ++enc=cp932 <args>
  command! -bang -bar -complete=file -nargs=? Euc edit<bang> ++enc=euc-jp <args>
  command! -bang -bar -complete=file -nargs=? Utf16 edit<bang> ++enc=ucs-2le <args>
  command! -bang -bar -complete=file -nargs=? Utf16be edit<bang> ++enc=ucs-2 <args>
  command! -bang -bar -complete=file -nargs=? Jis  Iso2022jp<bang> <args>
  command! -bang -bar -complete=file -nargs=? Sjis  Cp932<bang> <args>
  command! -bang -bar -complete=file -nargs=? Unicode Utf16<bang> <args>

  command! -bang -complete=file -nargs=? WUnix write<bang> ++fileformat=unix <args> | edit <args>
  command! -bang -complete=file -nargs=? WDos write<bang> ++fileformat=dos <args> | edit <args>
  command! -bang -complete=file -nargs=? WMac write<bang> ++fileformat=mac <args> | edit <args>
endif

" }}}


if has("multi_byte_ime")
    set iminsert=0 imsearch=0
endif

" Search {{{

set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

cnoremap <expr> / getcmdtype() == "/" ? "\/" : "/"
cnoremap <expr> ? getcmdtype() == "?" ? "\?" : "?"

" }}}

" Edit {{{

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
set directory& directory-=.
if v:version >= 703
  set undofile
  let &undodir=&directory
endif

" set tag file. don"t search tags in pwd and search upward
set tags& tags-=tags tags+=./tags;
if v:version < 703 || (v:version == 7.3 && !has("patch336"))
  set notagbsearch
endif

set keywordprg=:help

" hide buffer insted of closing to prevent Undo history
set hidden
" use opend buffer insted of create new buffer
set switchbuf=useopen

" do not create backup
set nowritebackup
set nobackup
set noswapfile
set backupdir=~/.vim/tmp

" set default lang for spell check
set spelllang=en_us
set nospell

" }}}


" Folding {{{

set foldenable
set foldcolumn=2
set foldlevel=1
set foldnestmax=5
set foldmethod=marker

" }}}


" Display {{{

syntax on
set list
set number
if s:is_windows
  set listchars=tab:>-,trail:-,extends:>,precedes:<
else
  set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:¬
endif

set wrap
set textwidth=0
set whichwrap+=h,l,<,>,[,],b,s,~
set laststatus=2
set scrolloff=4
set cmdheight=2
set showcmd


" turn down a long line appointed in "breakat"
set linebreak
set showbreak=>\ \ \
set breakat=\ \ ;:,!?


" do not display greeting message
set shortmess=aTI

" store cursor, folds, slash, unix on view
set viewoptions=cursor,folds,slash,unix


" disable bells
set t_vb=
set novisualbell

" display candidate supplement
set nowildmenu
set wildmode=list:longest,full

set history=200
set showfulltag
set wildoptions=tagfile
" completion settings
set completeopt=menuone
set complete=.
set pumheight=20
set report=0
" maintain a current line at the time of movement as much as possible
set nostartofline

" don"t redraw while macro executing
set lazyredraw

" do not omit it in @.
set display=lastline

if v:version >= 703
  set conceallevel=2 concealcursor=iv
  set colorcolumn=80
endif

" }}}


" Macro {{{

command! Reloadrc source $MYVIMRC | if has("gui_running") | source $MYGVIMRC | endif
command! Configvrc edit $MYVIMRC
command! Configgrc edit $MYGVIMRC
command! Loadasrc exec "source " . expand("%:p")

nnoremap <Leader><Leader>c :Configvrc<CR>
nnoremap <Leader><Leader>g :Configgrc<CR>
nnoremap <Leader><Leader>r :Reloadrc<CR>
nnoremap <Leader><Leader>l :Loadasrc<CR>

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

" }}}


" Style {{{

if !has('gui_running')
  set t_Co=256
  set background=dark
  colorscheme desert

  highlight Pmenu ctermbg=2
  highlight PmenuSel ctermbg=3
  highlight ColorColumn ctermbg=0 guibg=darkgray
  highlight Error term=undercurl cterm=undercurl gui=undercurl ctermfg=1 ctermbg=0 guisp=Red
  highlight Warning term=undercurl cterm=undercurl gui=undercurl ctermfg=4 ctermbg=0 guisp=Blue
  highlight qf_error_ucurl term=undercurl cterm=undercurl gui=undercurl guisp=Red
  highlight qf_warning_ucurl term=undercurl cterm=undercurl gui=undercurl guisp=Blue
endif

" }}}


" load local vimrc
let s:local_vimrc = expand('~/.vimrc.local')
if filereadable(s:local_vimrc)
  execute 'source ' . s:local_vimrc
endif
