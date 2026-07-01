{ config, pkgs, ... }:

{
  home.username = "fletcher";
  home.homeDirectory = "/home/fletcher";

  imports = [
    ./packages.nix
  ];

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  xdg.configFile."hypr".source = ./hypr;

  xdg.configFile."waybar".source = ./waybar;

  xdg.configFile."kitty".source = ./kitty;

  xdg.configFile."wofi".source = ./wofi;

  xdg.configFile."fastfetch".source = ./fastfetch;

  programs.bash = {
  enable = true;
  initExtra = ''
    if [[ -n "$KITTY_WINDOW_ID" && "$SHLVL" -eq 1 ]]; then
      fastfetch
    fi
  '';
};
}
