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

  swapDevices = lib.mkForce [];
  boot.initrd.luks.devices = lib.mkForce {};
  boot.initrd.systemd.enable = true;

  networking.hostName = "laptop";

  system.stateVersion = "25.11";
}
