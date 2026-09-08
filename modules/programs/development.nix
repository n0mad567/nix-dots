{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    python3
    uv
    gcc
    vscode
    neovim
  ];

  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;

}
