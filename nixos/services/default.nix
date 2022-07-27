{ ... }: {
  imports =
    [ ./auth ./caddy.nix ./commitracer.nix ./firewall.nix ./monitoring ];
}
