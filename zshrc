# Zsh Basic Configurations {{{
setopt nullglob
fpath=(/usr/local/share/zsh-completions $fpath)
typeset -ga preexec_functions
typeset -ga precmd_functions
bindkey -e
autoload -Uz colors
colors
setopt prompt_subst
setopt auto_cd
setopt auto_resume
setopt no_beep
setopt brace_ccl
setopt correct
setopt equals
setopt extended_glob
setopt no_flow_control
setopt no_hup
setopt long_list_jobs
setopt magic_equal_subst
setopt mark_dirs
setopt glob_complete
setopt multios
setopt numeric_glob_sort
setopt print_eightbit
setopt pushd_ignore_dups
unsetopt promptcr
setopt transient_rprompt
setopt auto_pushd
setopt no_check_jobs
autoload -Uz select-word-style
select-word-style bash

PROMPT="%n %c %# "
# }}}

# Locales {{{
LANG="ja_JP.UTF-8"
LC_COLLATE="ja_JP.UTF-8"
LC_CTYPE="UTF-8"
LC_MESSAGES="ja_JP.UTF-8"
LC_MONETARY="ja_JP.UTF-8"
LC_NUMERIC="ja_JP.UTF-8"
LC_TIME="ja_JP.UTF-8"
LC_ALL="ja_JP.UTF-8"
# }}}

# Zsh Completion System {{{
autoload -Uz compinit
compinit
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' command 'ps -axco pid,user,command'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format $'%{\e[0;31m%}%d%{\e[0m%}'
zstyle ':completion:*:messages' format $'%{\e[0;31m%}%d%{\e[0m%}'
zstyle ':completion:*:warnings' format $'%{\e[0;31m%}No matches for: %d%{\e[0m%}'
zstyle ':completion:*:corrections' format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'
local knownhosts
if [ -f $HOME/.ssh/known_hosts ]; then
  knownhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
  zstyle ':completion:*:(ssh|scp|sftp):*' hosts $knownhosts
fi
# }}}

# Zsh History {{{
HISTFILE="${HOME}"/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000
setopt hist_ignore_space
setopt hist_no_store
setopt share_history
setopt append_history
setopt extended_history
setopt hist_ignore_dups
setopt hist_verify
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
# }}}

# Zsh Keybinds {{{
bindkey -M viins '\C-h' backward-delete-char
bindkey -M viins '\C-w' backward-kill-word
bindkey -M viins '\C-u' backward-kill-line
bindkey -M vicmd 'u' undo
bindkey -M vicmd '\C-r' redo
bindkey -M vicmd '/' history-incremental-search-backward
bindkey -M vicmd '?' history-incremental-search-forward
bindkey -M viins '^p' history-beginning-search-backward-end
bindkey -M viins '^n' history-beginning-search-forward-end
bindkey -M emacs '^p' history-beginning-search-backward-end
bindkey -M emacs '^n' history-beginning-search-forward-end
bindkey -M vicmd '\C-t' transpose-words
bindkey -M viins '\C-t' transpose-words
# }}}

# ALIAS {{{
alias git=hub
alias vim=nvim
# }}}

# SDKMAN {{{
export SDKMAN_DIR="${HOME}/.sdkman"
if [ ! -d "${SDKMAN_DIR}" ]; then
  curl -s "https://get.sdkman.io" | zsh
fi
if [ -e "${SDKMAN_DIR}/bin/sdkman-init.sh" ]; then
  source "${SDKMAN_DIR}/bin/sdkman-init.sh"
fi
export JAVA_HOME=$HOME/.sdkman/candidates/java/current
export PATH=$JAVA_HOME/bin:$PATH
# }}}

# DIRENV {{{
which direnv > /dev/null && eval "$(direnv hook zsh)"
# }}}

# GOENV {{{
export GOENV_ROOT="${HOME}/.goenv"
if [ ! -d "${GOENV_ROOT}" ]; then
  git clone https://github.com/syndbg/goenv.git ${GOENV_ROOT}
fi
export PATH="${GOENV_ROOT}/bin:${PATH}"
if command -v goenv 1>/dev/null 2>&1; then
  eval "$(goenv init -)"
fi
export PATH="${GOROOT}/bin:${PATH}"
export PATH="${PATH}:${GOPATH}/bin"
# }}}

# PYENV {{{
export PYENV_ROOT="${HOME}/.pyenv"
if [ ! -d "${PYENV_ROOT}" ]; then
  git clone https://github.com/pyenv/pyenv.git ${PYENV_ROOT}
fi
export PATH="${PYENV_ROOT}/bin:${PATH}"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
# }}}

# NODENV {{{
export NODENV_ROOT="${HOME}/.nodenv"
if [ ! -d "${NODENV_ROOT}" ]; then
  git clone https://github.com/nodenv/nodenv.git ${NODENV_ROOT}
  mkdir -p ${NODENV_ROOT}/plugins
  git clone https://github.com/nodenv/node-build.git ${NODENV_ROOT}/plugins/node-build
fi
export PATH="${NODENV_ROOT}/bin:${PATH}"
if command -v nodenv 1>/dev/null 2>&1; then
  eval "$(nodenv init -)"
fi
# }}}

# RBENV {{{
export RBENV_ROOT="${HOME}/.rbenv"
if [ ! -d "${RBENV_ROOT}" ]; then
  git clone https://github.com/rbenv/rbenv.git ${RBENV_ROOT}
fi
export PATH="${RBENV_ROOT}/bin:${PATH}"
if command -v rbenv 1>/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi
# }}}

# asdf {{{
ASDF_ROOT="${HOME}/.asdf"
if [ ! -d "${ASDF_ROOT}" ]; then
  git clone https://github.com/asdf-vm/asdf.git ${ASDF_ROOT}
fi
source "${ASDF_ROOT}/asdf.sh"
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit
# }}}

# GOOGLE CLOUD SDK {{{
GOOGLE_SDK="${HOME}/src/google-cloud-sdk/path.zsh.inc"
GOOGLE_SDK_COMPLETION="$HOME/src/google-cloud-sdk/completion.zsh.inc"
[ -f ${GOOGLE_SDK} ] && source ${GOOGLE_SDK}
[ -f ${GOOGLE_SDK_COMPLETION} ] && source ${GOOGLE_SDK_COMPLETION}
# }}}

# FLUTTER {{{
# FLUTTER_ROOT="${HOME}/.sdk/flutter"
# if [ ! -d "${FLUTTER_ROOT}" ]; then
#   git clone https://github.com/flutter/flutter.git -b stable ${FLUTTER_ROOT}
# fi
# FLUTTER_PATH="${FLUTTER_ROOT}/bin"
# if [ -d ${FLUTTER_PATH} ]; then
#   export PATH=${FLUTTER_PATH}:${PATH}
# fi
export PATH="$PATH":"$HOME/.pub-cache/bin"
# }}}
