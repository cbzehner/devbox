{ config, pkgs, ... }: {
  imports = [
    # Question: Does having both headless & hardened profiles active layer them? Or do they conflict / are they redundant?
    <nixpkgs/nixos/modules/profiles/headless.nix>
    <nixpkgs/nixos/modules/profiles/hardened.nix>
    ./hardware-configuration.nix # provider specific hardware configuration
    ./networking.nix # generated at runtime by nixos-infect
    ./users
    ./services
  ];

  boot.cleanTmpDir = true;
  zramSwap.enable = true;
  nixpkgs.config.allowUnfree = true;

  nix = {
    # TODO: Automate user controls
    allowedUsers = [ "cbzehner" "root" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };
    # Free up to 1GiB whenever there is less than 100MiB left
    extraOptions = ''
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
    autoOptimiseStore = true;
  };

  system = {
    stateVersion = "22.05";
    autoUpgrade = {
      enable = true;
      allowReboot = true;
      channel = "https://nixos.org/channels/nixos-22.05-small";
    };
  };

  security = {
    sudo.extraRules = [{
      # TODO: Automate user controls
      users = [ "cbzehner" ];
      commands = [{
        command = "ALL";
        options = [ "NOPASSWD" "SETENV" ];
      }];
    }];
  };

  environment.systemPackages = with pkgs; [ mosh ];

  services = {
    # Host  services
    fail2ban = {
      enable = true;
      bantime-increment.enable = true;
    };

    # Consider switching from SSH to Tailscale. See "VPN for Access" at https://xeiaso.net/blog/paranoid-nixos-2021-07-18
    openssh = {
      enable = true;
      permitRootLogin = "no"; # Disable all logins by the "root" user account.
      passwordAuthentication = false;
    };
  };

  users = {
    mutableUsers = false;

    users.root.openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJEjS07enj1SnDCvuG8rrvFjpx1PH2aEw5miYbMVQgMV/BSozzKLPqoLg2S+3E/EPcc8xqWqk3PcoHRRStgrgDcdzHlQurF+iARiQyh24qLQSUoMmyz/KvnhOXTfZdupHUMbCupv+gB4B/BNOCT6i1P3HHuInxYwYMSWQ6IAEDP+qAS68Go78cKxZL3eLnByE/5sCWzFNbUNt2NmYPapvdVyue1b/hSCRUUk0kmoOUR9bB9ZwNYVBVHC8YhLYi8itxUxXqdR4xwDQreDToYvZZA6dcAMsrxpbj5P3GLGUwR5KtlOjp/MqkIjkjVAQYsNjMWAT2ahjzR3qPrwlXXvTd/o3+uPve2TOL1WgeUV6Gx/0QkKj6SGdGuUVP5kbZaoAIqrEGXp7N4shjCpLybfRf6WZj9XLzy8TSr5jh0soEfbDIwyxrhv/TJu6ZXK1lhXWTjFLoXB0vnOrWhDBWpm/vrLGecwF3w43rNjnFkBGn0E9OGOdHlTe0l6XllrG8vZPxNIgf0W4jFrc5x0x4++2fH0JsThrtI+VmDhAoQak6Z6qTMpgs6/VwFCVaKsYP8quPyL5Mc+s0Gz2aM5dOukWb81DDi09R+9pC8LAw1ThAvNPd5E3zmVRH25IUg71PVkES8te9L05Mh6dZg+1G5bNIdYKSpKJx7tN5NZYv/dOAXw== cbzehner@gmail.com"
    ];
  };
}
