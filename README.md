# dotfiles

Managed with [chezmoi](https://chezmoi.io). Covers zsh, bash, git, ssh config,
iTerm2 prefs, and pulls [config.nvim](https://github.com/dkomeza/config.nvim)
into `~/.config/nvim`.

## New machine

    sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply dkomeza

Then set up the pieces that are deliberately not in the repo: SSH keys and
tokens.

## SSH keys

`~/.ssh/config` and `~/.gitconfig` expect these files (all ed25519):

| File                       | Used for                          |
| -------------------------- | --------------------------------- |
| `~/.ssh/dkomeza@github.com` | GitHub auth (clone, push)         |
| `~/.ssh/dkomeza@git`        | Git commit signing (`.gitconfig`) |
| `~/.ssh/gitlab.pem`         | gl.swmansion.com auth             |

Generate them:

    ssh-keygen -t ed25519 -f ~/.ssh/dkomeza@github.com -C "dkomeza@$(hostname)"
    ssh-keygen -t ed25519 -f ~/.ssh/dkomeza@git -C "dkomeza@$(hostname)"
    ssh-keygen -t ed25519 -f ~/.ssh/gitlab.pem -C "dkomeza@$(hostname)"

Register the public keys. GitHub, via `gh` (`brew install gh`, `gh auth login`):

    gh ssh-key add ~/.ssh/dkomeza@github.com.pub --title "$(hostname)"
    gh ssh-key add ~/.ssh/dkomeza@git.pub --type signing --title "$(hostname) signing"

Or paste `~/.ssh/*.pub` by hand at https://github.com/settings/keys (add the
signing key as type "Signing Key", otherwise commit verification fails).

GitLab: paste `~/.ssh/gitlab.pem.pub` at
https://gl.swmansion.com/-/user_settings/ssh_keys.

Check:

    ssh -T git@github.com
    ssh -T git@gl.swmansion.com

## Tokens

`~/.zshrc` sources `~/.zshrc.local` (not tracked). Create it with:

    export NPM_TOKEN=ghp_...

`NPM_TOKEN` is a GitHub personal access token with `read:packages`, used to
install private `@runna-app/*` packages. Create it at
https://github.com/settings/tokens (classic) or with:

    gh auth token   # if gh was logged in with the read:packages scope

## Day to day

    chezmoi edit ~/.zshrc   # edit the managed copy, then chezmoi apply
    chezmoi add ~/.zshrc    # or edit in place and re-add
    chezmoi diff            # what apply would change
    chezmoi cd              # commit and push from the source repo
