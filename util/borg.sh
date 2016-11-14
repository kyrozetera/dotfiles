#!/bin/sh
REPOSITORY=/bak/borg

# --exclude 're:/home/kyro/installs\/(?!druid-0)' \

# Backup all of /home and /var/www except a few
# excluded directories
sudo -E borg create -v --stats -p                         \
    --compression zlib,9                          \
    $REPOSITORY::"$(hostname)-$(date +%Y-%m-%d)"  \
    /home                                       \
    /var/www                                    \
    /etc/NetworkManager/system-connections/     \
    --exclude '/home/*/.cache'                  \
    --exclude /home/kyro/builds                 \
    --exclude /home/kyro/workspace              \
    --exclude /home/kyro/Downloads              \
    --exclude /home/kyro/Pictures               \
    --exclude /home/kyro/eclipse-workspace      \
    --exclude /home/kyro/hpa_raw_loader         \
    --exclude /home/kyro/node_modules           \
    --exclude /home/kyro/nohup.out              \
    --exclude /home/kyro/config                 \
    --exclude /home/kyro/node                   \
    --exclude /home/kyro/R                      \
    --exclude /home/kyro/Music                  \
    --exclude /home/kyro/logs                   \
    --exclude /home/kyro/.local                 \
    --exclude /home/kyro/.zinc                  \
    --exclude /home/kyro/.ivy2                  \
    --exclude /home/kyro/.cache                 \
    --exclude /home/kyro/.m2                    \
    --exclude /home/kyro/.eclipse               \
    --exclude /home/kyro/.PlayOnLinux           \
    --exclude /home/kyro/.wine                  \
    --exclude /home/kyro/.rbenv                 \
    --exclude /home/kyro/.cargo                 \
    --exclude /home/kyro/.composer              \
    --exclude /home/kyro/.npm                   \
    --exclude /home/kyro/.sbt                   \
    --exclude '/home/kyro/*/target'             \
    --exclude '/var/www/KoddiETL/*/target'      \
    --exclude /var/www/.viminfo                 \
    --exclude '*.pyc'

sudo -E borg prune -v $REPOSITORY --prefix "$(hostname)-" \
    --keep-daily=3 --keep-weekly=2 --keep-monthly=2
