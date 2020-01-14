export GOENV_ROOT="${HOME}/.goenv"

if [ ! -d "${GOENV_ROOT}" ]; then
  git clone https://github.com/syndbg/goenv.git ${GOENV_ROOT}
fi

export PATH="${GOENV_ROOT}/bin:${PATH}"

eval "$(goenv init -)"

export PATH="${GOPATH}/bin:${PATH}"
