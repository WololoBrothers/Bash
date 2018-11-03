# Domain setup

# Conseguir IP actual

current_ip="$(hostname -I | cut -d" " -f1)"

# Input del usuario: dominio a agregar

echo Saludos, humano. Ingrese el nombre del dominio:
read domain_name

# Crear directorio con nombre de dominio

mkdir -p /var/www/$domain_name/public_html

# Hacer que el dueño y el grupo sean el usuario del web server
# y otorgarles permisos de lectura y ejecución a todos, y además escritura al dueño

chown -R www-data:www-data /var/www/$domain_name/
chmod -R 755 /var/www/$domain_name

# Crear archivo de prueba

touch /var/www/$domain_name/public_html/index.html

echo "<html>
 <head>
   <title>You a smart motherfucker</title>
 </head>
 <body>
   <h1>CHECK OUT THE BIG BRAIN ON BRETT</h1>
 </body>
</html>">/var/www/$domain_name/public_html/index.html

# Duplicar VH existente y sobreescribirlo con uno parametrizado

cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/$domain_name.conf

echo "<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        #ServerName www.example.com

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/$domain_name/public_html
        ServerName $current_ip
        ServerAlias $current_ip

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet">/etc/apache2/sites-available/$domain_name.conf

# Agregar el nuevo sitio a los sitios habilitados

a2ensite $domain_name.conf

# Desactivar el VH por defecto

a2dissite 000-default.conf

# Reiniciar Apache para impactar cambios

systemctl restart apache2

# Aviso de que hasta aquí todo va OK

echo "Se han creado las carpetas y el virtual host para $domain_name. Acceda a $current_ip desde el navegador para ver la página de prueba." 