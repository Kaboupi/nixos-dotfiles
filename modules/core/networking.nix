{ cfg, ... }:

{
  networking.networkmanager.enable = true;
  networking.wireless.enable = true;
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = cfg.sshPorts;
}
