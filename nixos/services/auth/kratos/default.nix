{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.services.kratos;
  kratos = pkgs.callPackage ../../../pkgs/auth/kratos/default.nix { };
in {
  options = {
    services.kratos = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to start the kratos service.";
      };
    };
  };

  config = mkIf cfg.enable {
    # Upstream: https://www.ory.sh/docs/kratos/guides/deploy-kratos-example#run-ory-kratos-using-systemd
    systemd.services.kratos = {
      description = "Kratos service";
      after = [ "network.target" ];
      startLimitIntervalSec = 0;

      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${kratos}/bin/kratos -c /etc/config/kratos/kratos.yml serve";
        Restart = "always";
        RestartSec = 1;
        PrivateTmp = true;
      };
      wantedBy = [ "multi-user.target" ];
    };

    environment.systemPackages = [ kratos ];

    environment.etc = {
      "config/kratos/identity.schema.json" = {
        source = ./identity.schema.json;
      };
      "config/kratos/kratos.yml" = { source = ./kratos.yml; };
    };
  };
}
