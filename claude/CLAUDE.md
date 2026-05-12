# Claude Code 設定メモ

## 自動更新の無効化（2026-04-13）

**現在のバージョン: 2.1.98**（意図的に固定中）

### 理由
anthropics/claude-code#46917 — v2.1.100/2.1.101 でリクエストごとに約20,000トークン余分に消費される問題（約40%の課金増加）。
Anthropic 側の修正待ちのため、v2.1.98 に固定している。

### 設定内容
`~/.claude/settings.json` に以下を追加済み：
```json
"env": {
  "DISABLE_AUTOUPDATER": "1"
}
```

### 解除方法
issue が解決したら：
1. `settings.json` から `DISABLE_AUTOUPDATER` の行を削除
2. `claude update` で最新版に更新

---

## コマンド提示のルール

長いコマンドを提示するときは、**必ずバックスラッシュ `\` + 改行で折り返す**こと。

### 理由
- Claude の出力意図による改行と、画面幅による意図しない改行が重なり、コピペ時にコマンドが途中で切れる
- 特に `open "$(wslpath -w ...)"` のようなパスが長いコマンドで発生しやすい

### ルール
```bash
# NG: 一行が長すぎる
open "$(wslpath -w /home/shiru/2024/2026DIFFUSION/research/reports/20260425_report.html)"

# OK: バックスラッシュで折り返す
open "$(wslpath -w \
  /home/shiru/2024/2026DIFFUSION/research/reports/20260425_report.html)"
```

- `\` の直後にスペースを入れると無効になるので注意
- スクリプトのパス・長いオプション列など、80文字を超えそうな箇所で折り返す
- **`open` は `explorer.exe` のラッパーで exit 1 を返すが正常に動作する。`powershell.exe` や `Invoke-Item` は使わず必ず `open` を使うこと**
