{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "kristin";
  home.homeDirectory = "/home/kristin";

  home.packages = [
    pkgs.alacritty
#    pkgs.libreoffice
    pkgs.nextcloud-client
    pkgs.tdesktop
    pkgs.steam
    pkgs.slack
    pkgs.spotify
    pkgs.discord
    pkgs.zoom-us
    pkgs.vscode-fhs
    pkgs.zip
    pkgs.unzip
    pkgs.volumeicon
    pkgs.flameshot
    pkgs.chromium
    pkgs.stdenv
    pkgs.pavucontrol
  ];

  home.sessionVariables = {
    TERM = "alacritty";
    PAGER="less";
    ZSH_TMUX_AUTOSTART=true;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
