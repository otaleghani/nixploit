{
  description = "nixploit, a nix flake for penetration testing";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # Add the different github repositories for tools etc
  };

  outputs = { self, nixpkgs }:
    let 
      system = "x86_64-linux";
      # pkgs = nixpkgs.legacyPackages.${system};
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      lib = nixpkgs.lib;

      toolsPath = ./tools;
      toolFiles = lib.attrNames (lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".nix" name) (builtins.readDir toolsPath));
      modules = map (file: import (toolsPath + "/${file}") { inherit pkgs; }) toolFiles;
      packages = lib.flatten (map (module: module.environment.systemPackages) modules);
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = packages ++ [ pkgs.zsh ];
        shellHook = ''
          echo "Welcome to nixploit"
          echo "Loaded ${toString (lib.length packages)} tools."
          tmux

          # Find a way to add temporary configurations
          # ln -sf ${self}/proxychains.conf $HOME/.proxychains/proxychains.conf
        '';
      };
    };
}
