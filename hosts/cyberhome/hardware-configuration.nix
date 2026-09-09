# PLACEHOLDER — replace this file with the real hardware-configuration.nix
# from cyberhome (copy /etc/nixos/hardware-configuration.nix from that
# machine, or regenerate it there with `nixos-generate-config`).
#
# This stub only exists so the flake evaluates; it does not describe any
# real disk layout and must not be used to build/boot cyberhome as-is.

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;
}
