# TODO: Split into `machines/production.nix` & `machines/internal.nix`

{ config, ... }: {
  imports = [ ./common.nix ];

  networking.hostName = "production";
}
