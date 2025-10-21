{
  description = "nixploit, a nix flake for penetration testing";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # Add the different github repositories for tools etc
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnsafe = true;
        };
      };

      lib = nixpkgs.lib;

      toolsPath = ./tools;
      toolFiles = lib.attrNames (
        lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".nix" name) (
          builtins.readDir toolsPath
        )
      );
      modules = map (file: import (toolsPath + "/${file}") { inherit pkgs; }) toolFiles;
      packages = lib.flatten (map (module: module.environment.systemPackages) modules);
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          # You need to create your python interpreter before another package create it's own
          # View more at https://nixos.wiki/wiki/Python#Troubleshooting
          (pkgs.python3.withPackages (python-pkgs: [
            python-pkgs.requests
            python-pkgs.tld
            python-pkgs.fuzzywuzzy
            python-pkgs.netaddr
            python-pkgs.selenium
            python-pkgs.levenshtein
            python-pkgs.pyvirtualdisplay
            python-pkgs.click
          ]))
          pkgs.zsh
        ]
        ++ packages;

        shellHook = ''
          # if [ -z "$TMUX" ]; then
          #   tmux set-option -g default-command "nix develop --command zsh"
          #   tmux new-session -s nixploit
          #   tmux attach-session -t nixploit
          # fi
        '';
        DISPLAY = "";
      };
    };
}
# echo "Welcome to nixploit"
# echo "Loaded ${toString (lib.length packages)} tools."
# exec tmux
# Find a way to add temporary configurations
# ln -sf ${self}/proxychains.conf $HOME/.proxychains/proxychains.conf
