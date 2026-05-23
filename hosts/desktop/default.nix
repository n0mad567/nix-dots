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

  boot.initrd.luks.devices."cryptswap" = {
    device = "/dev/disk/by-uuid/1f216f2c-1da0-4388-93f6-94372f3beefb";
  };

  swapDevices = lib.mkForce [
    {
      device = "/dev/mapper/cryptswap";
    }
  ];

  networking.hostName = "desktop";

  system.stateVersion = "25.11";
}
