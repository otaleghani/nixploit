# nixploit

A simple nix flake for penetration testing.

> **⚠️ Warning**
>
> This is a work in progress, so it doesn't have lot's of tools and lot's of features. I'm actively building it based on what I need.


## How to run it
``` bash
# Some packages (like python2) require this
export NIXPKGS_ALLOW_INSECURE=1

nix develop --inpure
```

## Other stuff
#### Find config files in nix store
``` bash
# Example of finding the proxychains configuration in nix store
find /nix/store -name proxychains.conf
```

#### Edit name servers
``` nix
# Example changing the nameservers to cloudflare's
networking.nameservers = [
  "1.1.1.1"
  "1.0.0.1"
  "2606:4700:4700::1111"
  "2606:4700:4700::1001"
];
```

#### Add extra hosts
``` nix
networking.extraHosts = ''
  10.129.201.127 example.server
  10.129.201.127 internal.example.server
'';
```

#### Allow ports and firewalls
``` nix
# I usually disable it on engagements
networking.firewall.enable = false;
networking.firewall.allowedTCPPorts = [ 8080 ];
networking.firewall.allowedUDPPorts = [ 8080 ];
```
