{
  description = "A very basic flake";
  
  # Input dependancies
  ## Simply flake build
  inputs.flake-utils.url = "github:numtide/flake-utils";
  # ## Pin and direct the nixpkgs
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  # inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  ## Import the Home Manger derivations
  inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  ## Import the helix derivations
  inputs.helix.url = "github:helix-editor/helix";
  ## Optional Link to my config repo

  # inputs.unix_config.url = "gitlab:munnox/unix_config";


  outputs = { self, nixpkgs, flake-utils, helix, home-manager }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          local_pkgs = self.packages.${system};
          local_apps = self.apps.${system};
        in
        {
          # packages.hello = pkgs.hello;
          # packages.git = pkgs.git;

          # packages.unix_config = unix_config;
          # WIP vscode.... 
          # packages.mycode = pkgs.vscodium;
          # nix run .#nelix
          packages.helix = helix.packages.${system}.helix;
          # nix run .#nvim
          packages.nvim = pkgs.neovim;

          # nix develop .#deploypy
          packages.deployshell = import ./deploy/shell.nix { inherit pkgs; inherit self; };

          # Build and run a poetry deployment shell
          # nix develop .#deploypy
          packages.deploypy = pkgs.poetry2nix.mkPoetryApplication {
            projectDir = ./deploy/.;
          };
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
          packages.applyhome = pkgs.runCommand "applyhome" { buildInputs = [ ]; }
            ''
              mkdir -p $out/bin
              # Simplied due to conversation with Simon Walker the line at the bottom is all that is required so far
              # TODO after testing removed the next two lines
              # cp -r ${self.homeConfigurations.${system}.robert.activationPackage}/* $out/
              # cp $out/activate $out/bin/applyhome
              cp -r ${self.homeConfigurations.${system}.robert.activationPackage}/activate $out/bin/applyhome
            '';
          apps.applyhome = flake-utils.lib.mkApp { drv = local_pkgs.applyhome; };
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
