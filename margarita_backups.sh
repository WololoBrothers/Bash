#!/bin/sh
# moodlenet.com.ar_backups

# definir nombres para todos los backups, que se guardaran en sus respectivas carpetas

now=$(date +"%d_%m_%Y")

# database, moodledata, moodle

backup_MO_microsoft="/home/dbrothers/backups_all/microsoft.net-learning.com.ar/moodle_$now.tar.gz"
backup_DT_microsoft="/home/dbrothers/backups_all/microsoft.net-learning.com.ar/data_$now.tar.gz"
backup_DB_microsoft="/home/dbrothers/backups_all/microsoft.net-learning.com.ar/DB_$now.sql"

backup_MO_mobile="/home/dbrothers/backups_all/mobile.net-learning.com.ar/moodle_$now.tar.gz"
backup_DT_mobile="/home/dbrothers/backups_all/mobile.net-learning.com.ar/data_$now.tar.gz"
backup_DB_mobile="/home/dbrothers/backups_all/mobile.net-learning.com.ar/DB_$now.sql"

backup_staging="/home/dbrothers/backups_all/staging.net-learning.com.ar/staging.net-learning.com.ar_$now.tar.gz"
backup_NL="/home/dbrothers/backups_all/net-learning.com.ar/net-learning.com.ar_$now.tar.gz"


# eliminar los backups anteriores

rm -rf /home/dbrothers/backups_all/microsoft.net-learning.com.ar/*
rm -rf /home/dbrothers/backups_all/mobile.net-learning.com.ar/*
rm -rf /home/dbrothers/backups_all/staging.net-learning.com.ar/*
rm -rf /home/dbrothers/backups_all/net-learning.com.ar/*

	# MICROSOFT.NET-LEARNING.COM.AR

	# 1.1 - public_html para microsoft.net-learning.com.ar

	cd /var/www/microsoft.net-learning.com.ar/

	# comprimir la carpeta public_html para microsoft
	# no se usa la ruta entera para la compresion, solo para el destino

	tar -zcf $backup_MO_microsoft public_html

	echo "$now microsoft.net-learning.com.ar - public_html backup done." >> /home/dbrothers/backups_all/info_backups

	# 1.2 - moodledata para microsoft.net-learning.com.ar

	cd /var/www/microsoft.net-learning.com.ar/

	# comprimir la carpeta moodledata pra microsoft
	# no se usa la ruta entera para la compresion, solo para el destino

	tar -zcf $backup_DT_microsoft moodledata

	echo "$now  microsoft.net-learning.com.ar - moodledata backup done." >> /home/dbrothers/backups_all/info_backups

	# 1.3 - DB para microsoft.net-learning.com.ar

	db_name="nl_microsoft"
	db_user="usr_microsoft"
	db_pass="NOT_THE_PASSWORD"

	mysqldump -u $db_user -p"MZA5jXl4" -C -Q -e --create-options $db_name > $backup_DB_microsoft


	# MOBILE.NET-LEARNING.COM.AR

	# 2.1 - public_html para mobile.net-learning.com.ar

	cd /var/www/mobile.net-learning.com.ar/

	# comprimir la carpeta public_html para mobile
	# no se usa la ruta entera para la compresion, solo para el destino

	tar -zcf $backup_MO_mobile public_html

	echo "$now mobile.net-learning.com.ar - public_html backup done." >> /home/dbrothers/backups_all/info_backups

	# 2.2 - moodledata para mobile.net-learning.com.ar

	cd /var/www/mobile.net-learning.com.ar/

	# comprimir la carpeta moodledata pra mobile
	# no se usa la ruta entera para la compresion, solo para el destino

	tar -zcf $backup_DT_mobile moodledata

	echo "$now  mobile.net-learning.com.ar - moodledata backup done." >> /home/dbrothers/backups_all/info_backups

	# 2.3 - DB para mobile.net-learning.com.ar

	db_name="moodle_mobile"
	db_user="root"
	db_pass="NOT_THE_PASSWORD"

	mysqldump -u $db_user -p"noMfvIEuEtPeagxgnL4G" -C -Q -e --create-options $db_name > $backup_DB_mobile


	# STAGING.NET-LEARNING.COM.AR

	# 3 - staging.net-learning.com.ar

	cd /var/www/

	# comprimir la carpeta staging.net-lerning.com.ar, ESTA MAL DELETREADA!
	# no se usa la ruta entera para la compresion, solo para el destino

	tar -zcf $backup_staging staging.net-lerning.com.ar

	echo "$now staging.net-learning.com.ar backup done." >> /home/dbrothers/backups_all/info_backups

	# 4 - net-learning.com.ar

	cd /var/www/

	# comprimir la carpeta net-learning.com.ar
	# no se usa la ruta entera para la compresion, solo para el destino

	tar -zcf $backup_NL net-learning.com.ar

	echo "$now net-learning.com.ar backup done." >> /home/dbrothers/backups_all/info_backups


df -h >> /home/dbrothers/backups_all/info_backups

