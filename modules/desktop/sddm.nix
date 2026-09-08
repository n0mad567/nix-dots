{ ... }:

{
  services.displayManager.sddm.enable = true;

  security.polkit.enable = true;
  services.fprintd.enable = true;
  security.pam.services.hyprlock = {};
}
