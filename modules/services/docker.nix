{ ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;

    daemon.settings = {
      iptables = true;
      ip-forward = true;
      userland-proxy = false;
      live-restore = true;

      icc = true;

      dns = [
        "1.1.1.1"
        "8.8.8.8"
      ];
    };
  };
}
