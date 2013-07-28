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

" Load NeoBundle {{{
let s:noplugin = 0
let s:neobundle_root = s:bundle_root . "/neobundle.vim"
if isdirectory('neobundle.vim')
  set runtimepath^=neobundle.vim
elseif finddir('neobundle.vim', '.;') != ''
  execute 'set runtimepath^=' . finddir('neobundle.vim', '.;')
elseif &runtimepath !~ '/neobundle.vim'
    if !isdirectory(s:neobundle_root)
      execute printf('!git clone %s://github.com/Shougo/neobundle.vim.git', 
        \ (exists('$http_proxy') ? 'https' : 'git'))
        \ s:neobundle_root
    endif

    execute 'set runtimepath^=' . s:neobundle_root
endif

let g:neobundle#enable_tail_path = 1

call neobundle#rc(s:bundle_root)
" }}}

" NeoBundle {{{
NeoBundleFetch "Shougo/neobundle.vim"

"NeoBundle 'Shougo/neocomplcache'

"NeoBundle 'Shougo/neocomplete.vim'

"NeoBundle 'Shougo/neocomplcache-rsense'

"NeoBundle 'Shougo/neosnippet'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-build'
NeoBundle 'Shougo/unite-ssh'

NeoBundle 'Shougo/unite-sudo'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc'

NeoBundle 'Shougo/vimshell'
NeoBundle 'yomi322/vim-gitcomplete', {'autoload': {'file_type': 'vimshell'}}

NeoBundle 'Shougo/unite-outline'

" git
NeoBundleLazy "tpope/vim-git", {'autoload': {'filetypes': 'git'}}

" syntax for CSS3
NeoBundleLazy 'hail2u/vim-css3-syntax', {'autoload': {'filetypes': 'css'}}

" syntax for HTML5
NeoBundleLazy 'othree/html5.vim', {'autoload': {'filetypes': ['html', 'djangohtml']}}

" syntax /indent /omnicomplete for LESS
NeoBundleLazy 'groenewege/vim-less.git', {'autoload': {'filetypes': 'less'}}

" syntax for SASS
NeoBundleLazy 'cakebaker/scss-syntax.vim', {'autoload': {'filetypes': 'sass'}}

" gist
NeoBundleLazy 'mattn/gist-vim', {'depends': ['mattn/webapi-vim'], 'autoload': {'commands': ['Gist']}}

" quickrun
NeoBundleLazy 'thinca/vim-quickrun', {'autoload': {'mappings': [['nxo', '<Plug>(quickrun)']]}}

NeoBundle 'scrooloose/syntastic'

" jQuery
NeoBundleLazy 'jQuery', {'autoload': {'filetypes': ['coffee', 'coffeescript', 'javascript', 'html', 'djangohtml']}}

" CoffeeScript
NeoBundleLazy 'kchmck/vim-coffee-script', {'autoload': {'filetypes': ['coffee', 'coffeescript']}}

" ZenCoding
NeoBundleLazy 'mattn/zencoding-vim', {'autoload': {'filetypes': ['html', 'djangohtml']}}

" Python {{{

NeoBundleLazy 'lambdalisue/vim-django-support', {'autoload': {'filetypes': ['python', 'python3', 'djangohtml']}}

NeoBundleLazy 'jmcantrell/vim-virtualenv', {'autoload': {'filetypes': ['python', 'python3', 'djangohtml']}}

NeoBundle 'davidhalter/jedi-vim'

" }}}

" Ruby {{{
NeoBundleLazy 'vim-ruby/vim-ruby', {'autoload': {'mappings': '<Plug>(ref-keyword)', 'file_types': 'ruby'}}

" }}}

" Indent Line
NeoBundle 'Yggdroot/indentLine'

" NeoBundle Configuration {{{

"call neobundle#config('neocomplcache', {
"  \   'lazy': 1,
"  \   'autoload': {'commands': 'NeoComplCacheEnable'}
"  \ })

"call neobundle#config('neocomplcache-rsense', {
"  \   'lazy': 1,
"  \   'depends': 'Shougo/neocomplcache',
"  \   'autoload': {'filetypes': 'ruby'}
"  \ })

"call neobundle#config('neosnippet', {
"  \   'lazy': 1,
"  \   'autoload': {
"  \     'insert': 1,
"  \     'filetypes': 'snippet',
"  \     'unite_sources': ['snippet', 'neosnippet/user', 'neosnippet/runtime'],
"  \   }
"  \ })

