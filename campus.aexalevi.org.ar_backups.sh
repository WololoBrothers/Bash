#!/bin/sh
# campus.aexalevi.org.ar_backups

# definir nombres para todos los backups, que se guardaran en sus respectivas carpetas

now=$(date +"%d_%m_%Y")

echo $now >> /home/dbrothers/backups_all/status

# database, moodledata, moodle

backup_name_DB="/home/dbrothers/backups_all/campus.aexalevi.org.ar/DB_backups/DB_backup_$now.sql"
backup_name_DT="/home/dbrothers/backups_all/campus.aexalevi.org.ar/DT_backups/DT_backup_$now.tar.gz"
backup_name_MO="/home/dbrothers/backups_all/campus.aexalevi.org.ar/MO_backups/MO_backup_$now.tar.gz"

# 1 - DB
# pasando parametros para mysqldump

db_host="localhost"
db_name="moodle"
db_user="moodle"
db_pass="NOT_THE_PASSWORD"

# crear dump DB

mysqldump -u $db_user -p"NOT_THE_PASSWORD" -C -Q -e --create-options $db_name > $backup_name_DB

# eliminar los demas files

find /home/dbrothers/backups_all/campus.aexalevi.org.ar/DB_backups/ -type f ! -name DB_backup_$now.sql ! -name DB_backups -delete

echo "DB backup done."

# 2 - moodledata

# eliminar los demas files

find /home/dbrothers/backups_all/campus.aexalevi.org.ar/DT_backups/ -type f ! -name DT_backup_$now.tar.gz ! -name DT_backups -delete

cd /var/www/

# comprimir la carpeta moodledata
# no se usa la ruta entera para la compresion, solo para el destino

tar -zcf $backup_name_DT moodledata

echo "moodledata folder backup done."

# 3 - moodle

# eliminar los demas files

find /home/dbrothers/backups_all/campus.aexalevi.org.ar/MO_backups/ -type f ! -name MO_backup_$now.tar.gz ! -name MO_backups -delete

cd /var/www/

# comprimir la carpeta moodle (public_html)
# no se usa la ruta entera para la compresion, solo para el destino

tar -zcf $backup_name_MO campus.aexalevi.org.ar

echo "moodle folder backup done."
