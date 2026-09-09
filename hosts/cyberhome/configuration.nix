# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/neovim-tools.nix
      ../../modules/zshrc.nix
      ../../modules/tmux.nix
      ../../modules/tailscale.nix
      ../../modules/docker.nix
      ../../modules/syncthing.nix
    ];

  # Automatic cleanup
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.settings.auto-optimise-store = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "cyberhome"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."isac" = {
    isNormalUser = true;
    description = "isac";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [zsh];
  };

  programs.zsh.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
     vim
     git
     gcc
     fastfetch
     starship
     zoxide
     fzf
     claude-code
   ];

  # Headless server: reachable over SSH (and tailscale, see modules/tailscale.nix).
  services.openssh.enable = true;

  # See `hosts/cloudhome/configuration.nix` for state-version rationale.
  system.stateVersion = "26.05";
}
