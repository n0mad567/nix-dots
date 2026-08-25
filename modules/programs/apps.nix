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
    usbutils

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
    fastfetch
    btop
    unzip
    radeontop
    
    
    #user apps
    discord
    qemu
    ungoogled-chromium
    onlyoffice-desktopeditors
    
  ]
  ++ [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
