{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nmap
    masscan
    nikto

    # dns
    dig
    fierce

    eyewitness
  ];
}
