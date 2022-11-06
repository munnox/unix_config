{
  description = "A very basic flake";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.unix_config.url = "github:munnox/unix_config";
  inputs.helix.url = "github:helix-editor/helix";
  inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils, unix_config, helix, home-manager }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          local_pkgs = self.packages.${system};
          local_apps = self.apps.${system};
        in
        {
          packages.hello = pkgs.hello;
          packages.unix_config = unix_config;
          # WIP vscode.... 
          # packages.mycode = pkgs.vscodium;
          # nix run .#nelix
          packages.helix =  helix.packages.${system}.helix;
          # nix run .#nvim
          packages.nvim =  pkgs.neovim;
          packages.deployshell = import ./deploy/shell.nix { inherit pkgs; inherit self; };
          packages.default = local_pkgs.deployshell;
          devShells.default = local_pkgs.deployshell;
          formatter = pkgs.nixpkgs-fmt;
          homeConfigurations.robert = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            # Specify your home configuration modules here, for example,
            # the path to your home.nix.
            modules = [
              ./home.nix
            ];

            # Optionally use extraSpecialArgs
            # to pass through arguments to home.nix
          };
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
