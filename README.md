# dotfiles

## セットアップ

**先に依存ツールを入れてからsetup.shを実行する。**

```bash
# 1. jqをインストール（これがないとステータスバーが --- のまま表示される）
sudo apt install jq

# 2. dotfilesをクローンしてシンボリックリンクを作成
git clone git@github.com:shiru2/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash setup.sh
```

## 依存ツール

| ツール | 用途 | インストール |
|---|---|---|
| `jq` | statusline.shのJSON解析 | `sudo apt install jq` |
| `rtk` | Claude Codeトークン節約プロキシ | 下記参照 |

```bash
# RTK
curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
~/.local/bin/rtk init
```

## Claude Code statusline

ターミナルに以下のような状態を常時表示する設定。

```
cx ▰▰▱▱▱▱▱▱▱▱  22% | Sonnet 4.6 | master | +36/-0
5h ▱▱▱▱▱▱▱▱▱▱   4% |      4時間 26分でリセット
7d ▰▰▱▱▱▱▱▱▱▱  22% | 3日 14時間 36分でリセット
```

| 行 | 内容 |
|---|---|
| `cx` | コンテキストウィンドウ使用率・モデル名・Gitブランチ |
| `5h` | 5時間レートリミット使用率 |
| `7d` | 7日レートリミット使用率 |

`setup.sh` 実行後、`~/.claude/settings.json` の `statusLine` 設定と `~/.claude/statusline.sh` が有効になる。

## 管理ファイル一覧

| dotfiles | リンク先 |
|---|---|
| `claude/CLAUDE.md` | `~/.claude/CLAUDE.md` |
| `claude/RTK.md` | `~/.claude/RTK.md` |
| `claude/settings.json` | `~/.claude/settings.json` |
| `claude/statusline.sh` | `~/.claude/statusline.sh` |
| `claude/hooks/rtk-rewrite.sh` | `~/.claude/hooks/rtk-rewrite.sh` |
| `git/.gitconfig` | `~/.gitconfig` |
| `zsh/.zshrc` | `~/.zshrc` |
| `home/CLAUDE.md` | `~/CLAUDE.md` |
