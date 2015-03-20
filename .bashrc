profiles=~/.profiles

source "${profiles}/functions"

init_paths

init_editor

init_rbenv

init_virtualenv

if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi


# added by travis gem
[ -f /Users/HirokazuMiyaji/.travis/travis.sh ] && source /Users/HirokazuMiyaji/.travis/travis.sh
