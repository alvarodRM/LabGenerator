#!/bin/bash

cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
INICIO INSTALACION VM8: Ubuntu/Metasploitable2 (Client4-RedPreProduccion)             
EOF


# Obtener el valor de las variables de entorno.
seleccion=$SELECCION
DNI=$DNI
IP_VM1=$IP_VM1
IP_VM5_1=$IP_VM5_1
IP_VM5_2=$IP_VM5_2
IP_VM8=$IP_VM8
IP_VM9_1=$IP_VM9_1
BANDERA7=$BANDERA7


# Mostrar las variables de entorno.
echo "IP VM8: $IP_VM8"
echo "El valor del DNI es: $DNI"
echo "El valor de la Bandera 7 es: $BANDERA7"


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


# Actualizamos paquetes.
cat << "EOF"  
Actualizamos paquetes.
EOF
sudo apt-get update -y
sudo apt-get upgrade -y


# Creamos el usuario JuanPe94 con contraseña cifrada hash sha512 en /etc/shadow.
cat << "EOF"
Creamos el usuario JuanPe94 con contraseña cifrada hash sha512 en /etc/shadow
EOF
sudo addgroup administrators
sudo useradd -u 2087 -c "Cuenta ULTRA secreta, bandera" -m -s /bin/bash -G administrators -p $(echo "Juan123xx" | openssl passwd -1 -stdin) JuanPe94
sudo echo "JuanPe94	ALL=(ALL) ALL" >> /etc/sudoers


#Creamos el usuario LuisAlbert con contraseña cifrada en /etc/shadow.
cat << "EOF"
Creamos el usuario LuisAlbert con contraseña cifrada en /etc/shadow
EOF
sudo useradd -u 2088 -m -s /bin/bash -p $(echo "Luisito" | openssl passwd -1 -stdin) LuisAlbert


# Creación de las carpetas secretas.
cat << "EOF"
Creación del Flag 7
EOF
sudo mkdir /home/JuanPe94/documentos /home/JuanPe94/contactos /home/JuanPe94/cumpleaños /home/JuanPe94/telefonos /home/JuanPe94/informacion
sudo mkdir /home/LuisAlbert/documentos /home/LuisAlbert/contactos /home/LuisAlbert/cumpleaños /home/LuisAlbert/telefonos /home/LuisAlbert/informacion
sudo mkdir /home/JuanPe94/secret
sudo touch /home/JuanPe94/secret/flag7.txt
sudo touch /home/JuanPe94/secret/pista.txt


# Creación del Flag 7 en formato binario.
echo "11000010 10100001 11000010 10100001 11000010 10100001 01000101 01001110 01001000 01001111 01010010 01000001 01000010 01010101 01000101 01001110 01000001 00100000 01001000 01000001 01010011 00100000 01000101 01001110 01000011 01001111 01001110 01010100 01010010 01000001 01000100 01001111 00100000 01000101 01101100 00100000 01010011 11000011 10001001 01010000 01010100 01001001 01001101 01001111 00100000 01000110 01001100 01000001 01000111 00100001 00100001 00100001" >> /home/JuanPe94/secret/flag7.txt
if [ "$SELECCION" -eq 2 ]; then
    echo "01000110 01101100 01100001 01100111 01110011 00100000 01100011 01101111 01101101 01110000 01101100 01100101 01110100 01100001 01100100 01101111 01110011 00100000 00110111 00101111 00111000 00100000 01100100 01100101 00100000 01101100 01100001 00100000 01100100 01101001 01100110 01101001 01100011 01110101 01101100 01110100 01100001 01100100 01101111 00100000 01101101 01100101 01100100 01101001 01100001 00100000 01100100 01100101 01101100 00100000 01100101 01110011 01100011 01100101 01101110 01100001 01110010 01101001 01101111" >> /home/JuanPe94/secret/flag7.txt
fi
if [ "$SELECCION" -eq 3 ]; then
    echo "01000110 01101100 01100001 01100111 01110011 00100000 01100011 01101111 01101101 01110000 01101100 01100101 01110100 01100001 01100100 01101111 01110011 00100000 00110111 00101111 00111001 00100000 01100100 01100101 00100000 01101100 01100001 00100000 01100100 01101001 01100110 01101001 01100011 01110101 01101100 01110100 01100001 01100100 01101111 00100000 01100001 01110110 01100001 01101110 01111010 01100001 01100100 01100001 00100000 01100100 01100101 01101100 00100000 01100101 01110011 01100011 01100101 01101110 01100001 01110010 01101001 01101111" >> /home/JuanPe94/secret/flag7.txt
