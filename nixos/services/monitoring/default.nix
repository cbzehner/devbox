{ config, ... }: {

  imports = [ ./grafana.nix ./loki.nix ./prometheus.nix ./promtail.nix ];

  services.caddy.virtualHosts."${config.services.grafana.domain}" = {
    serverAliases = [ "www.${config.services.grafana.domain}" ];
    extraConfig = ''
      encode zstd gzip

      reverse_proxy http://127.0.0.1:${toString config.services.grafana.port}
    '';
  };
}
