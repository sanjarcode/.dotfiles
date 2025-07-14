export PATH="$PATH:/opt/homebrew/bin/"
export PATH="$PATH:/opt/homebrew/lib/ruby/gems/3.0.0/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# enable global 3rd party modules import - added by me
# CommonJS syntax works, ESM gives error (partially)
if [ -n "$NVM_BIN" ]; then
    export NODE_PATH="${NVM_BIN/bin/lib/node_modules}"
    export PATH="$PATH:$NODE_PATH"
else
    ___MYNODEPATH=$(npm root -g 2> /dev/null)
    if [ -n "___MYNODEPATH" ]; then
        export NODE_PATH=$___MYNODEPATH
        export PATH="$PATH:$NODE_PATH"
    fi
fi

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

## ================== Post install variables

if type pyenv &>/dev/null; then
    eval "$(pyenv init -)"
fi


if type rbenv &>/dev/null; then
    eval "$(rbenv init -)" # rbenv, added manually
fi

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
fi

# Added after Rosetta 2 install

# alias rbrew='/usr/local/bin/brew'
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew' # To fix brew doctor's warning ""config" scripts exist outside your system or Homebrew directories" (https://github.com/pyenv/pyenv#:~:text=optional.%20to%20fix%20brew%20doctor's%20warning%20%22%22config)
# # Rosetta brew
# % which rbrew
alias rbrew="/usr/local/bin/brew"
# # Native brew
# % which brew
# /opt/homebrew/bin/brew
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH" # for brew path $
# https://stackoverflow.com/q/12861422 --> https://stackoverflow.com/a/11$

export HOMEBREW_NO_AUTO_UPDATE=1 # disable auto update on each run of brew

# AndroidStudio \w React Native setup docs
export ANDROID_SDK_ROOT=$HOME/.devTools/Android/Sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=~/Library/Android/sdk/tools:$PATH
export PATH=~/Library/Android/sdk/platform-tools:$PATH

# pnpm
export PNPM_HOME=$HOME/Library/pnpm
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use --silent
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default --silent
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH="$HOME/.cargo/bin:$PATH" # for Rust

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# cocaopods
# export GEM_HOME=$HOME/.gem
# export PATH=$GEM_HOME/bin:$PATH

## ================== OWN scripts
# git highlight
# gitify_prompt()
custom_prompt

# copy and paste - xclip/pb*
copyAndPaste
setupEditorShortcut

export PATH="$HOME/.cargo/bin:$PATH" # for Rust
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH" # postgres

plugins=(git zsh-autosuggestions) # https://catalins.tech/zsh-plugins/#:~:text=2.%20Zsh--,autosuggestions%20plugin,-You%20most%20likely

$(startShutdownServerIdempotent > /dev/null 2>&1 &)
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/sanjar/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
export PATH="/opt/homebrew/bin:$PATH"
