{ pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;
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
    hyprlock
    hypridle
    usbutils
    tmux
    lsof
    file
    

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

    slurp
    swappy
    grim
    wl-clipboard
    
    #user apps
    discord
    qemu
    ungoogled-chromium
    onlyoffice-desktopeditors

    #local AI
    llama-cpp-vulkan
    vulkan-tools
    mesa
  ]
  ++ [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
