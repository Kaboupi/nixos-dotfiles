{ cfg, ... }:

{
  services.fail2ban = {
    enable = true;

    maxretry = 3;
    bantime = "180m";

    ignoreIP = [
      "127.0.0.1/8"
      "192.168.1.0/24"
      "172.16.0.0/12"
    ];

    jails.DEFAULT.settings.findtime = "30m";

    jails.sshd.settings = {
      enabled = true;
      filter = "sshd";
      port = toString cfg.sshPort;
      maxretry = 3;
    };
  };
}
