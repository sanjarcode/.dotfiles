export PATH="$PATH:/opt/homebrew/bin/"
export PATH="$PATH:/opt/homebrew/lib/ruby/gems/3.0.0/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.zsh_aliases, instead of adding them here directly.

if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

#Added manually, during pyenv installation
if [ -f ~/.zprofile ]; then
    . ~/.zprofile
fi

# gitify_prompt()
eval "$(pyenv init -)"

PS1='%B%F{green}%n%f%b$%F{red}%~%f ' # for colored prompt

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
