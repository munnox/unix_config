{
  description = "A very basic flake";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.helix.url = "github:helix-editor/helix";

  outputs = { self, nixpkgs, flake-utils, helix }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in
        {
          packages.hello = pkgs.hello;
          # WIP vscode.... 
          # packages.mycode = pkgs.vscodium;
          # nix run .#nelix
          packages.helix =  helix.packages.${system}.helix;
          # nix run .#nvim
          packages.nvim =  pkgs.neovim;
          packages.deployshell = import ./deploy/shell.nix { inherit pkgs; };
          packages.default = self.packages.${system}.deployshell;
          devShells.default = self.packages.${system}.deployshell;
        }
      );
  # outputs = { self, nixpkgs }: {

  #   # packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

  #   # packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
  #   # packages.aarch64-darwin.default = self.packages.x86_64-linux.hello;
  #   packages.aarch64-darwin.default = import develop/shell.nix { inherit pkgs; };
  #   devShells."aarch64-darwin".default = import develop/shell.nix { inherit pkgs; };

  # };
}
