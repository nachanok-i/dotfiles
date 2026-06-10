# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal dotfiles for multiple UNIX machines (macOS and Linux), managed with GNU Stow. There is no build, lint, or test tooling — changes are verified by stowing a package and opening a new shell/app.

## GNU Stow conventions

Each top-level directory is a stow "package" whose contents mirror `$HOME`. For example, `zshrc/.zshrc` symlinks to `~/.zshrc`, and `ghostty-mac/.config/ghostty/config` symlinks to `~/.config/ghostty/config`.

```sh
stow zshrc          # symlink a package into $HOME (run from the repo root)
stow -D zshrc       # remove the symlinks
stow -R zshrc       # restow after adding/removing files in a package
```

When adding a new config file, place it inside an existing package (or a new package directory) at the path it should have relative to `$HOME` — never edit files directly in `$HOME`.

## OS-specific packages

Configs that differ between macOS and Linux are split into per-OS packages (e.g. `ghostty-mac` vs `ghostty-linux`). Only stow the package matching the current OS. The zsh config currently assumes macOS/Homebrew (`$HOMEBREW_PREFIX`, nvm, jenv), and `zprofile` is macOS-only (`brew shellenv`).

## Zsh setup

- The shell uses the **Zim framework** (migrated from oh-my-zsh): `zimrc/.zimrc` declares modules, `zshrc/.zshrc` configures and initializes them. Module order in `.zimrc` matters — completion must come after modules adding completions; syntax-highlighting, history-substring-search, and autosuggestions must stay last, in that order.
- `.zshrc` defines two prompt profiles as shell functions: `personal-mode` (Catppuccin two-line prompt, default) and `ai-mode` (minimal robbyrussell-style). Both are built on Zim's `git-info`/`duration-info` via `vcs_info` zstyles.

## Claude Code package

The `claude` package backs up only the durable parts of `~/.claude`: `settings.json` and `hooks/`. Runtime state (sessions, history, projects, cache, plugins) is deliberately excluded, and `~/.claude/commands` / `~/.claude/skills` are symlinks managed by the separate `founder-skill` repo — don't add them here.

## Multiple Neovim distributions

Three Neovim distros coexist via `NVIM_APPNAME`, each in its own package (`lazyvim`, `nvchad`, `astronvim`), with shell aliases defined in `.zshrc`:

- `lzv` → LazyVim, `nvc` → NvChad, `atv` → AstroNvim

`astronvim.bak` is an old backup that stows to `~/.config/nvim` (the default Neovim path).
