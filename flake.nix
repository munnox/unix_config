{
  description = "A very basic flake";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in
        {
          # devShells."${system}".default = import ./shell.nix { inherit pkgs; };
          # devShells."aarch64-linux".default = import ./shell.nix { inherit pkgs; };
          # devShells."x86_64-darwin".default = import ./shell.nix { inherit pkgs; };
          packages.hello = pkgs.hello;
          packages.shell = import ./deploy/shell.nix { inherit pkgs; };
          packages.default = self.packages.${system}.shell;
          # devShells.aarch64-darwin.default = import ./shell.nix { inherit pkgs; };
          devShells.default = self.packages.${system}.shell;
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
