# modules/tailscale.nix
{ ... }:

{
  services.tailscale.enable = true;

  # Let traffic from the tailnet bypass the firewall's normal filtering.
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  networking.firewall.checkReversePath = "loose";

  # First-time setup on each host: sudo tailscale up
  # (add --authkey=... or feed one via secrets/ once sops-nix/agenix is in place).
}
