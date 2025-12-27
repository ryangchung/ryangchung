{
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      meta.description = "Shell environment for modifying this Nix configuration";
      name = "nixos-unified-template-shell";

      packages = with pkgs; [
        just
        nixd
      ];
    };
  };
}
