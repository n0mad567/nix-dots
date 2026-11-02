{ lib, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/system/bluetooth.nix
    ../../modules/system/nix.nix
    ../../modules/system/boot.nix
    ../../modules/system/networking.nix
    ../../modules/system/locale.nix
    ../../modules/system/users.nix
    ../../modules/system/fonts.nix

    ../../modules/desktop/hyprland.nix
    ../../modules/desktop/audio.nix
    ../../modules/desktop/sddm.nix
    ../../modules/desktop/environment.nix

    ../../modules/programs/apps.nix
    ../../modules/programs/development.nix
    ../../modules/programs/gaming.nix

    ../../modules/programs/laptop.nix

    #../../modules/hardware/power.nix
    #../../modules/hardware/bluetooth.nix
  ];
  boot.initrd.luks.devices."luks-3cc56da5-7bde-446f-9a79-6c630a4252ea".device = "/dev/disk/by-uuid/3cc56da5-7bde-446f-9a79-6c630a4252ea";

  networking.hostName = "laptop";

  system.stateVersion = "25.11";
}
