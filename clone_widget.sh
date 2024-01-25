function git_url_preprocess_widget() {
    local CMD_LINE="$BUFFER"
    if [[ $CMD_LINE =~ ^git@github.com:.+\/.+\.git$ || $CMD_LINE =~ ^https:\/\/github.com\/.+\/.+\.git$ ]]; then
        echo -e "\033[93m\nEncountered git url, checking validity...\033[0m"
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
