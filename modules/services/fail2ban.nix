{ ... }:

{
  services.fail2ban = {
    enable = true;

    maxretry = 3;
    bantime = "180m";
    findtime = "30m";

    ignoreIP = [
      "127.0.0.1/8"
      "192.168.1.0/24"
      "172.16.0.0/12"
    ];

    jails = {
      sshd = ''
        enabled = true;
        port = ssh
        filter = sshd
        maxretry = 3
      '';
    };
  };
}
