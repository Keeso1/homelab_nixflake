# modules/syncthing.nix
{ ... }:

{
  services.syncthing = {
    enable = true;
    user = "isac";
    dataDir = "/home/isac/Sync";
    configDir = "/home/isac/.config/syncthing";
    openDefaultPorts = true;
  };
}
