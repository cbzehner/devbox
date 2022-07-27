# devbox
Personalized development environment

## Getting Started

1. Add the domain of your project to the `DOMAIN` environment variable in `.env`.
1. Copy `.env.local.example` to `.env.local`, then add values for `CLOUDFLARE_API_TOKEN` and `DIGITALOCEAN_ACCESS_TOKEN`.
1. Install Nix on your machine and then run `nix-shell` from within this repository to enter a nix shell.
1. Comment out `permitRootLogin = "no";` in `nixos/common.nix` and run `just init` to provision the infrastructure.

## Terraform

### DNS
Set up a DNS record pointing `<username>.dev` to your infrastructure.

### Production

### Internal

## Nix

#### Resources
- [nix-shell in a nutshell](https://thiagowfx.github.io/2022/02/nix-shell-in-a-nutshell/)
- [The search for a minimal nix-shell continued; mkShellMinimal](https://fzakaria.com/2021/08/05/the-search-for-a-minimal-nix-shell-continued-mkshellminimal.html)
- [How I nix?](https://eevie.ro/posts/2022-01-24-how-i-nix.html)

## Todo
- [Paranoid NixOS Setup](https://xeiaso.net/blog/paranoid-nixos-2021-07-18)
- Use Postgres as the backing database for Grafana
- Package the Ory Suite (Kratos, Keto, Oathkeeper)
- Setup analytics with Umami
- [GitHub Actions CI](https://nixos.org/guides/continuous-integration-github-actions.html)