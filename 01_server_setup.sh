# Server setup

# Descarga e instalación de actualizaciones

sudo apt-get update && apt-get upgrade

# Instalación de Apache2

sudo apt-get install apache2

# Agregado del ServerName al final con IP de servidor actual

current_ip="$(hostname -I | cut -d" " -f1)"
final_line="ServerName $current_ip"
echo $final_line >> /etc/apache2/apache2.conf

     # Podría cortar el script si sale algo que no sea "Syntax OK" al correr sudo apache2ctl configtest
     # Reiniciado de Apache

sudo systemctl restart apache2

	# Firewalls: permiso para tráfico de Apache2
	# Én este punto deberíamos efectivamente activar un firewall

# reference:
# https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-16-04
# https://www.digitalocean.com/community/tutorials/ufw-essentials-common-firewall-rules-and-commands

# default setup for UFW to deny incoming and allow outgoing

sudo ufw default deny incoming
sudo ufw default allow outgoing

# allow ssh (before turning on the firewall!)

sudo ufw allow 22

# same thing can be done typing "sudo ufw allow ssh"
# we can also allow SSH only from specific IP addresses!

# rsync from specific IPs not allowed for now
# no changes for remote MySQL acces either
 
# allow ports 25 and 587 (email)

sudo ufw allow 25
sudo ufw allow 587

# allow all types of email connections

sudo ufw allow 143
sudo ufw allow 993
sudo ufw allow 110
sudo ufw allow 995

# allow web server traffic HTTP and HHTPS. Same thing can be done with "sudo ufw allow 80" and "sudo ufw allow 443"
# allow both can also be done with "sudo ufw allow proto tcp from any to any port 80,443"

sudo ufw allow http
sudo ufw allow https
sudo ufw allow in "Apache Full"

# finally, enable ufw!

sudo ufw enable


# Instalación de MySQL
 
 sudo apt-get install mysql-server

     # Acá o en el siguiente paso va a haber que definir credenciales para MySQL
     # Aplicacion de seguridad

mysql_secure_installation
          
# Instalación de PHP

sudo apt-get install php

# Instalación de integraciones con Apache y MySQL

apt-get install libapache2-mod-php php-mysql

# Cambio de Orden: de HTML PHP --> PHP HTML

echo "<IfModule mod_dir.c>
        DirectoryIndex index.php index.cgi index.pl index.html index.xhtml index.htm
</IfModule>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet">/etc/apache2/mods-enabled/dir.conf
 
# Reinicio de Apache

systemctl restart apache2

# Instalar extensiones y reiniciar

apt-get install aspell graphviz php-ldap php-mysql php-pspell php-xml  php-soap php-xmlrpc php-gd php-intl php-zip php-curl php-mbstring

service apache2 restart