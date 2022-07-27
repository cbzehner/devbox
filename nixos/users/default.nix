{ pkgs, ... }:

let
  createUser = import ./template.nix;
  serviceUsers = import ./service_users.nix;
  users = builtins.map (createUser) [{
    username = "cbzehner";
    fullName = "Chris Zehner";
    email = "chris@cbzehner.com";
    access = "admin"; # owner, admin, employee, system, none
    secrets = "edit"; # edit, read, none
    publicKeys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJEjS07enj1SnDCvuG8rrvFjpx1PH2aEw5miYbMVQgMV/BSozzKLPqoLg2S+3E/EPcc8xqWqk3PcoHRRStgrgDcdzHlQurF+iARiQyh24qLQSUoMmyz/KvnhOXTfZdupHUMbCupv+gB4B/BNOCT6i1P3HHuInxYwYMSWQ6IAEDP+qAS68Go78cKxZL3eLnByE/5sCWzFNbUNt2NmYPapvdVyue1b/hSCRUUk0kmoOUR9bB9ZwNYVBVHC8YhLYi8itxUxXqdR4xwDQreDToYvZZA6dcAMsrxpbj5P3GLGUwR5KtlOjp/MqkIjkjVAQYsNjMWAT2ahjzR3qPrwlXXvTd/o3+uPve2TOL1WgeUV6Gx/0QkKj6SGdGuUVP5kbZaoAIqrEGXp7N4shjCpLybfRf6WZj9XLzy8TSr5jh0soEfbDIwyxrhv/TJu6ZXK1lhXWTjFLoXB0vnOrWhDBWpm/vrLGecwF3w43rNjnFkBGn0E9OGOdHlTe0l6XllrG8vZPxNIgf0W4jFrc5x0x4++2fH0JsThrtI+VmDhAoQak6Z6qTMpgs6/VwFCVaKsYP8quPyL5Mc+s0Gz2aM5dOukWb81DDi09R+9pC8LAw1ThAvNPd5E3zmVRH25IUg71PVkES8te9L05Mh6dZg+1G5bNIdYKSpKJx7tN5NZYv/dOAXw== cbzehner@gmail.com"
    ];
    overrides = {
      # TODO: Figure out how to hook into `starship init zsh` on each login. Possibly need to setup Home Manager.
      packages = with pkgs; [ bind helix htop starship ];
      shell = pkgs.zsh;
    };
  }];
in { imports = users; }
