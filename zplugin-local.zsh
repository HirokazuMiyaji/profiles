zplugin light zsh-users/zsh-autosuggestions
zplugin light zdharma/fast-syntax-highlighting
zplugin light zsh-users/zsh-completions

zplugin load "${HOME}/.zsh/locale.zsh"
zplugin load "${HOME}/.zsh/paths.zsh"

zplugin ice depth=1 atload"source powerlevel10k.zsh-theme"
zplugin load romkatv/powerlevel10k

zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure

zplugin ice from"gh-r" as"program" atclone"*/install"
zplugin load github/hub

zplugin ice from"github.com" atclone"bin/pyenv-installer"
zplugin load pyenv/pyenv-installer

zplugin ice from"gh-r" as"program"
zplugin load junegunn/fzf-bin

zplugin ice from"gh-r" as"program"
zplugin load BurntSushi/ripgrep

zplugin ice from"gh-r" as"program" pick"nvim-osx64/bin/nvim"
zplugin load neovim/neovim

zplugin load "${HOME}/.zsh/aliases.zsh"
zplugin load "${HOME}/.zsh/google-cloud-sdk.zsh"
zplugin load "${HOME}/.zsh/ghq-fzf.zsh"
zplugin load "${HOME}/.zsh/flutter.zsh"
zplugin load "${HOME}/.zsh/goenv.zsh"
zplugin load "${HOME}/.zsh/pyenv.zsh"
zplugin load "${HOME}/.zsh/sdkman.zsh"
