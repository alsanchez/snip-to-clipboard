# snip-to-clipboard

macOS-style region screenshot to the clipboard for X11 desktops.

Press **Meta+Ctrl+Shift+4**, drag a rectangle, and release the mouse button: the region is
copied to the clipboard. Esc or the right mouse button cancel.

- The screen freezes the instant you press the shortcut, so tooltips, menus and hover
  effects are captured as they were.
- No dimming, no toolbar, no file saved: just a crosshair cursor, a translucent selection
  showing its size, and a shutter sound when the image is copied.
- Runs in the background and starts with your session.

## Requirements

- An X11 session (Wayland is not supported).
- Python 3 with PyQt5 and python-xlib.
- Optional, for the shutter sound: `paplay` and the freedesktop sound theme.

On Debian/Ubuntu:

```sh
sudo apt install python3-pyqt5 python3-xlib pulseaudio-utils sound-theme-freedesktop
```

## Install

```sh
git clone https://github.com/alsanchez/snip-to-clipboard.git
cd snip-to-clipboard
./install.sh
```

This installs the program to `~/.local/bin`, adds an autostart entry and starts it.
Run `./install.sh` again to update, or `./install.sh --uninstall` to remove it.

If another program already uses the shortcut, snip-to-clipboard exits with an error.

## Configuration

Edit the constants at the top of `snip-to-clipboard` and run `./install.sh` again:

| Constant | Default | Meaning |
|---|---|---|
| `SHORTCUTS` | Meta+Ctrl+Shift+4 | List of `(keysym, modifiers)` that start a snip, e.g. `("Print", 0)` for the Print key. |
| `SHUTTER_SOUND` | freedesktop `camera-shutter.oga` | Sound played after copying; `""` for silence. |
| `SELECTION_FILL`, `SELECTION_BORDER` | translucent grey, white border | Selection colours. |

## License

GPL-3.0-or-later. See [LICENSE](LICENSE).
