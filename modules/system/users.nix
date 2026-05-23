{ pkgs, ... }:

{
  users.users.fletcher = {
    isNormalUser = true;

    description = "Fletcher";

    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };
}
