#!/bin/bash

cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
INICIO INSTALACION (1/2) VM6: ubuntu/trusty64   (FTPServer-RedPreProduccion)          
EOF


# Obtener el valor de las variables de entorno.
DNI=$DNI
seleccion=$SELECCION
BANDERA5=$BANDERA5

VM6_FTP_PASS=$VM6_FTP_PASS
VM6_FTP_USER=$VM6_FTP_USER

# Mostrar las variables de entorno.
echo "El valor del DNI es: $DNI"
echo "El valor de la Bandera 5 es: $BANDERA5"
echo "FTP User: $VM6_FTP_USER"
echo "FTP password: $VM6_FTP_PASS"


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
sudo apt update -y
sudo apt upgrade -y


# Instalamos Ansible.
cat << "EOF"  
Instalamos Ansible.
EOF
sudo apt-get install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update -y
sudo apt-get install ansible -y


# Deshabilitamos host_key_checking en ansible.cfg
cat << "EOF"  
Deshabilitamos host_key_checking en ansible.cfg
EOF
sudo sed -i 's/#host_key_checking = False/host_key_checking = False/' /etc/ansible/ansible.cfg


cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
FIN INSTALACION (1/2) VM6: ubuntu/trusty64   (FTPServer-RedPreProduccion)           
EOF


