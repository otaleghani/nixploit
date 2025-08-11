{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    tmux
    curl
    wget
    openssl
    openvpn
    openssh
    inetutils # ftp, telnet, etc
    netcat
    proxychains
    freerdp
    putty
    sshuttle
    chisel
    ptunnel
    dig 
    dnslookup
    wireshark
    responder
    netexec
    bloodhound
    python313Packages.impacket
    smbmap
    neo4j
    nmap
    evil-winrm
    ffuf
    medusa
    username-anarchy

    # proxies
    burpsuite
    zap

    # used to install other tools
    autoconf 
    automake 
    libtool 
    pkg-config 
    libpcap
    glibc.static 

    # languages
    python2
    ruby
    go

    # Databases
    mysql84
  ];
}
