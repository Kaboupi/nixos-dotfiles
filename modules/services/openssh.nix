{ cfg, ... }:

{
  services.openssh = {
    enable = true;
    ports = cfg.sshPorts;

    listenAddresses = [
      {
        addr = "0.0.0.0";
        port = cfg.sshPorts;
      }
    ];

    settings = {
      PasswordAuthentication = cfg.sshPasswordAuthentication;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };
}
