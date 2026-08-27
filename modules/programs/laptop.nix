{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
      
  ];

  services.tlp = {
    enable = true;
    settings = {
      # Optional: basic AC/battery CPU policy
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
    };
  };

  # TLP conflicts with power-profiles-daemon
  services.power-profiles-daemon.enable = false;


  services.logind.settings.Login = {
  HandleLidSwitch = "suspend";
  HandleLidSwitchExternalPower = "suspend";
  HandleLidSwitchDocked = "ignore";
  };

  services.logind.settings.Login.HandlePowerKey = "suspend";
}
