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

# Plugins (from dotfiles)
source ~/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Autosuggestions color (subtle gray for Catppuccin)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'

# Starship prompt
eval "$(starship init zsh)"
