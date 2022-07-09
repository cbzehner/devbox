{ ... }: {
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 ];

    # mosh
    allowedUDPPortRanges = [{
      from = 60000;
      to = 61000;
    }];
  };
}
