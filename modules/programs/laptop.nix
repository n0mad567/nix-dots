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


  security.polkit.enable = true;
  services.fprintd.enable = true;
  security.pam.services.hyprlock = {};

  systemd.services.fprintd-resume = {
    description = "Restart fprintd after suspend";

    wantedBy = [
      "suspend.target"
    ];

    after = [
      "suspend.target"
    ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.coreutils}/bin/sleep 2; ${pkgs.systemd}/bin/systemctl restart fprintd.service'";
    };
  };
}
