{
  description = "Example Python development environment for Zero to Nix";

  # Flake inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # also valid: "nixpkgs"
  };

  # Flake outputs
  outputs = { self, nixpkgs }:
    let
      # Systems supported
      allSystems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-darwin" # 64-bit Intel macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];

      # Helper to provide system-specific attributes
      forAllSystems = f: nixpkgs.lib.genAttrs allSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      # Development environment output
      devShells = forAllSystems ({ pkgs }: {
        default =
          let
          in
          pkgs.mkShell {
            # The Nix packages provided in the environment
            packages = [
              # pkgs.azure-cli
              # pkgs.checkov
              # pkgs.dotnet-runtime_7
              # pkgs.tf-summarize
              # pkgs.tfsec
              pkgs.cargo
              pkgs.fzf
              pkgs.go
              pkgs.helix
              pkgs.nodePackages.prettier
              pkgs.infracost
              pkgs.kubernetes-helm
              pkgs.ledger
              pkgs.ncdu
              pkgs.openssl
              pkgs.powershell
              pkgs.pre-commit
              pkgs.ripgrep
              pkgs.terraform-docs
              pkgs.tflint
              pkgs.tfswitch
              pkgs.tfupdate
              pkgs.tree
              pkgs.python311Packages.python-lsp-server
              pkgs.gopls
              pkgs.delve
              pkgs.yaml-language-server
              pkgs.terraform-ls
              pkgs.cobra-cli
            ];
          };
      });
    };
}
