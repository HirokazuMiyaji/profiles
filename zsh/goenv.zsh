if [ -d "${HOME}/.goenv" ]; then
  git clone https://github.com/syndbg/goenv.git ${HOME}/.goenv
fi

export GOENV_ROOT="${HOME}/.goenv"
export PATH="${HOME}/.goenv/bin:${PATH}"

eval "$(goenv init -)"
