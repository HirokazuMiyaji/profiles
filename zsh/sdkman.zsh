export SDKMAN_DIR="${HOME}/.sdkman"

if [ -d "${SDKMAN_DIR}" ]; then
  curl -s "https://get.sdkman.io" | bash
fi

if [ -d "${SDKMAN_DIR}/bin/sdkman-init.sh"]; then
  source "${SDKMAN_DIR}/bin/sdkman-init.sh"
fi

export JAVA_HOME=$HOME/.sdkman/candidates/java/current
export PATH=$JAVA_HOME/bin:$PATH
