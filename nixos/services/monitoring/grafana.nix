{ config, ... }: {

  services.grafana = {
    # TODO: Add community maintained dashboards
    enable = true;
    domain = "grafana.internal.commitracer.com";
    port = 2342;
    addr = "127.0.0.1";
    provision = {
      enable = true;
      datasources = [
        {
          name = "Prometheus";
          type = "prometheus";
          url = "http://localhost:${toString config.services.prometheus.port}";
        }
        {
          name = "Loki";
          type = "loki";
          url = "http://localhost:${
              toString
              config.services.loki.configuration.server.http_listen_port
            }";
        }
      ];
      # dashboards = [
      #   {
      #     name = "Node Exporter";
      #     options.path = pkgs.packages.grafanaDashboards.node-exporter;
      #     disableDeletion = true;
      #   }
      #   # {
      #   #   name = "NGINX";
      #   #   options.path = pkgs.packages.grafanaDashboards.nginx;
      #   #   disableDeletion = true;
      #   # }
      # ];
    };
  };
}
