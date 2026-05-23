{ pkgs, ... }:

{
  programs.hyprland.enable = true;

  services.xserver.enable = true;

  services.displayManager.defaultSession = "hyprland";

  xdg.portal.enable = true;

  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];
}
