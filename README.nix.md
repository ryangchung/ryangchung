# Commands

## Optional
Before the following commands, it could be useful to do the following if any files changed:
```bash
git add .
```

## Rebuilding System
```bash
nix run .#activate --show-trace
nix run .#activate $USER@$HOSTNAME --show-trace
```

## Updating Nixpkgs
```bash
nix run .#update --show-trace
```

# Acknowledgements
Nix configs originally derived from [MFarabi619](https://github.com/MFarabi619/MFarabi619).
