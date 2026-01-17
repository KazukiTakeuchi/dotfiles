# Path
export PATH="$HOME/.local/bin:$PATH"

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt hist_ignore_dups

# Completion
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Colors for ls
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Aliases with colors
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias grep='grep --color=auto'

# Directory navigation
setopt auto_cd           # ディレクトリ名だけで移動
setopt auto_pushd        # cd時に自動でpushd
setopt pushd_ignore_dups # 重複を無視
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'        # 直前のディレクトリに戻る

# mkcd: ディレクトリ作成して移動
mkcd() { mkdir -p "$1" && cd "$1" }

# fzf
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
source <(fzf --zsh)

# fzf便利関数
# fd: fzfでディレクトリ選択して移動
fd() {
  local dir
  dir=$(find ${1:-.} -type d 2>/dev/null | fzf) && cd "$dir"
}

# fh: fzfでヒストリー検索して実行
fh() {
  local cmd
  cmd=$(history -n 1 | fzf --tac) && print -z "$cmd"
}

# Plugins (from dotfiles)
source ~/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Autosuggestions color (subtle gray for Catppuccin)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'

# Starship prompt
eval "$(starship init zsh)"
