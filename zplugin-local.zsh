zplugin light zsh-users/zsh-autosuggestions
zplugin light zdharma/fast-syntax-highlighting
zplugin light zsh-users/zsh-completions

zplugin load "${HOME}/.zsh/locale.zsh"
zplugin load "${HOME}/.zsh/paths.zsh"

zplugin ice depth=1 atload"source powerlevel10k.zsh-theme"
zplugin load romkatv/powerlevel10k

zplugin ice atclone"/usr/bin/ruby ./install"
zplugin load Homebrew/install

zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure

zplugin ice from"gh-r" as"program" atclone"*/install"
zplugin load github/hub

zplugin ice from"gh-r" as"program" pick"fzf"
zplugin load junegunn/fzf-bin

zplugin ice from"gh-r" as"program" pick"*/rg"
zplugin load BurntSushi/ripgrep

zplugin ice atclone"./bin/pyenv-installer"
zplugin load "pyenv/pyenv-installer"

zplugin ice from"gh-r" as"program" mv"jq-osx-amd64 -> jq" pick"jq"
zplugin load stedolan/jq

zplugin ice from"gh-r" as"program" pick"ghq_darwin_amd64/ghq"
zplugin load motemen/ghq

zplugin ice from"gh-r" as"program" pick"nvim-osx64/bin/nvim"
zplugin load neovim/neovim

zplugin ice from"gh-r" as"program" bpick"*.tar.gz" pick"*/bin/yarn"
zplugin load yarnpkg/yarn

zplugin snippet "${HOME}/.zsh/aliases.zsh"
zplugin snippet "${HOME}/.zsh/google-cloud-sdk.zsh"
zplugin snippet "${HOME}/.zsh/ghq-fzf.zsh"
zplugin snippet "${HOME}/.zsh/flutter.zsh"
zplugin snippet "${HOME}/.zsh/goenv.zsh"
zplugin snippet "${HOME}/.zsh/rbenv.zsh"
zplugin snippet "${HOME}/.zsh/pyenv.zsh"
zplugin snippet "${HOME}/.zsh/nodenv.zsh"
zplugin snippet "${HOME}/.zsh/direnv.zsh"
