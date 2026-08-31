{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vscode
    neovim
    gcc
  ];

  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;

}
