#!/bin/bash

set -e

DOTFILES_DIR="$HOME/dotfiles"

echo "Setting up dotfiles..."

# Initialize and update submodules (for plugins)
cd "$DOTFILES_DIR"
git submodule update --init --recursive

# Backup existing files and create symlinks
backup_and_link() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        echo "Backing up $dest to ${dest}.backup"
        mv "$dest" "${dest}.backup"
    fi

    if [ -L "$dest" ]; then
        rm "$dest"
    fi

    echo "Creating symlink: $dest -> $src"
    ln -s "$src" "$dest"
}

# Link configuration files
backup_and_link "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# Claude Code configuration
echo "Setting up Claude Code configuration..."

mkdir -p "$HOME/.claude/plugins"

backup_and_link "$DOTFILES_DIR/claude/settings.json" "$HOME/.claude/settings.json"
backup_and_link "$DOTFILES_DIR/claude/settings.local.json" "$HOME/.claude/settings.local.json"
backup_and_link "$DOTFILES_DIR/claude/skills" "$HOME/.claude/skills"
backup_and_link "$DOTFILES_DIR/claude/plugins/installed_plugins.json" "$HOME/.claude/plugins/installed_plugins.json"

# MCP servers
echo "Setting up MCP servers..."

if command -v claude &> /dev/null; then
    claude mcp add -s user playwright -- npx @playwright/mcp@latest
    claude mcp add -s user sequential-thinking -- npx -y @modelcontextprotocol/server-sequential-thinking
    echo "MCP servers configured."
else
    echo "Warning: claude command not found. Skipping MCP server setup."
    echo "Install Claude Code and run: claude mcp add -s user playwright -- npx @playwright/mcp@latest"
fi

echo "Done! Please restart your shell or run: source ~/.zshrc"
