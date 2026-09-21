# dotfiles

Managed with [chezmoi](https://chezmoi.io). Covers zsh, bash, git, ssh config,
iTerm2 prefs, and pulls [config.nvim](https://github.com/dkomeza/config.nvim)
into `~/.config/nvim`.

## New machine

    sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply dkomeza

Then create `~/.zshrc.local` for secrets (not tracked):

    export NPM_TOKEN=...

## Day to day

    chezmoi edit ~/.zshrc   # edit the managed copy, then chezmoi apply
    chezmoi add ~/.zshrc    # or edit in place and re-add
    chezmoi diff            # what apply would change
    chezmoi cd              # commit and push from the source repo
