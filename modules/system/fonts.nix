{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.code-new-roman
    corefonts
    times-newer-roman
  ];
}
