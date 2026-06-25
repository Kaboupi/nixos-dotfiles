{ ... }:

{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };

      efi = {
        canTouchEfiVariables = true;
      };
    };

    kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;

      "net.ipv4.conf.all.accept_local" = 1;
      "net.ipv4.conf.default.accept_local" = 1;

      "net.ipv4.conf.all.rp_filter" = 2;
      "net.ipv4.conf.default.rp_filter" = 2;

      "net.bridge.bridge-ng-call-iptables" = 1;
    };
  };
}
