NVIM_DIR="${HOME}/.config/nvim"
if [ ! -d "${NVIM_DIR}" ]; then
  mkdir -p "${NVIM_DIR}"
fi

if [ ! -f "${NVIM_DIR}/init.vim" ]; then
 curl https://gist.githubusercontent.com/hirokazumiyaji/e26bd339f73873e0462e57b0d0373c83/raw/ca98e84425376701adbca3d6d5b1c74da35804eb/vimrc -o "${NVIM_DIR}/init.vim"
fi
