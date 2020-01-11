export RBENV_ROOT="${HOME}/.rbenv"

if [ ! -d "${RBENV_ROOT}" ]; then
  git clone https://github.com/rbenv/rbenv.git "${RBENV_ROOT}"
fi

if [ ! -d "${RBENV_ROOT}/plugins/ruby-build" ]; then
  git clone https://github.com/rbenv/ruby-build.git "${RBENV_ROOT}/plugins/ruby-build"
fi

export PATH="${RBENV_ROOT}/bin:${PATH}"

eval "$(rbenv init -)"
