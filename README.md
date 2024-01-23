For my macOS users.

## Features

- **Direct Git URL Handling:** Paste SSH or HTTPS Git URLs directly into the terminal and clone repositories with a single Enter key press.
- **URL Validation:** Checks if the Git URL is valid before attempting to clone.

The way I use it is to copy the content in the shell file (or just below) and paste into the `.zshrc` on my Mac.

Here's the shell content anyway.

```
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
```

I'm sure there are hackier ways to do this, but this sufficed.
