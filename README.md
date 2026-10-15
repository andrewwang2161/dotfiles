# dotfiles

Personal dotfiles for my dev machines — shell, editor, tmux, and git
defaults. Plain configs, no frameworks. Symlink into place with:

```bash
git clone https://github.com/andrewwang2161/dotfiles.git ~/.dotfiles
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
```

## tailnet-runner workflow

`.github/workflows/tailnet-runner.yml` runs an ephemeral GitHub Actions
runner joined to my own Tailscale tailnet (hourly heartbeat, plus on-demand
debug holds I trigger by hand). It exists so I can `tailscale ssh` into a
fresh shell from anywhere without leaving a box running 24/7 — the runner
does its checks, holds the window open, then vanishes. The reusable logic
lives in `treaulab/infra` (pinned by commit SHA); this repo only holds the
caller, the schedule, and per-tenant keys in Environment secrets.
