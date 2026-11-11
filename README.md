# Dotfiles

## 入れ方

```bash
git clone https://github.com/Ryooo-k/dotfiles ~/dotfiles
~/dotfiles/install.sh          # シェル・git・vim と Claude の設定をすべてリンクする
~/dotfiles/install-claude.sh   # Claude の設定だけをリンクする
```

`install.sh` は `~/.zshrc` などを上書きするので、手元のほうが新しいときは先に dotfiles へ取り込む。

## Claude Code の個人設定（`.claude/`）

`install-claude.sh` が `~/.claude/` に 1 つずつリンクする。既にある実ファイルは `<名前>.bak-<日時>` に退避する。skill・agent を足した・消したときは、もう一度実行する。

| 種類 | 名前 | 役割 |
|---|---|---|
| 全体 | `CLAUDE.md` | 対話スタイル・書き方・判断の求め方・作業の進め方 |
| skill | `dev-review` | レビューの共通の手順（重要度・別セッションのセルフレビュー・保守性・指摘の検証） |
| skill | `rails-review` / `react-review` | Rails / React の観点（React は使うプロジェクトだけ） |
| skill | `rails-test` / `react-test` | Minitest / React のテストの規約 |
| skill | `rails-migration-rules` | マイグレーションの規約 |
| skill | `dev-plan` | 実装計画の項目・計画のレビュー・止めて確認する条件 |
| skill | `dev-bugfix` | 再現テストを先に書くバグ修正 |
| skill | `dev-git-workflow` | ブランチ・コミット・PR |
| agent | `generic-self-reviewer` / `generic-plan-reviewer` | 会話を引き継がない読み取り専用のレビュー役（Fable） |

- 個人の skill は、同じ名前のプロジェクトの skill より優先される。プロジェクトの skill と名前が重ならないよう `dev-`・`rails-`・`react-` などを付ける
- 各 skill の説明文に「プロジェクトに専用の skill があるときは使わない」と書いてある。プロジェクトの skill のほうが詳しいため
- 公開リポジトリなので、事業・契約・個人の情報は書かない
