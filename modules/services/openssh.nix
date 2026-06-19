{ cfg, ... }:

{
  services.openssh = {
    enable = true;
    ports = cfg.sshPorts;
    settings = {
      PasswordAuthentication = cfg.sshPasswordAuthentication;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };
}
