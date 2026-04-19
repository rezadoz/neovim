{
  description = "de-charitized neovim fork";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages.default = pkgs.neovim.overrideAttrs (old: {
          src = self;
          version = "dev";
        });

        devShells.default = pkgs.mkShell {
          inputsFrom = [ pkgs.neovim ];
        };

        apps.default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/nvim";
        };
      });
}
