# modules/docker.nix
{ pkgs, ... }:

{
  virtualisation.docker.enable = true;

  users.users.isac.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [ 
    docker-compose 
  ];
}
