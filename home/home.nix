{ config, pkgs, ... }:

{
  home.username = "fletcher";
  home.homeDirectory = "/home/fletcher";

  imports = [
    ./packages.nix
  ];

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  xdg.configFile."hypr".source = ./hypr;

  xdg.configFile."waybar".source = ./waybar;

  xdg.configFile."kitty".source = ./kitty;

  xdg.configFile."wofi".source = ./wofi;
}
