# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  hardware.bluetooth.enable = true;
  programs.light.enable = true;
  boot.kernelParams = ["amdgpu.backlight=0" "acpi_backlight=none"];
  services.blueman.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.kernelPackages = pkgs.linuxPackages_5_15;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
#  networking.wireless = {
 #   enable = true;
  #  userControlled.enable = true;
   # interfaces = ["wlp1s0"];
   # networks = {
    #  Waoo4920_N399 = {
    #    psk = "wnyn8797";
    #  };
   # };
#  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.wlp1s0.useDHCP = true;
  networking.interfaces.lo.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";
  environment.pathsToLink = [ "/libexec" ];

  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
      defaultSession = "none+i3";
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu i3status i3lock i3blocks
        ];
      };
    };

  services.xserver.libinput.touchpad.naturalScrolling = true;
  services.xserver.libinput.touchpad.middleEmulation = true;
  services.xserver.libinput.touchpad.tapping = true;
  services.xserver.libinput.enable = true;
 
  nixpkgs.config.allowUnfree = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.enableAllFirmware = true;
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kristin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" "networkmanager" "docker" "adbusers"  "audio" "bluetooth" "video" "sound" "input" "tty"]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    curl
    wget 
    vim
    firefox
    pcmanfm
    brightnessctl
    (python38.withPackages(ps: with ps; [pandas jupyter numpy scikit-learn matplotlib]))

  ];
  programs.steam.enable = true;

#  hardware.opengl.driSupport32Bit = true;
 # hardware.pulseaudio.support32Bit = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  # Enable Android Development
  programs.adb.enable = true;
  programs.nm-applet.enable = true;
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

