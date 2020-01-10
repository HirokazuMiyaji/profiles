# souce bashrc
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# The next line updates PATH for the Google Cloud SDK.
GCP_PATH="$HOME/google-cloud-sdk/path.bash.inc"
[ -s $GCP_PATH ] && source $GCP_PATH

# The next line enables bash completion for gcloud.
GCP_COMPLETION="$HOME/google-cloud-sdk/completion.bash.inc"
[ -s $GCP_COMPLETION ] && source $GCP_COMPLETION


[ -s "$HOME/.dnx/dnvm/dnvm.sh" ] && . "$HOME/.dnx/dnvm/dnvm.sh" # Load dnvm
