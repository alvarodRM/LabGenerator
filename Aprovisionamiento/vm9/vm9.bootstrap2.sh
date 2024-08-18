#!/bin/bash

cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
INICIO INSTALACION (2/2) VM9: bento/ubuntu-16.04 (WebServer-RedPreProduccion-RedProducion)              
EOF


# Obtener el valor de las variables de entorno.
DNI=$DNI
seleccion=$SELECCION
IP_VM10=$IP_VM10
BANDERA8=$BANDERA8


# Mostrar las variables de entorno.
echo "El valor del DNI es: $DNI"
echo "El valor de la IP de VM10 es: $DNI"
echo "El valor de la Bandera 8 es: $BANDERA8"


# Verificamos la correcta asignación de las variables de entorno principales.
if [ -z "$DNI" ]; then
    echo "La variable de entorno 'DNI' no está definida"
    exit 1
fi
if [ -z "$SELECCION" ]; then
    echo "La variable de entorno 'SELECCION' no está definida"
    exit 1
fi
if [ "$SELECCION" -eq 1 ]; then
    echo "El valor de la dificultad es: ($SELECCION) => FACIL"
fi
if [ "$SELECCION" -eq 2 ]; then
    echo "El valor de la dificultad es: ($SELECCION) => MEDIA"
fi
if [ "$SELECCION" -eq 3 ]; then
    echo "El valor de la dificultad es: ($SELECCION) => AVANZADA"
fi