fi
echo "01000011 11000011 10110011 01100100 01101001 01100111 01101111 00100000 01110011 01100101 01100011 01110010 01100101 01110100 01101111 00100000 01100100 01100101 01101100 00100000 01000110 01001100 01000001 01000111 00110111 00111010 $BANDERA7" >> /home/JuanPe94/secret/flag7.txt


# Creación de las pistas de vm8 en formato binario.
echo "01000101 01101100 00100000 01110011 01101001 01100111 01110101 01110010 01100101 01101110 01110100 01100101 00100000 01100110 01101100 01100001 01100111 00100000 01101100 01101111 00100000 01100101 01101110 01100011 01101111 01101110 01110100 01110010 01100001 01110010 01101001 01101111 01110011 00100000 01100101 01101110 00100000 01101100 01100001 00100000 01001001 01010000 00111010 $IP_VM9_1" >> /home/JuanPe94/secret/pista.txt
echo "01000100 01101001 01100011 01101000 01100001 00100000 01101101 11000011 10100001 01110001 01110101 01101001 01101110 01100001 00100000 01110011 01100101 00100000 01100011 01101111 01110010 01110010 01100101 01110011 01110000 01101111 01101110 01100100 01100101 00100000 01100001 00100000 01110101 01101110 00100000 01100101 01110001 01110101 01101001 01110000 01101111 00100000 01100100 01100101 00100000 01110101 01110011 01110101 01100001 01110010 01101001 01101111 00101110" >> /home/JuanPe94/secret/pista.txt
echo "01010000 01110010 01100101 01110011 01110100 01100001 00100000 01100001 01110100 01100101 01101110 01100011 01101001 11000011 10110011 01101110 00100000 01100001 01101100 00100000 01110011 01100101 01110010 01110110 01101001 01100011 01101001 01101111 00100000 01110111 01100101 01100010 00100000 01110001 01110101 01100101 00100000 01101111 01100110 01110010 01100101 01100011 01100101 00101100 00100000 01101001 01101110 01110100 01100101 01101110 01110100 01100001 00100000 01100011 01101111 01101110 01110011 01100101 01100111 01110101 01101001 01110010 00100000 01110101 01101110 00100000 01110101 01110011 01110101 01100001 01110010 01101001 01101111 00100000 01100001 01100100 01101101 01101001 01101110 01101001 01110011 01110100 01110010 01100001 01100100 01101111 01110010 00100000 01100100 01100101 01101100 00100000 01110011 01100101 01110010 01110110 01101001 01100011 01101001 01101111 00101110 00001101 00001010" >> /home/JuanPe94/secret/pista.txt
echo "01010111 01110000 01110011 01100011 01100001 01101110 00100000 01110001 01110101 01101001 01111010 11000011 10100001 01110011 00100000 01110000 01110101 01100101 01100100 01100001 00100000 01100001 01111001 01110101 01100100 01100001 01110010 01110100 01100101 00100000 00111011 00101001" >> /home/JuanPe94/secret/pista.txt


# Ocultamos algunos directorios de usuario, para que no aparezca al hacer un simple ls.
cat << "EOF"
Ocultamos algunos directorios de usuario, para que no aparezca al hacer un simple ls.
EOF
mv /home/JuanPe94 /home/.JuanPe94
mv /home/.JuanPe94/secret /home/.JuanPe94/.secret


# Modificamos los permisos de las carpetas de usuarios, solo permitimos acceso al propietario.
cat << "EOF"
Modificamos los permisos de las carpetas de usuarios, solo permitimos acceso al propietario.
EOF
sudo chmod 700 /home/.JuanPe94
sudo chmod 700 /home/LuisAlbert


# Eliminamos todos los permisos de lectura y escritura de los directorios secretos.
cat << "EOF"
Eliminamos todos los permisos de lectura y escritura de los directorios secretos.
EOF
sudo chmod 100 /home/.JuanPe94/.secret
sudo chmod 100 /home/.JuanPe94/.secret/flag7.txt
sudo chmod 100 /home/.JuanPe94/.secret/pista.txt


# Eliminamos carpetas de usuarios que venían por defecto y no queremos en nuestro escenario.
cat << "EOF"  
Eliminamos carpetas de usuarios que venían por defecto y no queremos en nuestro escenario.
EOF
sudo rm -rf /home/msfadmin
sudo rm -rf /home/user
sudo rm -rf /home/service
sudo rm -rf /home/ftp


