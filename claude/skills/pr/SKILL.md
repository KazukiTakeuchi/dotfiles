---
name: pr
description: プルリクエストアシスタント。PRの作成・更新を行います。「PRを作成して」「プルリクエストを作って」「PR作って」「PRを更新して」などのリクエストで発動します。
allowed-tools: Read, Grep, Bash(git:*, gh:*)
---

# プルリクエストアシスタント

## 手順

1. `git branch --show-current`、`git status`、`gh pr view --json number,title,body,url` で状態確認

2. **既存PRあり → 更新**
   - `gh pr diff`、`git log origin/<base>..HEAD` で差分分析
   - 新しい変更を既存説明に反映
   - `gh pr edit --body/--title` で更新

3. **既存PRなし → 新規作成**
   - デフォルトブランチ検出、全コミット・全差分を確認
   - 未コミット/未pushがあれば確認
   - **「なぜこの変更が必要か」を理解してPR説明生成**
   - `gh pr create` で作成（HEREDOC使用）

4. PRのURL表示

## PR説明形式

```markdown
## 概要
<なぜこのPRが必要か、どんな問題を解決するか>

## 変更内容
<主要な変更をリスト化>

## テスト方法
<具体的なテスト手順>

## 備考（該当時）
<破壊的変更、マイグレーション等>
```

## ルール

- main/masterからPR作成禁止
- 最新コミットだけでなく全コミットをレビューして反映
- 作成前に必ず確認
- PRは英語、応答はユーザーの言語
