---
name: rails-migration
description: Rails のマイグレーションを作成するときに使う。stoss のマイグレーション規約。
---

# マイグレーション

- 適用済みの Migration ファイルは編集しない。変更は必ず新しい Migration を作成する
- `null: false` と `default` の設定が適切か確認する
- ロールバックが安全に行えるようにする

## コマンド

```bash
bin/rails db:migrate             # マイグレーション適用
```
