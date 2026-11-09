{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    python3
    uv
    gcc
    vscode
    neovim
    arduino-ide
    gnumake
    cmake
    openssl
  ];

  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;

  virtualisation.docker.enable = true;


}
