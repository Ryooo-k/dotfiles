---
name: stoss-test
description: stoss プロジェクトのテストを作成・修正するときに使う。Rails（Minitest）と React（Vitest）両方のテスト規約。
---

# テスト

## 共通方針

- テスト名は日本語で書く
- 正常系・異常系・境界値をカバーする
- テスト用データと期待値は各テスト内に明示し、汎用 helper で隠さない
- コミット前に全テストが通ることを確認する

## バックエンド（Rails / Minitest）

- `bin/rails test` で実行する
- バリデーションの失敗ケースを明示的にテストする
- テストファクトリ: `test/support/record_factory.rb` の `RecordFactory` を `test_helper.rb` でインクルード済み。`create_user`・`create_card`・`create_deck`・`create_battle` などをテスト内で直接呼べる

```bash
bin/rails test                      # 全テスト実行
bin/rails test test/path/file.rb    # 単一ファイル
bin/rails test test/path/file.rb:42 # 特定行
```

## フロントエンド（React / Vitest）

- `yarn test`（vitest run）で実行する。テストは `test/javascript/` 配下に置く
- コンポーネントはレンダリング結果と振る舞い（イベント・状態遷移）を検証する
- ActionCable の購読や `fetchWithAuth` などの外部依存はモックする
- 非同期（API・WebSocket）の正常系・失敗系・ローディング状態をカバーする

```bash
yarn test        # 全テスト実行（vitest run）
yarn test:watch  # ウォッチモード
yarn lint        # ESLint
```
