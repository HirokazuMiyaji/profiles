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

# DIRENV {{{
which direnv > /dev/null && eval "$(direnv hook zsh)"
# }}}

# asdf {{{
ASDF_ROOT="${HOME}/.asdf"
if [ ! -d "${ASDF_ROOT}" ]; then
  git clone https://github.com/asdf-vm/asdf.git ${ASDF_ROOT}
fi
source "${ASDF_ROOT}/asdf.sh"
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit

plugins=("golang" "python" "flutter" "terraform" "java")
for plugin in ${plugins}; do
  asdf plugin add ${plugin} > /dev/null 2>&1
done
# }}}

# GOOGLE CLOUD SDK {{{
GOOGLE_SDK="${HOME}/src/google-cloud-sdk/path.zsh.inc"
GOOGLE_SDK_COMPLETION="$HOME/src/google-cloud-sdk/completion.zsh.inc"
[ -f ${GOOGLE_SDK} ] && source ${GOOGLE_SDK}
[ -f ${GOOGLE_SDK_COMPLETION} ] && source ${GOOGLE_SDK_COMPLETION}
# }}}

# FLUTTER {{{
export PATH="$PATH":"$HOME/.pub-cache/bin"
# }}}

#export DOCKER_HOST=unix://${HOME}/docker.sock
