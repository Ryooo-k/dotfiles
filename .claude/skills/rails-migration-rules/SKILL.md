---
name: rails-migration-rules
description: Rails のマイグレーションを作成するときに使う規約。プロジェクトに専用のマイグレーション skill（rails-migration など）があるときは使わない。
---

# マイグレーション

- ファイルは `bin/rails generate migration <名前>` で作る。ファイル名の番号（作った時刻）を手で付けない・書き換えない
  - 切りのいい番号を手で付けると、並行する別の作業と番号が重なる。同じ番号が 2 つあると、テストも `db:migrate` も起動時に止まる（`ActiveRecord::DuplicateMigrationVersionError`）
  - push の前に `git fetch` して、`origin/main` の `db/migrate` に同じ番号が無いことを確かめる。あれば、まだマージしていない自分の側を作り直す（ファイル名の番号と `db/schema.rb` の版数）
- 適用済みの Migration ファイルは編集しない。変更は必ず新しい Migration を作成する
- `null: false` と `default` の設定が適切か確認する
- 検索・結合・一意性に使うカラムにインデックスを付ける。モデルの uniqueness には一意インデックスを合わせる
- ロールバックが安全に行えるようにする（`change` で戻せない操作は `up` / `down` に分ける）
- データの移し替えを伴う変更は、既存データへの影響と戻し方を PR に書く。本番に流れる時点（デプロイ時の `db:prepare` など）を確かめる

```bash
bin/rails generate migration AddXToY  # 作成（番号は生成コマンドが付ける）
bin/rails db:migrate                  # 適用
bin/rails db:rollback                 # 1 つ戻す
```
