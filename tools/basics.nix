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

    autoconf 
    automake 
    libtool 
    pkg-config 
    libpcap
    glibc.static 

    # languages
    python314
    python2
    ruby
    go
  ];
}
