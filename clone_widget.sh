function git_url_preprocess_widget() {
    local CMD_LINE="$BUFFER"
    if [[ $CMD_LINE =~ ^git@github.com:.+\/.+\.git$ || $CMD_LINE =~ ^https:\/\/github.com\/.+\/.+\.git$ ]]; then
        echo "\nEncountered git url, checking validity..."
        if git ls-remote "$CMD_LINE" &>/dev/null; then
            BUFFER="git clone $CMD_LINE"
        else
            echo "\nInvalid GitHub repository URL."
            BUFFER=""
        fi
    fi
    zle accept-line
}

zle -N git_url_preprocess_widget
bindkey '^M' git_url_preprocess_widget
