# Fletcher's NixOS Dotfiles

My declarative NixOS and Home Manager configuration.

This repository contains my personal system configuration, desktop environment, and dotfiles for a NixOS setup using Hyprland, Home Manager, and a Pywal-generated dynamic color scheme.

> These dotfiles are primarily designed for my own machines and may require changes before being used on another system.

---

## ✨ Features

* Fully declarative NixOS configuration using flakes
* Home Manager configuration
* Hyprland desktop environment
* Dynamic wallpaper-based color scheme using Pywal
* Automatic Waybar recoloring
* Dynamic Hyprlock theme
* Wallpaper picker with previews
* Hypridle lock/idle management
* Waybar
* Wofi application launcher
* Kitty terminal
* Fastfetch system information
* Wlogout power menu
* Separate desktop and laptop host configurations

---

# 🖥️ Desktop Environment

The primary desktop environment is built around Hyprland.

### Components

| Component | Purpose                                   |
| --------- | ----------------------------------------- |
| Hyprland  | Wayland compositor                        |
| Hyprlock  | Lock screen                               |
| Hypridle  | Idle management                           |
| Waybar    | Status bar                                |
| Wofi      | Application launcher and wallpaper picker |
| Kitty     | Terminal emulator                         |
| Pywal     | Dynamic color generation                  |
| Awww      | Wallpaper daemon                          |
| Wlogout   | Logout/power menu                         |
| Fastfetch | System information                        |

---

# 🎨 Dynamic Theming

The desktop theme is generated dynamically from the currently selected wallpaper using Pywal.

Changing the wallpaper automatically updates the color palette used throughout the desktop.

```text
Wallpaper
    │
    ▼
Awww
    │
    ▼
Pywal
    │
    ├── Waybar
    ├── Wofi
    └── Hyprlock
```

The generated Pywal cache is located at:

```text
~/.cache/wal/
```

These generated files are not stored in the repository.

---

# 🖼️ Wallpaper Picker

Press:

```text
SUPER + W
```

to open the wallpaper picker.

The wallpaper picker:

1. Displays available wallpapers.
2. Shows wallpaper previews.
3. Changes the wallpaper using Awww.
4. Generates a new Pywal color palette.
5. Saves the selected wallpaper.
6. Reloads Waybar.

---

# 🔒 Hyprlock

Hyprlock uses the Pywal-generated color palette.

The Hyprlock configuration is located at:

```text
home/hypr/hyprlock.conf
```

The Pywal template used to generate Hyprlock colors is:

```text
home/hypr/hyprlock-colors.conf.template
```

Home Manager deploys the template to:

```text
~/.config/wal/templates/hyprlock-colors.conf
```

Pywal then generates:

```text
~/.cache/wal/hyprlock-colors.conf
```

Hyprlock sources this generated file automatically.

This means changing the wallpaper also changes the lock screen theme.

---

# ⚙️ Configuration Layout

## Hosts

Machine-specific configuration lives in:

```text
hosts/
```

Currently:

```text
hosts/desktop
hosts/laptop
```

Each host contains its own:

* Main NixOS configuration
* Hardware configuration

---

## Modules

Reusable configuration is organized into:

```text
modules/
```

### Desktop

```text
modules/desktop/
```

Contains desktop environment-related configuration such as:

* Audio
* Environment
* Hyprland
* SDDM

### Programs

```text
modules/programs/
```

Contains program and software configuration.

### System

```text
modules/system/
```

Contains system-level configuration including:

* Boot
* Bluetooth
* Fonts
* Locale
* Networking
* Nix settings
* Users

---

# 🏠 Home Manager

User-level configuration is located in:

```text
home/
```

The main Home Manager configuration is:

```text
home/home.nix
```

It declaratively deploys the configuration directories for:

* Hyprland
* Waybar
* Kitty
* Wofi
* Fastfetch
* Wlogout

For example:

```text
home/hypr/
```

is deployed to:

```text
~/.config/hypr/
```

---

# 🔨 Rebuilding

The repository includes a rebuild script:

```text
scripts/rebuild.sh
```

Use it to rebuild the system after making configuration changes:

```bash
./scripts/rebuild.sh
```

The exact behavior depends on the implementation of the script and flake configuration.

---

# 🚀 Installation

These dotfiles are configured for my own systems, so installation on another machine will likely require modification.

At a minimum, you should:

1. Clone the repository.

```bash
git clone <https://github.com/n0mad567/nix-dots.git>
cd <nix-dots>
```

2. Review the host configuration.

```text
hosts/desktop/
```

or:

```text
hosts/laptop/
```

3. Replace the hardware configuration with one generated for your system.

4. Update usernames and home directories.

5. Review disk, bootloader, networking, and user settings before rebuilding.

6. Rebuild the system using the appropriate flake target.

For a fresh NixOS installation, make sure you understand every configuration option before applying it.

---

# ⚠️ Notes

These are personal dotfiles.

They may contain assumptions about:

* Hardware
* Displays
* GPU configuration
* Input devices
* Usernames
* File paths
* Installed fonts
* Laptop hardware
* Desktop hardware

Do not blindly apply this configuration to another machine.

---