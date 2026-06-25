# dotfiles

Personal configuration files, added on a case-by-case basis as I set things up on a new machine or tweak my workflow.

This repo is more of a personal reference/backup than a one-command install.

## Contents

| File | Description |
|---|---|
| `.tmux.conf` | tmux configuration — remapped prefix, pane/window navigation, mouse support, popups, and status bar theming |
| `.gitignore` | Ignores everything except files explicitly added with `-f` |
| `.zshrc` | Zsh shell configuration |

## .tmux.conf highlights

- **Prefix remapped to `Ctrl+a`** (instead of the default `Ctrl+b`), with `Ctrl+a` sent through twice if you need to pass it to a nested app
- **Easier splits**: `prefix + v` for vertical split, `prefix + h` for horizontal split
- **Mouse mode** enabled
- **Pane navigation without the prefix**: `Alt + arrow keys`
- **Window navigation without the prefix**: `Shift + Left/Right`
- **Popups**: `prefix + p` for a blank popup, `prefix + f` to pop open [ranger](https://github.com/ranger/ranger) as a file manager
- **Quick reload**: `prefix + r` re-sources `~/.tmux.conf`
- **Status bar theme**: light background (white/gray) with the active window highlighted

## Usage

Clone the repo, then symlink or copy whichever files you want:

```bash
git clone https://github.com/acentauri92/dotfiles.git
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
```

Reload tmux after copying:

```bash
tmux source-file ~/.tmux.conf
```

## Roadmap

More dotfiles will be added over time as I refine my setup — likely candidates include `.vimrc`, `.bashrc`, and any editor or terminal emulator configs worth versioning.
