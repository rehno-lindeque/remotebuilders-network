{ lib, ...}:
{
  nixpkgs.localSystem = lib.systems.examples.aarch64-multiplatform;
  nixpkgs.overlays = [ (import ./aarch64-overlay.nix) ];

  deployment.ec2.ami = "ami-0d57f28ae76a680e3";

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/ESP";
    autoResize = true;
  };

  boot.loader.grub.version = lib.mkForce 2;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.device = lib.mkForce "nodev";
  boot.loader.timeout = lib.mkForce 5;
  boot.loader.grub.copyKernels = true;
}
