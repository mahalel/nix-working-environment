{
  description = "Dev Packages";

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
              pkgs.tf-summarize
              pkgs.opentofu
              pkgs.cargo
              pkgs.fzf
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
              pkgs.cobra-cli
              pkgs.fd
              # pkgs.lazygit
              pkgs.json-schema-for-humans
              pkgs.gh
              pkgs.go
              pkgs.check-jsonschema
              pkgs.glow
              pkgs.entr
              pkgs.hugo
              # pkgs.llm
              # Language Servers and debuggers
              pkgs.nodePackages.pyright
              pkgs.nil
              pkgs.tailwindcss-language-server
              pkgs.ruff-lsp
              pkgs.gopls
              pkgs.delve
              pkgs.yaml-language-server
              # pkgs.serpl


              # Python packages
              pkgs.python311Packages.pandas
              pkgs.python311Packages.python-docx
              # pkgs.python311Packages.python-pptx
              # pkgs.python311Packages.python-dotenv
            ];
          };
      });
    };
}
