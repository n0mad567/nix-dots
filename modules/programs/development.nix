{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vscode
  ];

  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;

}
