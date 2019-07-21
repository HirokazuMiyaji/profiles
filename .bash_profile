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


[ -s "/Users/hirokazu.miyaji/.dnx/dnvm/dnvm.sh" ] && . "/Users/hirokazu.miyaji/.dnx/dnvm/dnvm.sh" # Load dnvm

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/hirokazumiyaji/.sdkman"
[[ -s "/Users/hirokazumiyaji/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/hirokazumiyaji/.sdkman/bin/sdkman-init.sh"

export JAVA_HOME=$HOME/.sdkman/candidates/java/current
export PATH=$JAVA_HOME/bin:$PATH 
