profiles=~/.profiles

source "${profiles}/functions"

# init_paths

init_editor

init_rbenv

init_virtualenv

if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

