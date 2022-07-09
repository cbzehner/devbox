{ ... }: {
  services.caddy = {
    enable = true;
    email = "admin@commitracer.com";

    virtualHosts = {
      "commitracer.com" = {
        serverAliases = [ "www.commitracer.com" ];
        extraConfig = ''
          encode gzip
          respond "Hello, world!"
        '';
      };
    };
  };
}
