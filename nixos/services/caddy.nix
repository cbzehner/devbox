{ config, ... }: {
  services.caddy = {
    enable = true;
    email = "admin@commitracer.com";
  };
}
