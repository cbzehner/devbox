{ config, ... }: {

  imports = [ ./kratos ./keto.nix ./oathkeeper.nix ];

  services.kratos.enable = true;
}
