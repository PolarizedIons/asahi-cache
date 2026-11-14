# Asahi-Cache

## What this is

This is a flake poining to a public nix binary cache of the asahi-linux kernel for the aarch64 arcitecture, aka. a binray cache for nix on Apple Silicon.

## Using this

### 1. Add the cache to your nixos config:

```nix
nix.settings = {
  extra-substituters = [ "https://asahi-cache.polarizedions/asahi" ];
  extra-trusted-public-keys = [ "asahi:F/EfcEzAyd1OPgpUMWv4Fn6g0EZcfkb5eiRcp6PEV5M=" ];
};
```

Apply with `nixos-rebuild` _before_ you continue, so that nix can pick up the new settings - otherwise you'll just build the kernel yourself the first time.

### 2. Pin your flake revisions to ours

```nix
inputs = {
  asahi-cache = "github:PolarizedIons/asahi-cache";
  nixpkgs.follows = "asahi-cache/nixpkgs";
  apple-silicon.follows = "asahi-cache/apple-silicon";
};
```

If you had other definitions for `nixpkgs` or `apple-silicon`, remove them.

### 3. Check that it works

Run the following, it _should_ say "will be fetched", not "will be built" on the kernel.

```nix
nix build .#nixosConfiguratiuons.myhostnamehere.config.boot.kernelPackages.kernel --dry-run
```
