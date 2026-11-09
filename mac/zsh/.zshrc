# 端末ごとに入っていないツールがあってもエラーにならないよう、存在チェックしてから読み込む

# --- Docker Desktop ---
[ -f "$HOME/.docker/init-zsh.sh" ] && source "$HOME/.docker/init-zsh.sh"

# --- nvm ---
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if [ -x "$HOME/anaconda3/bin/conda" ]; then
    __conda_setup="$("$HOME/anaconda3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    elif [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/anaconda3/bin:$PATH"
    fi
    unset __conda_setup
fi
# <<< conda initialize <<<

# --- Homebrew（conda より優先させるため後に読み込む） ---
[ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

# --- PATH ---
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
# 後に書いたものほど優先される
export PATH="$HOME/.progate/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"  # Added by Antigravity
export PATH="/opt/homebrew/opt/node@24/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:$HOME/.spicetify"
export PATH="$PATH:$HOME/.local/bin"  # pipx / claude / rtk

# --- シェル設定 ---
export COLORTERM=truecolor
HISTSIZE=100000

[ -f "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && \
    source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

#24/6/23に追加した
command -v fzf >/dev/null && source <(fzf --zsh)

# --- エイリアス・関数 ---
alias g='git'
command -v eza >/dev/null && alias ls='eza'
#清悟に教えてもらった
alias cdc='cd $(ls | fzf)'

# Zellij エイリアス
alias ze='zellij'
alias zevs='zellij -n vscode -s'

#10/22に追加した
function charm {
    open -na 'PyCharm CE.app' "$@"
}

# --- 秘密情報（APIキーなど）は ~/.zshrc.local に書く（コミットしない） ---
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
