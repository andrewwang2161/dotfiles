#!/usr/bin/env bash
# install.sh — symlink this repo's dotfiles into $HOME + install assumed tools.
# Safe to re-run: anything it would overwrite is backed up to ~/.dotfiles-backup/<date>/.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

FILES=".zshrc .vimrc .tmux.conf .gitconfig .gitignore_global"

link_one() {
  local src="$DOTFILES_DIR/$1" dst="$HOME/$1"
  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    echo "ok: $1 already linked"
    return
  fi
  if [[ -e "$dst" || -L "$dst" ]]; then
    mkdir -p "$BACKUP_DIR"
    mv "$dst" "$BACKUP_DIR/"
    echo "backup: $1 -> $BACKUP_DIR/"
  fi
  ln -s "$src" "$dst"
  echo "link: $1"
}

for f in $FILES; do
  [[ -f "$DOTFILES_DIR/$f" ]] || { echo "skip: $f (not in repo)"; continue; }
  link_one "$f"
done

# tools these dotfiles assume (no-op if present)
if command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update -qq
  sudo apt-get install -y -qq git vim tmux curl jq zsh shellcheck
else
  echo "note: no apt-get — install git/vim/tmux/curl/jq/zsh yourself"
fi

# helper scripts on PATH via ~/.local/bin (chmod: GitHub API uploads land 0644)
mkdir -p "$HOME/.local/bin"
if [[ -f "$DOTFILES_DIR/bin/gh-shell" ]]; then
  chmod +x "$DOTFILES_DIR/bin/gh-shell"
  ln -sf "$DOTFILES_DIR/bin/gh-shell" "$HOME/.local/bin/gh-shell"
  echo "link: bin/gh-shell -> ~/.local/bin/gh-shell"
fi

echo "done. Restart your shell (or: exec zsh)."
