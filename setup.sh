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

# 既存ファイルがあれば上書きしないコピー（アプリ自身が書き換える設定ファイル用）
copy_if_absent() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ]; then
    echo "  $dst exists — skipped (template: $src)"
  else
    cp "$src" "$dst"
    echo "  $dst <- $src (copied)"
  fi
}

echo "Setting up dotfiles from $DOTFILES"

# --- 共有ファイル（全プラットフォーム共通） ---
link "$DOTFILES/claude/RTK.md"              "$HOME/.claude/RTK.md"
link "$DOTFILES/claude/statusline.sh"       "$HOME/.claude/statusline.sh"
link "$DOTFILES/claude/hooks/rtk-rewrite.sh" "$HOME/.claude/hooks/rtk-rewrite.sh"
link "$DOTFILES/home/CLAUDE.md"             "$HOME/CLAUDE.md"
link "$DOTFILES/codex/AGENTS.md"            "$HOME/.codex/AGENTS.md"

# zsh-autosuggestions（.zshrc が読み込む）
if [ ! -d "$HOME/.zsh/zsh-autosuggestions" ] && command -v git >/dev/null; then
  git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions "$HOME/.zsh/zsh-autosuggestions"
fi

# --- プラットフォーム別ファイル ---
OS="$(uname -s)"
case "$OS" in
  Darwin)
    echo "Detected: macOS"
    link "$DOTFILES/mac/claude/settings.json"  "$HOME/.claude/settings.json"
    link "$DOTFILES/mac/claude/CLAUDE.md"      "$HOME/.claude/CLAUDE.md"
    link "$DOTFILES/mac/git/.gitconfig"        "$HOME/.gitconfig"
    link "$DOTFILES/mac/zsh/.zshrc"            "$HOME/.zshrc"
    link "$DOTFILES/mac/ghostty/config"        "$HOME/.config/ghostty/config"
    copy_if_absent "$DOTFILES/mac/codex/config.toml" "$HOME/.codex/config.toml"
    ;;
  Linux)
    # WSL or native Linux
    echo "Detected: Linux"
    link "$DOTFILES/claude/settings.json"      "$HOME/.claude/settings.json"
    link "$DOTFILES/claude/CLAUDE.md"          "$HOME/.claude/CLAUDE.md"
    link "$DOTFILES/git/.gitconfig"            "$HOME/.gitconfig"
    link "$DOTFILES/zsh/.zshrc"               "$HOME/.zshrc"

    # Windows Terminal（WSL環境のみ）
    WIN_USER=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')
    if [ -n "$WIN_USER" ]; then
      WT_DIR="/mnt/c/Users/${WIN_USER}/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState"
      if [ -d "$WT_DIR" ]; then
        cp "$DOTFILES/windows-terminal/settings.json" "$WT_DIR/settings.json"
        echo "  Windows Terminal settings copied"
      fi
    fi
    ;;
  *)
    echo "Unknown OS: $OS — skipping platform-specific files"
    ;;
esac

echo "Done."