# Reiniciamos el servicio ssh.
cat << "EOF"
Reiniciamos el servicio ssh
EOF
sudo /usr/sbin/sshd


# Filtramos los puertos con vulnerabilidades que no queremos exponer al usuario del escenario.
cat << "EOF"  
Filtramos los puertos con vulnerabilidades que no queremos exponer al usuario del escenario.
EOF
sudo iptables -A INPUT -p tcp --dport 21 -j DROP
sudo iptables -A INPUT -p tcp --dport 23 -j DROP
sudo iptables -A INPUT -p tcp --dport 25 -j DROP
sudo iptables -A INPUT -p tcp --dport 53 -j DROP
sudo iptables -A INPUT -p tcp --dport 80 -j DROP
sudo iptables -A INPUT -p tcp --dport 139 -j DROP
sudo iptables -A INPUT -p tcp --dport 445 -j DROP
sudo iptables -A INPUT -p tcp --dport 512 -j DROP
sudo iptables -A INPUT -p tcp --dport 513 -j DROP
sudo iptables -A INPUT -p tcp --dport 514 -j DROP
sudo iptables -A INPUT -p tcp --dport 1099 -j DROP
sudo iptables -A INPUT -p tcp --dport 1524 -j DROP
sudo iptables -A INPUT -p tcp --dport 2049 -j DROP
sudo iptables -A INPUT -p tcp --dport 2121 -j DROP
sudo iptables -A INPUT -p tcp --dport 3306 -j DROP
sudo iptables -A INPUT -p tcp --dport 5432 -j DROP
sudo iptables -A INPUT -p tcp --dport 5900 -j DROP
sudo iptables -A INPUT -p tcp --dport 6000 -j DROP
sudo iptables -A INPUT -p tcp --dport 8009 -j DROP
sudo iptables -A INPUT -p tcp --dport 8180 -j DROP


# Bloqueamos los puertos con vulnerabilidades para la IP atacante.
cat << "EOF"  
# Bloqueamos los puertos con vulnerabilidades para la IP atacante.
EOF
sudo iptables -A OUTPUT -p tcp --dport 21 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 23 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 25 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 53 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 80 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 139 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 445 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 512 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 513 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 514 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 1099 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 1524 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 2049 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 2121 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 3306 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 5432 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 5900 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 6000 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 8009 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 8180 -d $IP_VM1 -j DROP


# Bloqueamos los puertos con vulnerabilidades para vm5.
cat << "EOF"  
# Bloqueamos los puertos con vulnerabilidades para vm5.
EOF
sudo iptables -A OUTPUT -p tcp --dport 21 -d $IP_VM5_1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 23 -d $IP_VM5_1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 25 -d $IP_VM5_1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 53 -d $IP_VM5_1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 80 -d $IP_VM5_1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 139 -d $IP_VM5_1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 445 -d $IP_VM5_1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 512 -d $IP_VM5_1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 513 -d $IP_VM5_1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 514 -d $IP_VM5_1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 1099 -d $IP_VM5_1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 1524 -d $IP_VM5_1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 2049 -d $IP_VM5_1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 2121 -d $IP_VM5_1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 3306 -d $IP_VM5_1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 5432 -d $IP_VM5_1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 5900 -d $IP_VM5_1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 6000 -d $IP_VM5_1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 8009 -d $IP_VM5_1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 8180 -d $IP_VM5_1 -j DROP

sudo iptables -A OUTPUT -p tcp --dport 21 -d $IP_VM5_2 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 23 -d $IP_VM5_2 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 25 -d $IP_VM5_2 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 53 -d $IP_VM5_2 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 80 -d $IP_VM5_2 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 139 -d $IP_VM5_2 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 445 -d $IP_VM5_2 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 512 -d $IP_VM5_2 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 513 -d $IP_VM5_2 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 514 -d $IP_VM5_2 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 1099 -d $IP_VM5_2 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 1524 -d $IP_VM5_2 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 2049 -d $IP_VM5_2 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 2121 -d $IP_VM5_2 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 3306 -d $IP_VM5_2 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 5432 -d $IP_VM5_2 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 5900 -d $IP_VM5_2 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 6000 -d $IP_VM5_2 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 8009 -d $IP_VM5_2 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 8180 -d $IP_VM5_2 -j DROP


cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
FIN INSTALACION VM8: Ubuntu/Metasploitable2 (Client4-RedPreProduccion)            
EOF
