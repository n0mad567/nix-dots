{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    #core utils
    git
    wget
    tree
    vim
    blueman
    playerctl
    brightnessctl
    wlogout

    #system apps / deps
    kitty
    wofi
    waybar
    hyprpicker
    pywal
    awww
    bibata-cursors
    nautilus
    pavucontrol
    
    #user apps
    discord
    
  ]
  ++ [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
