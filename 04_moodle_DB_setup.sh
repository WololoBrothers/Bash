# DB setup

# Ingresar nombre de la base de datos

echo "Ingrese un nombre para la base de datos a crear.
Sugerencia: moodle_db"
read NAMEDB

# Ingresar nombre del usuario para la base de datos

echo "Ingrese un nombre para el usuario de la base de datos a crear.
Sugerencia: moodle_db_user"
read USERDB

# Generar password aleatorio como sugerencia, luego permitirle al usuario ingresar uno

PASSWDDB="$(openssl rand -base64 12)"

echo "Ingrese un password para el usuario a crear, sin espacios.
Sugerencia generada al azar: $PASSWDDB"
read PASSWDDB


# If /root/.my.cnf exists then it won't ask for root password
if [ -f /root/.my.cnf ]; then

    mysql -e "CREATE DATABASE ${NAMEDB} /*\!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;"
    mysql -e "CREATE USER ${USERDB}@localhost IDENTIFIED BY '${PASSWDDB}';"
    mysql -e "GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,CREATE TEMPORARY TABLES,DROP,INDEX,ALTER ON ${NAMEDB}.* TO '${USERDB}'@'localhost';"
    mysql -e "FLUSH PRIVILEGES;"

# If /root/.my.cnf doesn't exist then it'll ask for root password   
else
    echo "Ingrese el password de root en MySQL"
    read rootpasswd
    mysql -uroot -p${rootpasswd} -e "CREATE DATABASE ${NAMEDB} /*\!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;"
    mysql -uroot -p${rootpasswd} -e "CREATE USER ${USERDB}@localhost IDENTIFIED BY '${PASSWDDB}';"
    mysql -uroot -p${rootpasswd} -e "GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,CREATE TEMPORARY TABLES,DROP,INDEX,ALTER ON ${NAMEDB}.* TO '${USERDB}'@'localhost' IDENTIFIED BY '${PASSWDDB}';"
    mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;"
fi