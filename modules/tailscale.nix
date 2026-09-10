# modules/tailscale.nix
{ ... }:

{
  services.tailscale.enable = true;

  # Let traffic from the tailnet bypass the firewall's normal filtering.
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  networking.firewall.checkReversePath = "loose";

  # Required for exit-node / subnet-router traffic to actually be forwarded.
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  # First-time setup on each host: sudo tailscale up
  # (add --authkey=... or feed one via secrets/ once sops-nix/agenix is in place).
}
