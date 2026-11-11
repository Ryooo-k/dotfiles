#!/usr/bin/env bash
# Claude Code の個人設定（CLAUDE.md・skill・agent）だけを ~/.claude にリンクする。
# ~/.claude/skills と ~/.claude/agents はディレクトリごとリンクしない
# （アプリが管理する skills/synced などが同じ場所にあるため）。1 つずつリンクする。
# 既にある実ファイル・実ディレクトリは、上書きせず <名前>.bak-<日時> に退避する。

set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
SRC="$DOTFILES/.claude"
DEST="$HOME/.claude"
STAMP="$(date +%Y%m%d%H%M%S)"

link() {
  local from="$1" to="$2"
  if [ -e "$to" ] && [ ! -L "$to" ]; then
    mv "$to" "$to.bak-$STAMP"
    echo "退避: $to -> $to.bak-$STAMP"
  fi
  ln -sfn "$from" "$to"
  echo "リンク: $to -> $from"
}

mkdir -p "$DEST/skills" "$DEST/agents"

link "$SRC/CLAUDE.md" "$DEST/CLAUDE.md"

for dir in "$SRC"/skills/*/; do
  name="$(basename "$dir")"
  link "${dir%/}" "$DEST/skills/$name"
done

for file in "$SRC"/agents/*.md; do
  link "$file" "$DEST/agents/$(basename "$file")"
done

# dotfiles から消した skill・agent のリンクを片付ける（リンク先が dotfiles の中で、もう無いものだけ）
for entry in "$DEST"/skills/* "$DEST"/agents/*; do
  [ -L "$entry" ] || continue
  target="$(readlink "$entry")"
  case "$target" in
    "$SRC"/*) [ -e "$target" ] || { rm "$entry"; echo "削除: $entry（リンク先が無い）"; } ;;
  esac
done

echo "Claude の設定をリンクしました。"
