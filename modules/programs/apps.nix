{ pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    #core utils
    wget
    tree
    btop
    usbutils
    tmux
    lsof
    file
    unzip

    #user apps
    discord
    qemu
    ungoogled-chromium
    onlyoffice-desktopeditors

    #sync
    syncthing

    #local AI
    llama-cpp-vulkan
    vulkan-tools
    mesa
    docker
  ]
  ++ [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
