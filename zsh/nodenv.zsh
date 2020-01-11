export NODENV_ROOT="${HOME}/.nodenv"

if [ ! -d "${NODENV_ROOT}" ]; then
  git clone https://github.com/nodenv/nodenv.git ${NODENV_ROOT}
fi

if [ ! -d "${NODENV_ROOT}/plugins/node-build" ]; then
  git clone https://github.com/nodenv/node-build.git ${NODENV_ROOT}/plugins/node-build
fi

export PATH="${NODENV_ROOT}/bin:${PATH}"

eval "$(nodenv init -)"
