#!/usr/bin/env bash
# Install snip-to-clipboard for the current user and start it, or remove it with --uninstall.
set -euo pipefail

NAME=snip-to-clipboard
BIN="$HOME/.local/bin/$NAME"
AUTOSTART="$HOME/.config/autostart/$NAME.desktop"
SRC_DIR=$(cd "$(dirname "$0")" && pwd)
# Anchored to the interpreter's command line so it never matches this script
PROC_PATTERN="^python3 $BIN\$"

stop_running() {
    pkill -f "$PROC_PATTERN" || return 0
    for _ in $(seq 50); do
        pgrep -f "$PROC_PATTERN" >/dev/null || return 0
        sleep 0.1
    done
    echo "$NAME: the running instance did not stop" >&2
    exit 1
}

if [[ "${1:-}" == "--uninstall" ]]; then
    stop_running
    rm -f "$BIN" "$AUTOSTART"
    echo "$NAME uninstalled."
    exit 0
fi

install -Dm755 "$SRC_DIR/$NAME" "$BIN"
mkdir -p "$(dirname "$AUTOSTART")"
cat > "$AUTOSTART" <<EOF
[Desktop Entry]
Type=Application
Name=Snip to clipboard
Comment=Meta+Ctrl+Shift+4: freeze the screen and copy a region to the clipboard
Exec=$BIN
Icon=accessories-screenshot
Terminal=false
NoDisplay=true
EOF

stop_running
setsid -f "$BIN" >/dev/null 2>&1 </dev/null
echo "$NAME installed to $BIN and started; it will also start on login."
