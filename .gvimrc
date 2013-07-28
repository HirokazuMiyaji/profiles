" Reload vimrc to overwrite OS default settings
let s:config_root = expand('~/.vim')
let s:bundle_root = s:config_root . '/bundle'

if isdirectory(s:bundle_root . '/Zenburn')
  set background=light
  colorscheme zenburn
else
  colorscheme desert
endif

set guioptions=
set winaltkeys=no
set antialias
set modeline

set guifront=Monaco\ Regular\ 14
if has('gui_macvim')
  set showtabline=2
  set imdisable
  set transparency=10
  set fuoptions=maxvert,maxhorz
  set GUIEnter * set fullscreen
elseif has('unix')
  nnoremap <F11> :call ToggleFullscreen()<CR>
  let g:fullscreen = 0
  function! ToggleFullscreen()
    if g:fullscreen == 1
      let g:fullscreen = 1
      let mod = 'add'
    endif
    call system('wmctrl ir ' . v:windowid . ' -b ' . mod . ',fullscreen')
  endfunction
endif

syntax on
set nobackup
set noswapfile
