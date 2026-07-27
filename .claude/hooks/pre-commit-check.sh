#!/usr/bin/env bash
# PreToolUse フック: git commit 実行直前のチェック。
# - main への直接コミットを禁止
# - コミットメッセージへの Co-Authored-By 混入を禁止
# - bin/rubocop / yarn lint を実行し、失敗したらコミットをブロック
# 失敗時は exit 2 で Bash ツールの実行を中断する。

set -uo pipefail

# stdin の JSON からツールに渡された bash コマンドを取り出す
input="$(cat)"
if command -v jq >/dev/null 2>&1; then
  cmd="$(printf '%s' "$input" | jq -r '.tool_input.command // empty')"
else
  cmd="$input"
fi

# 実際に git commit を呼ぶコマンドかを判定する。
# 文字列 "git commit" を含むだけのもの（echo・クオート内の言及・git commit-tree 等）は対象外。
# git は行頭/コマンド区切りの後、commit は語境界（直後が空白か行末）であることを要求する。
if ! printf '%s' "$cmd" | grep -Eq '(^|[[:space:];&|()])git([[:space:]]+-[^[:space:]]+)*[[:space:]]+commit([[:space:]]|$)'; then
  exit 0
fi

cd "${CLAUDE_PROJECT_DIR:-.}" || exit 0

# rbenv が使える環境ではプロジェクトの Ruby を有効化する。
# 非ログインシェルだと /usr/bin/ruby(system) が優先され、Gemfile を解釈できず失敗するため。
if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init - bash)"
fi

# main 直コミット禁止
branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
if [ "$branch" = "main" ]; then
  echo "main ブランチへの直接コミットは禁止です。作業用ブランチを作成してください。" >&2
  exit 2
fi

# Co-Authored-By 混入禁止
if printf '%s' "$cmd" | grep -qi "Co-Authored-By"; then
  echo "コミットメッセージに Co-Authored-By を含めないでください。" >&2
  exit 2
fi

# rubocop
if ! bin/rubocop >&2; then
  echo "bin/rubocop が失敗しました。修正してから再コミットしてください。" >&2
  exit 2
fi

# ESLint
if ! yarn lint >&2; then
  echo "yarn lint が失敗しました。修正してから再コミットしてください。" >&2
  exit 2
fi

exit 0
