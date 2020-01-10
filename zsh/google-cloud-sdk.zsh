GOOGLE_SDK="$HOME/src/google-cloud-sdk/path.zsh.inc"
GOOGLE_SDK_COMPLETION="$HOME/src/google-cloud-sdk/completion.zsh.inc"
# The next line updates PATH for the Google Cloud SDK.
[ -f ${GOOGLE_SDK} ] && source ${GOOGLE_SDK}
# The next line enables bash completion for gcloud.
[ -f ${GOOGLE_SDK_COMPLETION} ] && source ${GOOGLE_SDK_COMPLETION}