# Convertir $resultado a hexadecimal y añadir espacios cada dos caracteres.
convertir_a_hexadecimal() {
    local input=$1
    local output=""
    for ((i=0; i<${#input}; i++)); do
        char=${input:i:1}
        hex=$(printf '%02X' "'$char")
        output+="$hex"
    done

    # Añadir un espacio cada dos caracteres
    echo "$output" | sed 's/../& /g' | sed 's/ $//'
}


# Convertir la IP y el código de la bandera en hexadecimal.
ip_vm10_hex=$(convertir_a_hexadecimal "$IP_VM10")
bandera8_hex=$(convertir_a_hexadecimal "$BANDERA8")


# Mostrar por pantalla los resultados en hexadecimal.
echo "El código secreto de la bandera 8 en hexadecimal es: $bandera8_hex"
echo "La IP de la VM10 es: $ip_vm10_hex"


# Creación de las carpetas secretas de vm9.
cat << "EOF"
Creación del Flag 8
EOF
sudo mkdir /home/AdminWeb/documentos /home/AdminWeb/contactos /home/AdminWeb/cumpleaños /home/AdminWeb/telefonos /home/AdminWeb/informacion /home/AdminWeb/secret
sudo mkdir /home/AdminIT/documentos /home/AdminIT/contactos /home/AdminIT/cumpleaños /home/AdminIT/telefonos /home/AdminIT/informacion
sudo mkdir /home/WordpressDev/desarrolladores /home/WordpressDev/backups /home/WordpressDev/test /home/WordpressDev/lists
sudo mkdir /home/Confidencial1 /home/Confidencial2 /home/Confidencial3 /home/Confidencial4 /home/Confidencial5 /home/Confidencial6 /home/Confidencial7 /home/Confidencial8 /home/Confidencial9 /home/Confidencial10
sudo mkdir /home/Joaquin17/documentos
sudo touch /home/AdminWeb/secret/flag8.txt
sudo touch /home/AdminWeb/secret/pistas.txt


# Creación del flag 8 en formato hexadecimal.
if [ "$SELECCION" -eq 2 ]; then
    echo "A1 46 65 6C 69 63 69 74 61 63 69 6F 6E 65 73 20 68 61 73 20 6F 62 74 65 6E 69 64 6F 20 6C 61 20 FA 6C 74 69 6D 61 20 62 61 6E 64 65 72 61 20 64 65 20 6C 61 20 64 69 66 69 63 75 6C 74 61 64 20 6D 65 64 69 61 20 64 65 6C 20 65 73 63 65 6E 61 72 69 6F 21" >> /home/AdminWeb/secret/flag8.txt
    echo "46 6C 61 67 73 20 63 6F 6D 70 6C 65 74 61 64 6F 73 20 34 2F 38 20 64 65 20 6C 61 20 64 69 66 69 63 75 6C 74 61 64 20 6D 65 64 69 61 20 64 65 6C 20 65 73 63 65 6E 61 72 69 6F 2E" >> /home/AdminWeb/secret/flag8.txt
fi
if [ "$SELECCION" -eq 3 ]; then
    echo "A1 46 65 6C 69 63 69 74 61 63 69 6F 6E 65 73 20 68 61 73 20 6F 62 74 65 6E 69 64 6F 20 6C 61 20 70 65 6E 75 6C 74 69 6D 61 20 62 61 6E 64 65 72 61 20 64 65 20 6C 61 20 64 69 66 69 63 75 6C 74 61 64 20 61 76 61 6E 7A 61 64 61 20 64 65 6C 20 65 73 63 65 6E 61 72 69 6F 21" >> /home/AdminWeb/secret/flag8.txt
    echo "53 6F 6C 6F 20 74 65 20 71 75 65 64 61 20 65 6E 63 6F 6E 74 72 61 72 20 75 6E 61 20 62 61 6E 64 65 72 61 20 6D 61 73" >> /home/AdminWeb/secret/flag8.txt
    echo "46 6C 61 67 73 20 63 6F 6D 70 6C 65 74 61 64 6F 73 20 38 2F 39 20 64 65 20 6C 61 20 64 69 66 69 63 75 6C 74 61 64 20 61 76 61 6E 7A 61 64 61 20 64 65 6C 20 65 73 63 65 6E 61 72 69 6F 2E" >> /home/AdminWeb/secret/flag8.txt
    echo "45 6C 20 73 69 67 75 69 65 6E 74 65 20 66 6C 61 67 20 6C 6F 20 65 6E 63 6F 6E 74 72 61 72 61 73 20 65 6E 20 6C 61 20 49 50 3A $ip_vm10_hex" >> /home/AdminWeb/secret/pistas.txt
    echo "41 71 75 69 20 65 6E 20 65 6C 20 6E 69 76 65 6C 20 64 69 66 69 63 69 6C 20 6E 6F 20 64 61 6D 6F 73 20 6D 75 63 68 61 73 20 70 69 73 74 61 73 20 6A 65 6A 65" >> /home/AdminWeb/secret/pistas.txt
    echo "41 75 6E 71 75 65 20 69 67 75 61 6C 20 70 75 65 64 65 73 20 65 6E 63 6F 6E 74 72 61 72 20 61 6C 67 75 6E 61 20 70 69 73 74 61 20 6D E1 73 20 65 6E 20 65 6C 20 73 69 73 74 65 6D 61 2C 20 71 75 65 20 6E 6F 20 68 61 79 61 73 20 65 6E 63 6F 6E 74 72 61 64 6F 2E" >> /home/AdminWeb/secret/pistas.txt
    echo "54 65 20 64 65 73 65 61 6D 6F 73 20 73 75 65 72 74 65 20 70 61 72 61 20 63 6F 6D 70 6C 65 74 61 72 20 65 6C 20 6C 61 62 6F 72 61 74 6F 72 69 6F 2E"  >> /home/AdminWeb/secret/pistas.txt
fi
echo "43 6F 64 69 67 6F 20 73 65 63 72 65 74 6F 20 66 6C 61 67 38 3A $bandera8_hex" >> /home/AdminWeb/secret/flag8.txt


# Creación de carpetas de pistas vacías para confundir al usuario.
echo "no hay nada, picaste ;)" >> /home/Confidencial1/passwords.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial1/facturas.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial1/importante.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial2/passwords.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial2/facturas.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial2/importante.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial3/passwords.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial3/facturas.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial3/importante.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial4/passwords.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial4/facturas.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial4/importante.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial5/passwords.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial5/facturas.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial5/importante.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial6/passwords.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial6/facturas.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial6/importante.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial7/passwords.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial7/facturas.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial7/importante.txt


# Pistas para encontrar la bandera 9, codificadas en cifrado César.
if [ "$SELECCION" -eq 3 ]; then
    echo "Vium: Zwuiv, Aczvium: Ziliumt, Vqksvium: IluqvLVA, Jqzbplig: 10/12/1991, kpqtl vium: Ivi, xmb vium: Zcnw, Kwuxivg vium: MBAQB cxu" >> /home/Confidencial8/datosSecretos.txt
    echo "Lqtnntzypd Czxly: apdnlc, dfcqplc, wl tyqzcxletnl" >> /home/Confidencial8/aficciones.txt
    echo "Od xowlpd edqghud vh frqvljxh wrpdqgr ho frqwuro gh od pdtxlqd YP10, frq xvxdulr urrw. Xwlolcd odv slvwdv idflolwdgdv dfhufd gho xvxdulr DgplqGQV." >> /home/Confidencial8/pistaFinal.txt
    echo "Dghpdv, sdud frpsohwdu ho oderudwrulr whqgudv txh vxshudu ho vljxlhqwh ghvdilr: Ghvduuroodu xq udqvrpzduh xwlolcdqgr od oleuhuld fulswrjudskb ihuqhw gh sbwkrq b hmhfxwduor hq od pdtxlqd YP10 sdud fliudu wrgrv orv ilfkhurv txh fxhojdq gh /krph/FrqilghqwldoLqirupdwlrq" >> /home/Confidencial8/pistaFinal.txt
fi


# Creación de carpetas de pistas vacías para confundir al usuario.
echo "no hay nada, picaste ;)" >> /home/Confidencial9/passwords.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial9/facturas.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial9/importante.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial10/passwords.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial10/facturas.txt
echo "no hay nada, picaste ;)" >> /home/Confidencial10/importante.txt


# Ocultamos algunos directorios de usuario, para que no aparezca al hacer un simple ls.
cat << "EOF"
Ocultamos algunos directorios de usuario, para que no aparezca al hacer un simple ls.
EOF
mv /home/AdminWeb /home/.AdminWeb
mv /home/AdminIT /home/.AdminIT
mv /home/WordpressDev /home/.WordpressDev
mv /home/.AdminWeb/secret /home/.AdminWeb/.secret


# Modificamos los permisos de las carpetas de usuarios, solo permitimos acceso al propietario.
cat << "EOF"
Modificamos los permisos de las carpetas de usuarios, solo permitimos acceso al propietario.
EOF
sudo chmod 700 /home/.AdminWeb
sudo chmod 700 /home/.AdminIT
sudo chmod 700 /home/.WordpressDev
sudo chmod 700 /home/vagrant


# Eliminamos todos los permisos de lectura y escritura de los directorios secretos.
cat << "EOF"
Eliminamos todos los permisos de lectura y escritura de los directorios secretos.
EOF
sudo chmod 100 /home/.AdminWeb/.secret
sudo chmod 100 /home/.AdminWeb/.secret/flag8.txt
sudo chmod 100 /home/.AdminWeb/.secret/pistas.txt


# Reiniciamos el servicio sshd.
cat << "EOF"  
Reiniciamos el servicio sshd.
EOF
sudo /usr/sbin/sshd


# INSTALACIÓN WORDPRES EN EL SERVIDOR -----------------------------------------------------------------------------


# Actualizar paquetes.
sudo apt-get update


# Instalar dependencias necesarias.
sudo apt-get install -y curl php-cli php-mysql mysql-server


# Descargar WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar


# Hacer que el archivo sea ejecutable.
chmod +x wp-cli.phar


# Mover WP-CLI a una ubicación accesible desde el PATH.
sudo mv wp-cli.phar /usr/local/bin/wp


# Verificar la instalación de WP-CLI.
wp --info


# Variables de configuración.
DB_NAME='wordpress_db'
DB_USER='root'
DB_PASSWORD='admin123'
DB_HOST='localhost'
SITE_URL='http://localhost:8084'
SITE_TITLE='Pruebas hacking wordpress'
ADMIN_USER='juan'
ADMIN_PASSWORD='admin'
ADMIN_EMAIL='adminweb@test.com'


# Crear base de datos.
mysql -u$DB_USER -p$DB_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"


# Cambiar al directorio de WordPress.
cd /var/www/html


# Descargar WordPress.
wp core download --path='/var/www/html' --allow-root


# Crear archivo wp-config.php.
wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=$DB_HOST --path='/var/www/html' --allow-root


# Instalar WordPress.
wp core install --url=$SITE_URL --title="$SITE_TITLE" --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --skip-email --path='/var/www/html' --allow-root


# Establecer los permisos correctos.
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html


# Texto para el post.
POST_TITLE='Secret Credentials'
POST_CONTENT='AdminWeb, Password: adminWeb00017, SSH'


# Crear el post.
wp post create --post_title="$POST_TITLE" --post_content="$POST_CONTENT" --allow-root


cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
FIN INSTALACION (2/2) VM9: bento/ubuntu-16.04 (WebServer-RedPreProduccion-RedProducion)                  
EOF
