{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    apple-silicon = {
      url = "github:nix-community/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { apple-silicon, ... }:
    let
      p = apple-silicon.packages.aarch64-linux;
    in
    {
      hydraJobs = {
        linux-asahi.aarch64-linux = p.linux-asahi;
        uboot-asahi.aarch64-linux = p.uboot-asahi;
      };
    };
}
