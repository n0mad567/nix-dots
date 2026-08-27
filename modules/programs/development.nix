{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vscode
    gcc
  ];

  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;

}
