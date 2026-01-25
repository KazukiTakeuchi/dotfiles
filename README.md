# dotfiles

zsh設定・Claude Code設定の管理リポジトリ

## 構成

```
.zshrc              # zsh設定
zsh/                # zshプラグイン（サブモジュール）
claude/             # Claude Code設定
  settings.json         # 有効なプラグイン設定
  settings.local.json   # 権限設定
  skills/               # カスタムスキル
  plugins/              # プラグインマニフェスト
install.sh          # セットアップスクリプト
```

---

## 新しいPCでのセットアップ

### 1. リポジトリをクローン

```bash
git clone git@github.com:KazukiTakeuchi/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. セットアップスクリプトを実行

```bash
./install.sh
```

これで以下のシンボリンクが作成される：
- `~/.zshrc` → `~/dotfiles/.zshrc`
- `~/.claude/settings.json` → `~/dotfiles/claude/settings.json`
- `~/.claude/settings.local.json` → `~/dotfiles/claude/settings.local.json`
- `~/.claude/skills` → `~/dotfiles/claude/skills`
- `~/.claude/plugins/installed_plugins.json` → `~/dotfiles/claude/plugins/installed_plugins.json`

### 3. シェルを再起動

```bash
source ~/.zshrc
```

### 4. Claude Codeを起動して確認

```bash
claude
```

スキル `/commit`, `/pr`, `/review`, `/understand` が使えることを確認。

---

## 運用方法

### このPCで設定を変更したとき

#### zsh設定（.zshrc）を変更した場合

```bash
cd ~/dotfiles
git add .zshrc
git commit -m "chore: update zshrc - 変更内容"
git push
```

#### Claude Codeの設定を変更した場合

**プラグインを有効/無効にした場合**（settings.jsonが更新される）：

```bash
cd ~/dotfiles
git add claude/settings.json
git commit -m "chore: update claude plugins"
git push
```

**権限設定を変更した場合**（settings.local.jsonが更新される）：

```bash
cd ~/dotfiles
git add claude/settings.local.json
git commit -m "chore: update claude permissions"
git push
```

**スキルを追加/編集した場合**：

```bash
cd ~/dotfiles
git add claude/skills/
git commit -m "feat: add/update skill - スキル名"
git push
```

### 他のPCで最新の設定を取得

```bash
cd ~/dotfiles
git pull
```

シンボリンクなので、pullするだけで即座に反映される。

---

## Claude Code設定の詳細

### 管理対象ファイル

| ファイル | 説明 | 編集方法 |
|---------|------|---------|
| `settings.json` | 有効なプラグイン | Claude Code内で `/plugins` で管理 |
| `settings.local.json` | Bash等の権限設定 | Claude Code使用中に自動更新 |
| `skills/` | カスタムスキル | 手動でファイル編集 |
| `plugins/installed_plugins.json` | インストール済みプラグイン | Claude Code内で自動更新 |

### 管理対象外（自動生成されるもの）

以下は各マシンで自動生成されるため、dotfilesには含めない：
- `~/.claude/cache/` - キャッシュ
- `~/.claude/debug/` - デバッグログ
- `~/.claude/history.jsonl` - コマンド履歴
- `~/.claude/projects/` - プロジェクト固有データ
- `~/.claude/todos/` - タスクデータ

### カスタムスキルの追加方法

1. スキルディレクトリを作成：
   ```bash
   mkdir -p ~/dotfiles/claude/skills/新スキル名
   ```

2. SKILL.mdを作成：
   ```bash
   cat > ~/dotfiles/claude/skills/新スキル名/SKILL.md << 'EOF'
   ---
   name: 新スキル名
   description: スキルの説明（Claudeが自動発動する条件）
   allowed-tools: Read, Grep, Bash(git:*)
   ---

   # スキルのタイトル

   ## 手順
   1. ...
   EOF
   ```

3. シンボリンクが既に張られているため、即座に使用可能

4. コミット：
   ```bash
   cd ~/dotfiles
   git add claude/skills/新スキル名
   git commit -m "feat: add skill - 新スキル名"
   git push
   ```

### スキルの削除方法

```bash
rm -rf ~/dotfiles/claude/skills/削除するスキル名
cd ~/dotfiles
git add -A
git commit -m "chore: remove skill - スキル名"
git push
```

---

## トラブルシューティング

### シンボリンクが壊れている場合

```bash
cd ~/dotfiles
./install.sh
```

既存ファイルは `.backup` としてバックアップされる。

### Claude Codeで設定が反映されない場合

1. シンボリンクを確認：
   ```bash
   ls -la ~/.claude/settings.json
   # 出力例: ~/.claude/settings.json -> /Users/xxx/dotfiles/claude/settings.json
   ```

2. Claude Codeを再起動

### 新しいマシンでプラグインが動かない場合

`installed_plugins.json` はプラグインの一覧のみ。プラグイン本体は初回起動時にダウンロードされる。
インターネット接続を確認し、Claude Codeを再起動。

---

## 含まれる設定

### zsh
- ヒストリー共有・重複除外
- 補完（大文字小文字無視）
- エイリアス（ls, ll, grep）
- プラグイン: zsh-syntax-highlighting, zsh-autosuggestions
- Starship プロンプト

### Claude Code
- カスタムスキル: commit, pr, review, understand
- プラグイン: frontend-design, feature-dev, ralph-wiggum, typescript-lsp, pyright-lsp
- 権限設定: ssh, git操作の許可設定
