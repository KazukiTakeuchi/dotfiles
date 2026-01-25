---
name: commit
description: Git コミットアシスタント。コードの変更をコミットする際に使用します。「コミットして」「変更を保存して」「commitして」などのリクエストで発動します。
allowed-tools: Read, Grep, Bash(git:*)
---

# Git コミットアシスタント

## 手順

1. `git status`、`git diff`、`git diff --cached`、`git log --oneline -10` で状態確認
2. 変更の意図・目的を推測し、分割が必要か判断
3. コミットメッセージ生成（Conventional Commits: `type(scope): 説明`）
4. ステージするファイルをユーザーに提示し確認
5. 確認後コミット実行、結果表示

## コミットメッセージ

- Types: feat, fix, docs, style, refactor, perf, test, build, ci, chore
- 1行目72文字以内、複雑な変更は空行後に詳細
- **「何を変更したか」ではなく「なぜ変更したか」を記述**

**悪い例**: `fix: change timeout from 5000 to 10000`
**良い例**: `fix: 大きなファイルアップロード時のタイムアウトを解決`

## ステージ対象の選択

**絶対禁止**: .env、credentials、keys、tokens、node_modules、dist、build、.idea、.vscode/settings.json、ログ、一時ファイル

**確認必要**: lockファイル、設定ファイル、大量のファイル変更

## ルール

- `git add .` 禁止 - 個別にファイル指定
- ステージ前に必ずユーザー確認
- push禁止（明示依頼時のみ）
- ユーザーの言語で応答
