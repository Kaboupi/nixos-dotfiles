{ cfg, ... }:

{
  networking = {
    hostName = cfg.hostname;

    networkmanager = {
      enable = true;
    };

    wireless = {
      enable = true;
    };

    firewall = {
      enable = true;

      allowedTCPPorts = cfg.sshPorts;
      allowedUDPPorts = [ ];

      trustedInterfaces = [ "docker0" "br-+" ];
      checkReversePath = "loose";
    };

    nat = {
      enable = true;
      internalInterfaces = [ "docker0" ];
    };
  };
}
