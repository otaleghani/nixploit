{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    tmux
    curl
    wget
    python314
    openssl
    openvpn
    openssh
    inetutils # ftp, telnet, etc
    netcat
  ];
}
