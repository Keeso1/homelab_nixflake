# Migrated from the old Ubuntu cyberhome's crontab + /usr/local/bin/backup-vaultwarden.sh.
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ restic sqlite ];

  # Monthly: stop vaultwarden, restic backup vw-data to Backblaze B2, prune, restart.
  systemd.services.vaultwarden-backblaze-backup = {
    description = "Backup Vaultwarden data to Backblaze B2 via restic";
    path = with pkgs; [ docker docker-compose restic ];
    serviceConfig = {
      Type = "oneshot";
      User = "isac";
      EnvironmentFile = "/home/isac/.restic-env";
    };
    script = ''
      set -e
      VW_DATA="/home/isac/homelab/vaultwarden/vw-data"
      LOG_FILE="/home/isac/homelab/restic-backup.log"

      echo "=== Vaultwarden backup started: $(date) ===" >> "$LOG_FILE"
      docker stop vaultwarden >> "$LOG_FILE" 2>&1
      restic backup "$VW_DATA" >> "$LOG_FILE" 2>&1
      restic forget --keep-monthly 12 --prune >> "$LOG_FILE" 2>&1
      docker compose -f /home/isac/homelab/compose.yaml up -d vaultwarden >> "$LOG_FILE" 2>&1
      echo "=== Backup finished: $(date) ===" >> "$LOG_FILE"
    '';
  };

  systemd.timers.vaultwarden-backblaze-backup = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "monthly";
      Persistent = true;
    };
  };

  # Daily: live sqlite .backup + rsa_key.pem copy into the syncthing-synced snapshot dir.
  systemd.services.vaultwarden-sqlite-snapshot = {
    description = "Daily Vaultwarden sqlite snapshot for syncthing";
    path = with pkgs; [ sqlite coreutils ];
    serviceConfig = {
      Type = "oneshot";
      User = "isac";
    };
    script = ''
      set -e
      VW_DATA="/home/isac/homelab/vaultwarden/vw-data"
      VW_SNAPSHOT="/home/isac/homelab/vaultwarden/vw-data-snapshot"

      sqlite3 "$VW_DATA/db.sqlite3" ".backup $VW_SNAPSHOT/db.sqlite3"
      cp "$VW_DATA/rsa_key.pem" "$VW_SNAPSHOT/"
    '';
  };

  systemd.timers.vaultwarden-sqlite-snapshot = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 03:15:00";
      Persistent = true;
    };
  };
}
