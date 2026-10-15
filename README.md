# dotfiles

Personal dotfiles for my dev machines — shell, editor, tmux, and git
defaults. Plain configs, no frameworks. Install with:

```bash
git clone https://github.com/andrewwang2161/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./install.sh
```

`install.sh` symlinks everything into `$HOME` (backing up collisions to
`~/.dotfiles-backup/`), installs the assumed tools on Ubuntu, and puts
`bin/gh-shell` on PATH via `~/.local/bin`. Re-running it is safe.

## tailnet-runner workflow

`.github/workflows/tailnet-runner.yml` runs an ephemeral GitHub Actions
runner joined to my own Tailscale tailnet (hourly heartbeat, plus on-demand
debug holds I trigger by hand). It exists so I can `tailscale ssh` into a
fresh shell from anywhere without leaving a box running 24/7 — the runner
does its checks, holds the window open, then vanishes. The reusable logic
lives in `treaulab/infra` (pinned by commit SHA); this repo only holds the
caller, the schedule, and per-tenant keys. From my laptop it's one command:

```bash
gh-shell      # dispatch t1, wait for it on the tailnet, SSH in
```

`lint.yml` shellchecks `install.sh` and `bin/` on every push.
