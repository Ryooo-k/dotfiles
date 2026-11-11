---
name: rails-test
description: Rails のテスト（Minitest）を作成・修正するときに使う規約。日本語のテスト名、正常・異常・境界。プロジェクトに専用のテスト skill（crossnudge-test など）があるときは使わない。
---

# Rails のテスト

## 方針

- テスト名は日本語で書く（例: `test "名前が空なら保存できない" do`）
- 正常系・異常系・境界値をカバーする
- テスト用データと期待値は各テスト内に明示し、汎用 helper で隠さない
- 期待値は仕様から書く。実装を動かした結果を写さない
- バリデーションの失敗ケースを明示的にテストする
- 外部への送信（HTTP・メール・課金など）はスタブし、テストから実際に外へ出さない
- コミット前に全テストが通ることを確認する

## 実行

```bash
bin/rails test                      # 全テスト
bin/rails test test/path/file.rb    # 単一ファイル
bin/rails test test/path/file.rb:42 # 特定行
```

テストデータの作り方（fixtures・ファクトリ）は、プロジェクトの既存のやり方に合わせる。