call neobundle#config('unite.vim', {
  \   'lazy': 1,
  \   'autoload': {
  \     'commands': [
  \       {'name': 'Unite', 'complete': 'customlist,unite#complete_source'},
  \       'UniteWithCursorWord', 'UniteWithInput'
  \     ]
  \   }
  \ })

call neobundle#config('vimfiler', {
  \   'lazy': 1,
  \   'depends': 'Shogo/unite.vim',
  \   'autoload': {
  \     'commads': [
  \       {'name': 'VimFiler', 'complete': 'customlist,vimfiler#complete'},
  \       {'name': 'VimFilerExplorer', 'complete': 'costomlist,vimfiler#complete'},
  \       {'name': 'Edit', 'complete': 'costomlist,vimfiler#complete'},
  \       {'name': 'Write', 'complete': 'costomlist,vimfiler#complete'},
  \       'Read', 'Source'
  \     ],
  \     'mappings': ['<Plug>(vimfiler_switch)'],
  \     'explorer': 1,
  \   }
  \ })

call neobundle#config('vimproc', {
  \   'build': {
  \     'windows': 'make -f make_mingw32.mak',
  \     'cygwin': 'make -f make_cygwin.mak',
  \     'mac': 'make -f make_mac.mak',
  \     'unix': 'make -f make_unix.mak',
  \   },
  \ })

call neobundle#config('vimshell', {
  \   'lazy': 1,
  \   'autoload': {
  \     'commads': [
  \       {'name': 'VimShell', 'complete': 'customlist,vimshell#complete'},
  \       'VimShellExecute', 'VimShellInteractive', 'VimShellTerminal', 'VimShellPop'
  \     ],
  \     'mappings': ['<Plug>(vimshell_switch)']
  \   }
  \ })

call neobundle#config('jedi-vim', {
  \   'lazy': 1,
  \   'autoload': {
  \     'filetypes': ['python', 'python3', 'djangohtml'],
  \     'build': {'mac': 'pip install jedi', 'unix': 'pip install jedi'}
  \   }
  \ })

call neobundle#config('unite-outline', {
  \   'lazy': 1,
  \   'autoload': {'unite_sources': 'cutline'},
  \ })

" }}}

filetype plugin indent on

syntax enable

" install missing plugins
NeoBundleCheck

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

