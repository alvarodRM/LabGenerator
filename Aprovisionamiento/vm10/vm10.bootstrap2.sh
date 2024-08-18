#!/bin/bash

cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
INICIO INSTALACION (2/2) VM10: bento/ubuntu-16.04 (DNSServer-RedProduccion)              
EOF


# Obtener el valor del DNI de la variable de entorno
DNI=$DNI
seleccion=$SELECCION
BANDERA9=$BANDERA9
IP_VM10=$IP_VM10


# Usar la variable de entorno
echo "El valor del DNI es: $DNI"
echo "La IP de VM10 es: $IP_VM10"
echo "El valor de la Bandera 9 es: $BANDERA9"


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


# Creamos las carpetas confidenciales que tendrán que ser encriptadas por el ransomware.
cat << "EOF"
# Creamos las carpetas confidenciales que tendrán que ser encriptadas por el ransomware.
EOF
sudo mkdir /home/ConfidentialInformation
sudo echo "Usuarios de la empresa:" >> /home/ConfidentialInformation/usuarios.txt
sudo echo "Nuria, Pepe19, UsuarioPruebas, Nacho91, Juan112, Paula96, FTPDev, DomainDev, Clara1972, JuanPe94, WordpressDev, Joaquin17, AnaLopez28, LuisAlbert" >> /home/ConfidentialInformation/usuarios.txt
sudo echo "Administradores de sistemas:" >> /home/ConfidentialInformation/admins.txt
sudo echo "AdminPruebas, AdminIT, AdminFTP, Juan112, Nuria, AdminDNS, AdminWeb" >> /home/ConfidentialInformation/admins.txt
sudo echo "Mails:" >> /home/ConfidentialInformation/mails.txt
sudo echo "nuria@pruebas.com, nacho91@pruebas.com, juanete@pruebas.com, paula96@pruebas.com, clara@pruebas.com, joaco@pruebas.com" >> /home/ConfidentialInformation/mails.txt
sudo echo "Salarios usuarios empresa: " >> /home/ConfidentialInformation/salarios.txt
sudo echo "Pepe19: 45000, Nacho91: 49000, Nuria: 50000, Paula96: 23000, clara1972: 32000" >> /home/ConfidentialInformation/salarios.txt
sudo echo "Pepe19: 1169, Nuria: 101010, Paula96: Paula1964" >> /home/ConfidentialInformation/passwords.txt


# Editamos el fichero /etc/network/interfaces.
cat << "EOF"
Editamos el fichero /etc/network/interfaces.
EOF
sudo echo "       dns-nameservers $IP_VM10" >> /etc/network/interfaces
sudo echo "       dns-search ctfprolab.es" >> /etc/network/interfaces


# Reiniciamos el servicio de networking.
cat << "EOF"
Reiniciamos el servicio de networking.
EOF
sudo service networking reload -y


# Editamos el fichero /etc/nsswitch.conf.
cat << "EOF"
Editamos el fichero /etc/nsswitch.conf
EOF
sudo sed -i 's/hosts:          files dns/hosts:          dns files/' /etc/nsswitch.conf


# Reiniciamos el servicio de bind.
cat << "EOF"
Editamos el fichero /etc/nsswitch.conf
EOF
sudo service bind9 restart -y


cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
FIN INSTALACION (2/2) VM10: bento/ubuntu-16.04 (DNSServer-RedProduccion)              
EOF