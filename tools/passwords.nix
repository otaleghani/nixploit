{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    john
    hashcat
    thc-hydra
  ];
}
