---
name: git-workflow
description: ブランチ作成・コミット・PR 作成など git 操作を行うときに使う。stoss の git ワークフロー規約。
---

# git ワークフロー

## ブランチ

- ブランチ名は `<prefix>/<issue番号>-<説明>` の形式にする（例: `feature/15-create-cards-model`）
- prefix は変更内容に応じて使い分ける
  - `feature/` — 新機能
  - `refactor/` — リファクタリング
  - `fix/` — バグ修正
  - `test/` — テストのみ

## コミット

- コミット前に必ず `bin/rubocop`、`yarn lint`、`bin/rails test` を実行して CI が通ることを確認する
  - `bin/rubocop` と `yarn lint` は PreToolUse フック（`.claude/hooks/pre-commit-check.sh`）でも機械的に強制される
- main への直接コミット禁止・コミットメッセージへの `Co-Authored-By` 混入禁止も同フックで強制される
- メッセージは日本語・**要約1行のみ**（本文の説明は入れない）・**issue 番号を含めない**・`Co-Authored-By` を含めない
  - issue 番号は PR 本文にだけ記載する（下記 PR 参照）

## コミット計画の提示

コミット前に以下を提示し、承認を得てから commit する。
（作業ツリーが混在・変更が非自明なときは必須。自明な単一変更なら簡略可）

- **ブランチ**: 対象ブランチ（main でない・命名規約に沿う）
- **除外するもの**: ignore / stash / 無関係の WIP を明示（取り違え防止）
- **留意点**: hook で走る検査、コミット後の stash 復帰など

コミット内容は次の表にまとめる:

| 順序 | 対象ファイル | コミットメッセージ |
|------|-------------|-------------------|
| 1 | … | … |

- メッセージは要約1行のみ（日本語・issue 番号なし・本文説明なし・`Co-Authored-By` なし）
- 承認後、表の順に commit を実行する

## PR

- 対応 issue 番号を本文に記載する（例: `closes #15`）
- レビュー依頼前に CI がパスしていることを確認する
