{ config, ... }: {
  services.caddy.virtualHosts."commitracer.com" = {
    serverAliases = [ "www.commitracer.com" ];
    extraConfig = ''
      encode zstd gzip

      respond "Hello, world!"
    '';
  };
}
