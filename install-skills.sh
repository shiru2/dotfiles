#!/bin/bash
# Claude Code / Codex 共通のスキルをグローバルに入れる（要 Node.js / npx）
# スキル本体は各リポジトリが管理しているので、dotfiles には入れずにここから取得する
set -e

AGENTS=(-a claude-code -a codex)

npx -y skills@latest add nanaism/yomiyasu    -g "${AGENTS[@]}" -y
npx -y skills@latest add vercel-labs/skills  -g -a codex -s find-skills -y

# Cloudflare スキル: Claude Code はプラグイン（settings.json の enabledPlugins）で入るので Codex だけ
npx -y skills@latest add cloudflare/skills   -g -a codex -s '*' -y

echo "Done. 確認: npx skills ls -g"
