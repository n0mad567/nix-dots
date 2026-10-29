#!/usr/bin/env bash

set -euo pipefail

screenshot_dir="$HOME/Photos/Screenshots"
mkdir -p "$screenshot_dir"

timestamp="$(date +%Y%m%d_%H%M%S)"
output="$screenshot_dir/$timestamp.png"
tmp="$(mktemp --suffix=.png)"

trap 'rm -f "$tmp"' EXIT

# Select a region and capture it.
if ! grim -g "$(slurp)" "$tmp"; then
    exit 0
fi

# Choose what to do with the screenshot.
choice="$(
    printf 'Edit screenshot\nSave + copy\n' |
        wofi --dmenu \
            --hide-search \
            --prompt 'Screenshot' \
            --width 300 \
            --lines 2 \
            --define dynamic_lines=true \
            --style "$HOME/.config/wofi/screenshot.css"
)" || exit 0

case "$choice" in
    "Edit screenshot")
        swappy -f "$tmp" -o "$output"
        if [[ -s "$output" ]]; then
            wl-copy --type image/png < "$output"
        fi
        ;;
    "Save + copy")
        cp "$tmp" "$output"
        wl-copy --type image/png < "$tmp"
        ;;
esac