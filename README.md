# dotfiles

zsh設定ファイルの管理リポジトリ

## 構成

```
.zshrc          # zsh設定
zsh/            # プラグイン（サブモジュール）
install.sh      # セットアップスクリプト
```

## 新しいPCでのセットアップ

```bash
git clone git@github.com:KazukiTakeuchi/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./install.sh
source ~/.zshrc
```

## 運用

### 設定を変更したとき（このPC）

```bash
cd ~/dotfiles
git add -A && git commit -m "変更内容" && git push
```

### 他のPCで最新を取得

```bash
cd ~/dotfiles && git pull
```

## 含まれる設定

- ヒストリー共有・重複除外
- 補完（大文字小文字無視）
- エイリアス（ls, ll, grep）
- プラグイン: zsh-syntax-highlighting, zsh-autosuggestions
- Starship プロンプト
