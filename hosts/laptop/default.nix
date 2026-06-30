{ lib, ... }:

{
  imports = [
    ./hardware-configuration.nix

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

    #../../modules/hardware/power.nix
    #../../modules/hardware/bluetooth.nix
  ];

  boot.initrd.luks.devices."luks-95cdbdd6-e9e6-4f0f-a68e-567c58126278" = {
  device = "/dev/disk/by-uuid/95cdbdd6-e9e6-4f0f-a68e-567c58126278";
  };

  networking.hostName = "laptop";

  system.stateVersion = "25.11";
}
