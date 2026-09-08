#!/usr/bin/env bash

set -euo pipefail

WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"

selected=$(
    find "$WALLPAPER_DIR" \
        -maxdepth 1 \
        -type f \
        \( \
            -iname "*.png" \
            -o -iname "*.jpg" \
            -o -iname "*.jpeg" \
            -o -iname "*.webp" \
        \) \
        -printf "%f\n" \
    | sort \
    | wofi \
        --show dmenu \
        --prompt "󰸉 Wallpaper" \
        --allow-images
)

[ -z "$selected" ] && exit 0

wallpaper="$WALLPAPER_DIR/$selected"

awww img "$wallpaper"

wal -i "$wallpaper"

pkill waybar || true
waybar >/dev/null 2>&1 &