profles=~/.profiles
source "${profiles}/functions"
source "${profiles}/virtualenv"

if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# virtualenv {{{
export WORKON_HOME=$HOME/.virtualenvs
if [ -d $WORKON_HOME ]; then
  mkdir -p $WORKON_HOME
fi
source `which virtualenvwrapper.sh`
alias mkve=mkvirtualenv
alias lsve=lsvirtualenv
alias rmve=rmvirtualenv
# }}}

# rbenv {{{
eval "$(rbenv init -)"
source ~/.rbenv/completions/rbenv.bash
# }}}
