-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({ 
	output = "DP-1", 
	mode = "highrr", 
	position = "0x0", 
	scale = 1
})

hl.monitor({ 
	output = "DP-2", 
	mode = "preferred", 
	position = "auto-left", 
	scale = 1, 
	transform = 1
})

hl.monitor({ 
	output = "DP-3", 
	mode = "preferred", 
	position = "auto-right", 
	scale = 1,
	transform = 3
})

hl.monitor({ 
	output = "eDP-1", 
	mode = "highrr", 
	position = "0x0", 
	scale = 1.5
})


---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "nautilus"
local menu        = "wofi -show drun"
local browser     = "zen"

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function ()
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")

    -- Start the wallpaper daemon.
hl.exec_cmd("awww-daemon")

-- Restore the previously selected wallpaper.
hl.exec_cmd([[
    bash -c '
        STATE_FILE="$HOME/.cache/current-wallpaper"
        DEFAULT_WALLPAPER="$HOME/.config/hypr/wallpapers/mountain.png"

        # Use the previously selected wallpaper if available.
        if [ -f "$STATE_FILE" ]; then
            WALLPAPER="$(cat "$STATE_FILE")"
        else
            WALLPAPER="$DEFAULT_WALLPAPER"
        fi

        # Fall back to the default wallpaper if the saved file no longer exists.
        if [ ! -f "$WALLPAPER" ]; then
            WALLPAPER="$DEFAULT_WALLPAPER"
        fi

        # Apply the wallpaper.
        awww img "$WALLPAPER"

        # Generate the matching pywal theme.
        wal -i "$WALLPAPER"
    '
]])

    -- Start Waybar after pywal generates its colors.   
    hl.exec_cmd("waybar")
end)

hl.config({
    ecosystem = {
        no_update_news = true,
    },
})

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,

        border_size = 0,

        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 0.9,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
    },
    
    xwayland = {
        force_zero_scaling = true
    }
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "razer-viper-v4-pro",
    sensitivity = 1,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"


-- Toggle Wofi when Left Super is tapped alone for less than 1 second.
-- XKB keycodes: Left Super = 133, Right Super = 134.

local super_key = 133
local held_keys = {}
local tracking = false
local cancelled = false
local too_long = false
local press_timer = nil

local function toggle_wofi()
    hl.dispatch(hl.dsp.exec_cmd(
        "if pgrep -x .wofi-wrapped >/dev/null; then pkill -x .wofi-wrapped; else wofi --show drun; fi"
    ))
end

hl.on("input.keyboard.key", function(keycode, timestamp, state)
    -- Ignore key repeats.
    if state == 2 then
        return
    end

    if state == 1 then
        -- A key pressed while Super is being held cancels the tap.
        if tracking and keycode ~= super_key then
            cancelled = true
        end

        if keycode == super_key then
            local another_key_held = false

            for key in pairs(held_keys) do
                if key ~= super_key then
                    another_key_held = true
                    break
                end
            end

            if not another_key_held then
                tracking = true
                cancelled = false
                too_long = false

                press_timer = hl.timer(function()
                    too_long = true
                end, {
                    timeout = 1000,
                    type = "oneshot"
                })
            else
                tracking = false
            end
        end

        held_keys[keycode] = true

    elseif state == 0 then
        if keycode == super_key and tracking then
            if press_timer then
                press_timer:set_enabled(false)
            end

            if not cancelled and not too_long then
                toggle_wofi()
            end

            tracking = false
            press_timer = nil
        end

        held_keys[keycode] = nil
    end
end)


-- binds, see https://wiki.hypr.land/Configuring/Binds/ for more
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper.sh"))
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen(0))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd('sh -c \'mkdir -p "$HOME/Photos/Screenshots"; f="$HOME/Photos/Screenshots/$(date +%Y%m%d_%H%M%S).png"; tmp="$(mktemp --suffix=.png)"; trap \'\\\'\'rm -f "$tmp"\'\\\'\' EXIT; if grim -g "$(slurp)" "$tmp"; then choice="$(printf "Edit screenshot\\nSave + copy\\n" | wofi --dmenu --hide-search --prompt "Screenshot" --width 300 --height 160 --lines 2 --style "$HOME/.config/wofi/screenshot.css")"; if [ "$choice" = "Edit screenshot" ]; then swappy -f "$tmp" -o "$f" && [ -s "$f" ] && wl-copy --type image/png < "$f"; elif [ "$choice" = "Save + copy" ]; then cp "$tmp" "$f" && wl-copy --type image/png < "$tmp"; fi; fi\''))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('sh -c \'mkdir -p "$HOME/Photos/Screenshots"; f="$HOME/Photos/Screenshots/$(date +%Y%m%d_%H%M%S).png"; tmp="$(mktemp --suffix=.png)"; trap \'\\\'\'rm -f "$tmp"\'\\\'\' EXIT; if grim -g "$(slurp)" "$tmp"; then choice="$(printf "Edit screenshot\\nSave + copy\\n" | wofi --dmenu --hide-search --prompt "Screenshot" --width 300 --height 160 --lines 2 --style "$HOME/.config/wofi/screenshot.css")"; if [ "$choice" = "Edit screenshot" ]; then swappy -f "$tmp" -o "$f" && [ -s "$f" ] && wl-copy --type image/png < "$f"; elif [ "$choice" = "Save + copy" ]; then cp "$tmp" "$f" && wl-copy --type image/png < "$tmp"; fi; fi\''))
hl.bind("Print", hl.dsp.exec_cmd('sh -c \'mkdir -p "$HOME/Photos/Screenshots"; f="$HOME/Photos/Screenshots/$(date +%Y%m%d_%H%M%S).png"; tmp="$(mktemp --suffix=.png)"; trap \'\\\'\'rm -f "$tmp"\'\\\'\' EXIT; if grim -g "$(slurp)" "$tmp"; then choice="$(printf "Edit screenshot\\nSave + copy\\n" | wofi --dmenu --hide-search --prompt "Screenshot" --width 300 --height 160 --lines 2 --style "$HOME/.config/wofi/screenshot.css")"; if [ "$choice" = "Edit screenshot" ]; then swappy -f "$tmp" -o "$f" && [ -s "$f" ] && wl-copy --type image/png < "$f"; elif [ "$choice" = "Save + copy" ]; then cp "$tmp" "$f" && wl-copy --type image/png < "$tmp"; fi; fi\''))


-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

hl.bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" }))

-- Example special workspace (scratchpad)
--hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
--hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(true)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})
