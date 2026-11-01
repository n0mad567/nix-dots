# NixOS Dotfiles

This repository contains my personal NixOS configuration.

> These dotfiles are primarily designed for my own machines and may require changes before being used on another system.

---

## Features

* Declarative NixOS configuration using flakes
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

# Desktop Environment

### Components

| Component | Purpose                                   |
| --------- | ----------------------------------------- |
| Hyprland  | Wayland compositor                        |
| Hyprlock  | Lock screen                               |
| Hypridle  | Idle management                           |
| Waybar    | Status bar                                |
| Wofi      | Application launcher                      |
| Kitty     | Terminal                                  |
| Pywal     | Dynamic color generation                  |
| Awww      | Wallpaper daemon                          |
| Fastfetch | System information                        |

---

# Configuration Layout

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

# Home Manager

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

---

# Installation

These dotfiles are configured for my own systems, so installation on another machine will likely require modification.

At a minimum, you should:

1. Clone the repository.

```bash
cd ~
git clone <https://github.com/n0mad567/nix-dots.git>
cd <nix-dots>
```

2. Review the host configuration(depending on what type of computer you're on).

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

6. Run the rebuild.sh script in the scripts directory.

For a fresh NixOS installation, make sure you understand every configuration option before applying it.

---