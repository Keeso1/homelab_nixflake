# modules/zshrc.nix
{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    histSize = 1000;
    histFile = "$HOME/.histfile";
    setOptions = [ "NO_BEEP" ];

    shellAliases = {
      dotfiles = "/run/current-system/sw/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME";
      spf = "superfile";
      nixbuildswitch = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      nixbuildtest = "sudo nixos-rebuild test --flake /etc/nixos#nixos";
      nixbuild = "sudo nixos-rebuild build --flake /etc/nixos#nixos";
      nixupdate = "cd /etc/nixos && nix flake update && cd -";
      nixstage = "cd /etc/nixos && sudo git add -A && git status";
    };

    # Anything that isn't a plain alias — vi mode, functions, etc.
    interactiveShellInit = ''
      bindkey -v

      nixcommit() {
        cd /etc/nixos && sudo git commit -m "$1" && git status
      }
    '';
  };

  programs.starship.enable = true;

  programs.zoxide = {
    enable = true;
    flags = [ "--cmd" "cd" ];
  };

  programs.fzf = {
    keybindings = true;
    fuzzyCompletion = true;
  };

  environment.variables.EDITOR = "nvim";
}
