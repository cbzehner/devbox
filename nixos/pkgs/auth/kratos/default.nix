# TOOD: Read https://hoverbear.org/blog/configurable-nix-packages/
{ buildGoModule, lib, stdenv }:

buildGoModule rec {
  pname = "kratos";
  version = "0.10.1";

  src = fetchTarball {
    url = "https://github.com/ory/kratos/archive/refs/tags/v0.10.1.tar.gz";
    sha256 = "sha256:0031830qvkpkdlkqap5xlxzmjh4wg7n4jd8c1crvjh331zpqvp9d";
  };

  vendorSha256 = "sha256-9zXoJ+c1aPWDqasechC4ModWE0+sfMqZzp/Pph/mYcs=";

  subPackages = [ "." ];

  tags = [ "sqlite" ];

  meta = with lib; {
    maintainers = with maintainers; [ mrmebelman cbzehner ];
    homepage = "https://www.ory.sh/kratos/";
    license = licenses.asl20;
    description =
      "An API-first Identity and User Management system that is built according to cloud architecture best practices";
  };
}
