
# Check if waybar is running
if pgrep -x ".waybar-wrapped" > /dev/null; then
    # If running, kill the waybar process
    pkill -x ".waybar-wrapped"
else
    # If not running, start waybar
    waybar &
fi


