# dotfiles

Personal configuration files, added on a case-by-case basis as I set things up on a new machine or tweak my workflow.

This repo is more of a personal reference/backup than a one-command install.

## Contents

| File | Description |
|---|---|
| `.tmux.conf` | tmux configuration — remapped prefix, pane/window navigation, mouse support, popups, and status bar theming |
| `tmux-git-status.sh` | Helper script for `.tmux.conf`'s status bar — prints the current pane's git branch (with a `*` if dirty) |
| `.gdbinit` | GDB configuration for embedded/firmware reverse engineering (MIPS, TUI layout, remote debug helper) |
| `.bashrc` | Just the reusable bit — enables [zoxide](https://github.com/ajeetdsouza/zoxide) (`z <partial-name>` to jump to frecent directories) |
| `ranger/rc.conf` | Just the customizations — `yc` copies the selected file's absolute path to the clipboard |
| `.gitignore` | Ignores everything except the files explicitly listed as exceptions (or force-added with `git add -f`) |
| `.zshrc` | Zsh shell configuration |

## .gdbinit highlights

- **Intel syntax** for disassembly (instead of GDB's default AT&T syntax)
- **debuginfod disabled** — avoids GDB reaching out to the network for debug info, useful when working offline or on isolated embedded targets
- **MIPS architecture** set by default for router use case.
- **TUI enabled** with `asm` and `regs` layouts active on startup, focus kept on the command window
- **`connect` custom command**: shortcut for attaching to a remote `gdbserver`/stub.

## .tmux.conf highlights

- **Prefix remapped to `Ctrl+a`** (instead of the default `Ctrl+b`), with `Ctrl+a` sent through twice if you need to pass it to a nested app
- **Easier splits**: `prefix + v` for vertical split, `prefix + h` for horizontal split
- **Mouse mode** enabled
- **Pane navigation without the prefix**: `Alt + arrow keys`
- **Window navigation without the prefix**: `Shift + Left/Right`
- **Popups**: `prefix + p` for a blank popup
- **File manager**: `prefix + f` opens [ranger](https://github.com/ranger/ranger) in a 40%-height split pane. This deliberately uses `split-window` rather than `display-popup` — popups render as an empty black box on VTE-based terminals such as GNOME Terminal. Note that tmux 3.4 dropped `-p <percent>` in favour of `-l <percent>%`
- **Quick reload**: `prefix + r` re-sources `~/.tmux.conf`
- **Status bar theme**: [tmux-power](https://github.com/wfxr/tmux-power) plugin, `everforest` color scheme
- **Hostname/user hidden**: the default `user@host` segment (`left_a`) is blanked out — just the session name shows on the left
- **Git branch in status bar**: `status-left` shows the focused pane's git branch via `tmux-git-status.sh`, with a `*` suffix when the repo is dirty (unstaged or staged changes)
- **Claude usage in status bar**: `status-right` shows session/weekly rate-limit % via [tmux-claude-status](https://github.com/long-910/tmux-claude-status) (`claude-usage short`). `prefix + U` toggles percent/cost, `prefix + B` opens the usage dashboard popup.
  Requires the `claude-usage` binary on `$PATH` — install separately with:
  ```bash
  curl -fsSL https://raw.githubusercontent.com/long-910/tmux-claude-status/main/install.sh | bash
  ```
- **Fast status refresh**: `status-interval` set to 2s, plus hooks that force a refresh on window/pane switch so the git branch segment doesn't show stale info from the previously focused pane

## ranger/rc.conf highlights

ranger loads its own shipped `rc.conf` first and the user's second, so this file holds only the deltas rather than a copy of the 760-line default.

- **`yc` copies the selected file's absolute path to the system clipboard.** ranger's built-in `yy`/`yp` only populate its *internal* register, which is useless for pasting into another application — this hands the path off to the real clipboard instead. Handy for pasting a path into an editor, a chat window, or a CLI prompt.
- Uses `wl-copy` (Wayland). On X11, swap it for `xclip -selection clipboard`.
- `readlink -f` is needed because ranger's `%f` is relative to its current directory, so without it you get a bare filename instead of a full path.

## Usage

Clone the repo, then symlink or copy whichever files you want:

```bash
git clone https://github.com/acentauri92/dotfiles.git
```

If you do want to use one of these configs, here's how:

```bash
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.gdbinit ~/.gdbinit
```

`tmux-git-status.sh` is referenced by full path (`~/.local/bin/tmux-git-status.sh`) from `.tmux.conf`, so symlink or copy it there and make it executable:

```bash
ln -sf ~/dotfiles/tmux-git-status.sh ~/.local/bin/tmux-git-status.sh
chmod +x ~/.local/bin/tmux-git-status.sh
```

`ranger/rc.conf` is safe to symlink over the default location, because ranger still loads its shipped defaults first:

```bash
mkdir -p ~/.config/ranger
ln -sf ~/dotfiles/ranger/rc.conf ~/.config/ranger/rc.conf
```

It needs a clipboard tool on `$PATH` — `wl-clipboard` on Wayland, or `xclip` on X11 (edit the binding to match):

```bash
sudo apt install wl-clipboard   # Wayland
```

`.bashrc` here is just the zoxide line — append it to your real `~/.bashrc` (don't symlink over it) rather than replacing your existing shell config:

```bash
cat ~/dotfiles/.bashrc >> ~/.bashrc
```

Reload tmux after copying/linking its config:

```bash
tmux source-file ~/.tmux.conf
```

`.gdbinit` is picked up automatically the next time GDB starts.

## Roadmap

More dotfiles will be added over time as I refine my setup — likely candidates include `.vimrc`, `.bashrc`, and any editor or terminal emulator configs worth versioning.