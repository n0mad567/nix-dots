{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    tlp  
  ];
  services.logind.settings.Login = {
  HandleLidSwitch = "suspend";
  HandleLidSwitchExternalPower = "suspend";
  HandleLidSwitchDocked = "ignore";
  };
}
