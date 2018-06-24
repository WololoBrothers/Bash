#!/bin/sh
# aulavirtual.cui.edu.ar_backups

# definir nombres para todos los backups, que se guardaran en sus respectivas carpetas

now=$(date +"%d_%m_%Y")

# database, moodledata, moodle

backup_name_DB="/home/dbrothers/backups_all/aulavirtual.cui.edu.ar/DB_backups/DB_backup_$now.sql"
backup_name_DT="/home/dbrothers/backups_all/aulavirtual.cui.edu.ar/DT_backups/DT_backup_$now.tar.gz"
backup_name_MO="/home/dbrothers/backups_all/aulavirtual.cui.edu.ar/MO_backups/MO_backup_$now.tar.gz"

# 1 - DB
# pasando parametros para mysqldump

db_host="localhost"
db_name="moodle_cui"
db_user="usr_cui"
db_pass="NOT_THE_PASSWORD"

# crear dump DB. Password harcodeado!

mysqldump -u $db_user -p"NOT_THE_PASSWORD" -C -Q -e --create-options $db_name > $backup_name_DB

# eliminar los demas files

find /home/dbrothers/backups_all/aulavirtual.cui.edu.ar/DB_backups/ -type f ! -name DB_backup_$now.sql ! -name DB_backups -delete

echo "DB backup done."

# 2 - moodledata

# eliminar los demas files

find /home/dbrothers/backups_all/aulavirtual.cui.edu.ar/DT_backups/ -type f ! -name DT_backup_$now.tar.gz ! -name DT_backups -delete

cd /var/www/aulavirtual.cui.edu.ar/

# comprimir la carpeta moodledata
# no se usa la ruta entera para la compresion, solo para el destino

tar -zcf $backup_name_DT moodledata

echo "moodledata folder backup done."

# 3 - moodle

# eliminar los demas files

find /home/dbrothers/backups_all/aulavirtual.cui.edu.ar/MO_backups/ -type f ! -name MO_backup_$now.tar.gz ! -name MO_backups -delete

cd /var/www/aulavirtual.cui.edu.ar/

# comprimir la carpeta moodle (public_html)
# no se usa la ruta entera para la compresion, solo para el destino

tar -zcf $backup_name_MO public_html

echo "moodle folder backup done."