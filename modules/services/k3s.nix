{ cfg, pkgs, ... }:

{
  services.k3s = {
    enable = true;
    role = "server";
    # extraFlags = [ "--disable=traefik" ];
  };

  networking.firewall = {
    allowedTCPPorts = [ 6443 ];
    allowedUDPPorts = [ 8472 ];
  };

}
