#!/usr/bin/env bash
set -e

# wofi dropdown flags
# -d = dropdown mode
# --position=bottom = spawns below Waybar
# --x/y-offset = fine-tune alignment
WOFI_OPTS="-d --location=3 --x-offset=0 --y-offset=12 --show-icons --hide-search"
WOFI_STYLE="$HOME/.config/wofi/dropdown.css"

# Power options (Nerd Font symbols)
OPTIONS=(
  " Shutdown"
  " Reboot"
  " Lock"
  "󰍃 Suspend"
  "󰈆 Hibernate"
  "󰍡 Logout"
)

# Capture selection
CHOICE=$(printf '%s\n' "${OPTIONS[@]}" | wofi $WOFI_OPTS -s "$WOFI_STYLE")

case "$CHOICE" in
  *"Shutdown"*) systemctl poweroff ;;
  *"Reboot"*)  systemctl reboot ;;
  *"Lock"*)    loginctl lock-session ;;
  *"Suspend"*) systemctl suspend ;;
  *"Hibernate"*) systemctl hibernate ;;
  *"Logout"*)  loginctl terminate-user "$USER" ;;
esac
