#!/bin/bash
# dotfilesのシンボリックリンクをセットアップするスクリプト
set -e
DOTFILES="$(cd "$(dirname "$0")" && pwd)"

link() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "Backing up $dst -> $dst.bak"
    mv "$dst" "$dst.bak"
  fi
  ln -sfn "$src" "$dst"
  echo "  $dst -> $src"
}

echo "Setting up dotfiles from $DOTFILES"

link "$DOTFILES/claude/settings.json"     "$HOME/.claude/settings.json"
link "$DOTFILES/claude/CLAUDE.md"         "$HOME/.claude/CLAUDE.md"
link "$DOTFILES/claude/RTK.md"            "$HOME/.claude/RTK.md"
link "$DOTFILES/claude/statusline.sh"     "$HOME/.claude/statusline.sh"
link "$DOTFILES/claude/hooks/rtk-rewrite.sh" "$HOME/.claude/hooks/rtk-rewrite.sh"
link "$DOTFILES/git/.gitconfig"           "$HOME/.gitconfig"
link "$DOTFILES/zsh/.zshrc"              "$HOME/.zshrc"
link "$DOTFILES/home/CLAUDE.md"          "$HOME/CLAUDE.md"

echo "Done."
