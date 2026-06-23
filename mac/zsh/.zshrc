source /Users/hanya/.docker/init-zsh.sh || true # Added by Docker Desktop

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/hanya/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/hanya/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/hanya/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/hanya/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

alias g='git'

eval "$(/opt/homebrew/bin/brew shellenv)"

#alias gcc='gcc-13'
#alias g++='g++-13'

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

#10/22に追加した
function charm {
    open -na 'PyCharm CE.app' "$@"
}

export COLORTERM=truecolor

alias ls='eza'

# API keys are stored in ~/.zshrc.local (not committed)
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

export PATH="/usr/local/opt/node@16/bin:$PATH"

export PATH=$PATH:/Users/hanya/.spicetify

#24/6/23に追加した
source <(fzf --zsh)
HISTSIZE=100000
#清悟に教えてもらった
alias cdc='cd $(ls | fzf)'
export PATH=$HOME/.progate/bin:$PATH

. "$HOME/.cargo/env"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# Created by `pipx` on 2025-05-10 01:21:45
export PATH="$PATH:/Users/hanya/.local/bin"

# Added by Antigravity
export PATH="/Users/hanya/.antigravity/antigravity/bin:$PATH"
export PATH="/opt/homebrew/opt/node@24/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Zellij エイリアス
alias ze='zellij'
alias zevs='zellij -n vscode -s'
