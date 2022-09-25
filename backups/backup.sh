#!/bin/bash

# tu backup quel fichier ?
backup_files="/backup.tgz /home /var/www /var/lib/pterodactyl/ /etc /root/alls-databases.sql"

# Tu met la backup dans ?
dest="/backup/"

# Le nom de ta backup.
day=$(date)
hostname=$(hostname -s)
archive_file="$hostname-$day.tgz"
echo $archive_file

echo "start"

# Backup.
tar czf $dest/"$archive_file" $backup_files

ls -lh $dest

echo "backup done"

# Tu supprime les backup de plus de 7 jours.
find $dest -mtime +7 -exec rm {} \;