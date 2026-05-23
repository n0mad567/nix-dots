{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fastfetch
    btop
    unzip
    pavucontrol
  ];
}