" -------------------------------------------------------------------------------------------------
" Plugin:" {{{

" neocomplete.vim" {{{
"let g:neocomplete#enable_at_startup = 1

"let bundle = neobundle#get('neocomplete.vim')
"function! bundle.hooks.on_source(bundle)
"  " Use smartcase.
"  let g:neocomplete#enable_smart_case = 1
"  " Use fuzzy competion.
"  let g:neocomplete#enable_fuzzy_completion = 1

"  " Set minimun syntax keyword length.
"  let g:neocomplete#sources#syntax#min_keyword_length = 3
"  " Set auto completion length.
"  let g:neocomplete#auto_completion_start_length = 2
"  " Set manual completion length.
"  let g:neocomplete#manual_completion_start_length = 0
"  " Set minimum keyword length.
"  let g:neocomplete#min_keyword_length = 3
"
"  " For auto select.
"  let g:neocomplete#enable_complete_select = 1
"  let g:neocomplete#enable_auto_select = 1
"  let g:neocomplete#enable_refresh_always = 0
"
"  let g:neocompleteEsources#dictionaty#dictionaties = {
"    \   'default': '',
"    \   'vimshell': $HOME.'/.vimshell/command-history',
"    \ }
"
"  let g:neocomplete#enable_auto_delimiter = 1
"  let g:neocomplete#disable_auto_select_buffer_name_pattern = '\[Command Line\]'
"  let g:neocomplete#max_list = 100
"  let g:neocomplete#force_overwrite_completefunc = 1
"  if !exists('g:neocomplete#source#omni#input_patterns')
"    let g:neocomplete#sources#omni#input_patterns = {}
"  endif
"  if !exists('g:neocomplete#source#omni#functions')
"    let g:neocomplete#sources#omni#functions = {}
"  endif 
"  if !exists('g:neocomplete#force_omni_input_patterns')
"    let g:neocomplete#force_omni_input_patterns = {}
"  endif
"  let g:neocomplete#enable_auto_close_preview = 1
"
"  let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::\w*'

"  " Define keyword patterns
"  if !exists('g:neocomplete#keyword_patterns')
"    let g:neocomplete#keyword_patterns = {}
"  endif
"  let g:neocomplete#keyword_patterns._ = '[0-9a-zA-Z:#_]\+'
"  let g:neocomplete#keyword_patterns.perl = '\h\w*->\h\w*\|\h\w*::\w*'

"  let g:neocomplete#sources#vim#complete_functions = {
"    \   'Ref': 'ref#complete',
"    \   'Unite': 'unite#complete_source',
"    \   'VimShellExecute': 'vimshell#vimshell_execute_complete',
"    \   'VimShellInteractive': 'vimshell#vimshell_execute_complete',
"    \   'VimShellTerminal': 'vimshell#vimshell_execute_complete',
"    \   'VimShell': 'vimshell#complete',
"    \   'VimFiler': 'vimfiler#complete',
"    \ }

"  call neocomplete#custom#source('look', 'min_pattern_length', 4)

  " mappings."{{{
"  " <C-f> <C-b>: page move.
"  inoremap <expr><C-f> pumvisible() ? "\<PageDown>" : "\<Right>"
"  inoremap <expr><C-b> pumvisible() ? "\<PageUp>" : "\<Left>"
"  " <C-y>: paste.
"  inoremap <expr><C-y> pumvisibel() ? neocomplete#close_popup() : "\<C-r>\""
"  " <C-e>: close popup
"  inoremap <expr><C-e> pumvisible() ? neocomplete#cancel_popup() : "\<End>"
"  " <C-k>: unite completion.
"  imap <C-k> <Plug>(neocomplete_start_unite_complete)
"  inoremap <expr> O &filetype == 'vim' ? "\<C-x>\<C-v>" : "\<C-x>\<C-o>"
"
"  " <C-h>, <BS>: close popup and delete backword char.
"  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
"  " <C-n>: neocomplete.
"  inoremap <expr><C-n>  pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>\<Down>"
"  " <C-p>: keyword completion.
"  inoremap <expr><C-p>  pumvisible() ? "\<C-p>" : "\<C-p>\<C-n>"
"  inoremap <expr>'  pumvisible() ? neocomplete#close_popup() : "'"
"
"  imap <expr> `  pumvisible() ? "\<Plug>(neocomplete_start_unite_quick_match)" : '`'
"
"  inoremap <expr><C-x><C-f> neocomplete#start_manual_complete('file')
"
"  inoremap <expr><C-g> neocomplete#undo_completion()
"  inoremap <expr><C-l> neocomplete#complete_common_string()
"
"  " <CR>: close popup and save indent.
"  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"  function! s:my_cr_function()
"    return neocomplete#smart_close_popup() . "\<CR>"
"  endfunction
"
"  " <TAB>: completion.
"  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : neocomplete#start_manual_complete()
"  function! s:check_back_space()
"    let col = col('.') - 1
"    return !col || getline('.')[col - 1]  =~ '\s'
"  endfunction
"
"  " <S-TAB>: completion back.
"  inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"
"
"  " For cursor moving in insert mode(Not recommended)
"  inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"  inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"  inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"  inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
"  " }}}
"endfunction
" }}}

"" neocomplcache.vim"{{{
"" Use neocomplcache.
"let g:neocomplcache_enable_at_startup = 0
"
"let bundle = neobundle#get('neocomplcache')
"function! bundle.hooks.on_source(bundle)
"  " Use smartcase.
"  let g:neocomplcache_enable_smart_case = 0
"  " Use camel case completion.
"  let g:neocomplcache_enable_camel_case_completion = 0
"  " Use underbar completion.
"  let g:neocomplcache_enable_underbar_completion = 0
"  " Use fuzzy completion.
"  let g:neocomplcache_enable_fuzzy_completion = 0
"
"  " Set minimum syntax keyword length.
"  let g:neocomplcache_min_syntax_length = 3
"  " Set auto completion length.
"  let g:neocomplcache_auto_completion_start_length = 2
"  " Set manual completion length.
"  let g:neocomplcache_manual_completion_start_length = 0
"  " Set minimum keyword length.
"  let g:neocomplcache_min_keyword_length = 3
"
"  let g:neocomplcache_enable_cursor_hold_i = 0
"  let g:neocomplcache_cursor_hold_i_time = 300
"  let g:neocomplcache_enable_insert_char_pre = 0
"  let g:neocomplcache_enable_prefetch = 0
"  let g:neocomplcache_skip_auto_completion_time = '0.6'
"
"  " For auto select.
"  let g:neocomplcache_enable_auto_select = 1
"
"  let g:neocomplcache_enable_auto_delimiter = 1
"
"  let g:neocomplcache_disable_auto_select_buffer_name_pattern = '\[Command Line\]'
"
"  let g:neocomplcache_max_list = 100
"  let g:neocomplcache_force_overwrite_completefunc = 1
"  if !exists('g:neocomplcache_omni_patterns')
"    let g:neocomplcache_omni_patterns = {}
"  endif
"  if !exists('g:neocomplcache_omni_functions')
"    let g:neocomplcache_omni_functions = {}
"  endif
"  if !exists('g:neocomplcache_force_omni_patterns')
"    let g:neocomplcache_force_omni_patterns = {}
"  endif
"  let g:neocomplcache_enable_auto_close_preview = 1
"
"  let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"
"  " For clang_complete.
"  let g:neocomplcache_force_overwrite_completefunc = 1
"  let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"  let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"
"  let g:clang_complete_auto = 0
"  let g:clang_auto_select = 0
"  let g:clang_use_library = 1
"
"  " Define keyword pattern.
"  if !exists('g:neocomplcache_keyword_patterns')
"    let g:neocomplcache_keyword_patterns = {}
"  endif
"
"  let g:neocomplcache_keyword_patterns['default'] = '[0-9a-zA-Z:#_]\+'
"  let g:neocomplcache_keyword_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"
"  let g:neocomplcache_vim_completefuncs = {
"    \   'Ref' : 'ref#complete',
"    \   'Unite' : 'unite#complete_source',
"    \   'VimShellExecute' : 'vimshell#vimshell_execute_complete',
"    \   'VimShellInteractive' : 'vimshell#vimshell_execute_complete',
"    \   'VimShellTerminal' : 'vimshell#vimshell_execute_complete',
"    \   'VimShell' : 'vimshell#complete',
"    \   'VimFiler' : 'vimfiler#complete',
"    \   'Vinarise' : 'vinarise#complete',
"    \ }
"
"  imap <expr> `  pumvisible() ? "\<Plug>(neocomplcache_start_unite_quick_match)" : '`'
"endfunction
"
"function! CompleteFiles(findstart, base)
"  if a:findstart
"    " Get cursor word.
"    let cur_text = strpart(getline('.'), 0, col('.') - 1)
"
"    return match(cur_text, '\f*$')
"  endif
"
"  let words = split(expand(a:base . '*'), '\n')
"  let list = []
"  let cnt = 0
"  for word in words
"    call add(list, {'word': word, 'abbr': printf('%3d: %s', cnt, word), 'menu': 'file_complete'})
"    let cnt += 1
"  endfor
"
"  return {'words': list, 'refresh': 'always'}
"endfunction
"
"unlet bundle
"
"" }}}

" neosnippet.vim"{{{
"let bundle = neobundle#get('neosnippet')
"function! bundle.hooks.on_source(bundle)
"  imap <C-k> <Plug>(neosnippet_expand_or_jump)
"  smap <C-k> <Plug>(neosnippet_expand_or_jump)
"  xmap <C-k> <Plug>(neosnippet_expand_target)

"  let g:neosnippet#enable_snipmate_compatibility = 1

"  let g:neosnippet#snippets_directory = '~/.vim/snippets'
"endfunction

"unlet bundle
" }}}

" Jedi-vim" {{{
let bundle = neobundle#get('jedi-vim')
function! bundle.hooks.on_source(bundle)
  let g:jedi#auto_vim_configuration = 0
  let g:jedi#popup_select_first = 0
  let g:jedi#rename_command = "<Leader>R"
  let g:jedi#goto_command = "<Leader>G"
  let g:jedi#popup_on_dot = 1
  let g:jedi#show_function_definition = 0
  autocmd FileType python let b:did_ftplugin = 1
endfunction
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

" Style "{{{
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

let &statusline='%F%m%r%h%w [FORMAT=%{&ff}] [ENC=%{&fileencoding}] [TYPE=%Y] [ASCII=%03.3b] [HEX=%02.2B] [POS=%04l,%04v][%p%%] [LEN=%L] %= [WORKON=%{virtualenv#statusline()}]'
" }}}

" load local vimrc
let s:local_vimrc = expand('~/.vimrc.local')
if filereadable(s:local_vimrc)
  execute 'source ' . s:local_vimrc
endif
