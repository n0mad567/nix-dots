{ config, pkgs, lib, ... }:

{
  home.username = "fletcher";
  home.homeDirectory = "/home/fletcher";

  imports = [
    
  ];

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  xdg.configFile."hypr".source = ./hypr;

  xdg.configFile."waybar".source = ./waybar;

  xdg.configFile."kitty".source = ./kitty;

  xdg.configFile."wofi".source = ./wofi;

  xdg.configFile."fastfetch".source = ./fastfetch;

  xdg.configFile."wlogout".source = ./wlogout;

  xdg.configFile."wal/templates/hyprlock-colors.conf".source = ./hypr/hyprlock-colors.conf.template;

  programs.bash = {
  enable = true;
  initExtra = ''
    if [[ -n "$KITTY_WINDOW_ID" && "$SHLVL" -eq 1 ]]; then
      fastfetch
    fi
  '';
  };

  home.file.".config/hypr/scripts/wallpaper.sh" = {
    source = ./hypr/scripts/wallpaper.sh;
    executable = true;
  };
  
}
