{ cfg, ... }:

{
  services.openssh = {
    enable = true;
    ports = [ cfg.sshPort ];

    listenAddresses = [
      {
        addr = "0.0.0.0";
        port = cfg.sshPort;
      }
    ];

    settings = {
      PasswordAuthentication = cfg.sshPasswordAuthentication;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };
}
