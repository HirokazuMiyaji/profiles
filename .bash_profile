# souce bashrc
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# The next line updates PATH for the Google Cloud SDK.
source "$HOME/google-cloud-sdk/path.bash.inc"

# The next line enables bash completion for gcloud.
source "$HOME/google-cloud-sdk/completion.bash.inc"

[ -s "/Users/hirokazu.miyaji/.dnx/dnvm/dnvm.sh" ] && . "/Users/hirokazu.miyaji/.dnx/dnvm/dnvm.sh" # Load dnvm
