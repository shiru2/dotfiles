# dotfiles

## セットアップ

**先に依存ツールを入れてからsetup.shを実行する。**

### WSL (Ubuntu)

```bash
# 1. jqをインストール（これがないとステータスバーが --- のまま表示される）
sudo apt install jq

# 2. Node.js をインストール（Claude Codeに必要）
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
source ~/.zshrc
nvm install --lts

# 3. Claude Code をインストール
npm install -g @anthropic-ai/claude-code

# 4. dotfilesをクローンしてシンボリックリンクを作成
git clone git@github.com:shiru2/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash setup.sh
```

> **注意**: Claude Codeのインストール後、`claude` コマンドが見つからない場合は `export PATH="$HOME/.local/bin:$PATH"` を実行してから再試行する。

### macOS

```bash
# 1. Homebrew をインストール（未導入の場合）
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# 2. dotfilesをクローン（SSH鍵未設定なら HTTPS: https://github.com/shiru2/dotfiles.git）
git clone git@github.com:shiru2/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 3. dotfiles に必要な最低限のツールをインストール（その他のアプリは各自で）
brew bundle --file=mac/Brewfile

# 4. Claude Code / Codex CLI をインストール
npm install -g @anthropic-ai/claude-code @openai/codex

# 5. シンボリックリンク作成（既存ファイルは .bak に退避される）
bash setup.sh

# 6. スキル（yomiyasu, Cloudflare など）をインストール
bash install-skills.sh

# 7. APIキーなどの秘密情報は ~/.zshrc.local に記述（コミットされない）
echo 'export OPENAI_API_KEY="sk-..."' >> ~/.zshrc.local

# 8. ログイン
gh auth login
claude   # 起動後 /login
codex login
```

> Codex の `~/.codex/config.toml` はリンクではなく、無い場合だけテンプレートをコピーする（Codex がプロジェクトの信頼設定などを書き込むため）。共通設定を変えたら `mac/codex/config.toml` を手で更新する。

## 依存ツール

| ツール | 用途 | インストール |
|---|---|---|
| `jq` | statusline.shのJSON解析 | `sudo apt install jq` / `brew install jq` |
| Cascadia Code | WSL/PowerShell での ▰▱ 表示 | Windows Terminal設定で自動適用（setup.sh実行時） |
| **DejaVu Sans Mono** | **cmd での ▰▱ 表示（これがないと文字崩れ）** | Windows Terminal の cmd プロファイルに設定済み |
| `rtk` | Claude Codeトークン節約プロキシ | 下記参照 |
| `eza` | ls の代替（macOS） | `brew install eza` |
| `fzf` | ファジーファインダー | `brew install fzf` / `sudo apt install fzf` |
| Node.js / `npx` | Claude Code・Codex・`install-skills.sh` | `brew install node` |
| PlemolJP NF | Ghostty のフォント | `brew install --cask font-plemol-jp-nf` |


```bash
# RTK
curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
~/.local/bin/rtk init
```

## Claude Code statusline

ターミナルに以下のような状態を常時表示する設定。

```
cx ▰▰▱▱▱▱▱▱▱▱  22% | Sonnet 4.6 | master | +36/-0
5h ▱▱▱▱▱▱▱▱▱▱   4% |      4h 26m
7d ▰▰▱▱▱▱▱▱▱▱  22% | 3d 14h 36m
```

| 行 | 内容 |
|---|---|
| `cx` | コンテキストウィンドウ使用率・モデル名・Gitブランチ |
| `5h` | 5時間レートリミット使用率 |
| `7d` | 7日レートリミット使用率 |

`setup.sh` 実行後、`~/.claude/settings.json` の `statusLine` 設定と `~/.claude/statusline.sh` が有効になる。

## ディレクトリ構成

```
dotfiles/
├── claude/              # 共有（全プラットフォーム共通）
│   ├── CLAUDE.md        # WSL用 Claude設定メモ
│   ├── RTK.md
│   ├── settings.json    # WSL用 settings
│   ├── statusline.sh    # 共通 statusline
│   └── hooks/
│       └── rtk-rewrite.sh
├── codex/
│   └── AGENTS.md        # Codex のグローバル指示（共通）
├── mac/                 # macOS固有
│   ├── Brewfile         # brew bundle 用パッケージ一覧
│   ├── claude/
│   │   ├── CLAUDE.md
│   │   └── settings.json
│   ├── codex/config.toml # Codex 設定テンプレート（無ければコピー）
│   ├── ghostty/config
│   ├── git/.gitconfig
│   └── zsh/.zshrc
├── git/.gitconfig       # WSL用
├── zsh/.zshrc           # WSL用
├── home/CLAUDE.md       # ~/CLAUDE.md（共通）
├── windows-terminal/    # Windows Terminal設定
├── install-skills.sh    # Claude Code / Codex 用スキルの取得
└── setup.sh             # セットアップスクリプト（OS自動判定）
```

## 管理ファイル一覧

### 共通
| dotfiles | リンク先 |
|---|---|
| `claude/RTK.md` | `~/.claude/RTK.md` |
| `claude/statusline.sh` | `~/.claude/statusline.sh` |
| `claude/hooks/rtk-rewrite.sh` | `~/.claude/hooks/rtk-rewrite.sh` |
| `home/CLAUDE.md` | `~/CLAUDE.md` |
| `codex/AGENTS.md` | `~/.codex/AGENTS.md` |

### WSL
| dotfiles | リンク先 |
|---|---|
| `claude/CLAUDE.md` | `~/.claude/CLAUDE.md` |
| `claude/settings.json` | `~/.claude/settings.json` |
| `git/.gitconfig` | `~/.gitconfig` |
| `zsh/.zshrc` | `~/.zshrc` |
| `windows-terminal/settings.json` | Windows Terminal設定 |

### macOS
| dotfiles | リンク先 |
|---|---|
| `mac/claude/CLAUDE.md` | `~/.claude/CLAUDE.md` |
| `mac/claude/settings.json` | `~/.claude/settings.json` |
| `mac/git/.gitconfig` | `~/.gitconfig` |
| `mac/zsh/.zshrc` | `~/.zshrc` |
| `mac/ghostty/config` | `~/.config/ghostty/config` |
| `mac/codex/config.toml` | `~/.codex/config.toml`（無い場合のみコピー） |
