#!/bin/bash

cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
INICIO INSTALACION (1/2) VM10: bento/ubuntu-16.04  (DNSServer-RedProduccion)                      
EOF


# Obtener el valor de las variables de entorno.
DNI=$DNI
seleccion=$SELECCION
BANDERA9=$BANDERA9


# Usar la variable de entorno.
echo "El valor del DNI es: $DNI"
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
apt-get update -y
sudo apt-get install ansible -y


# Instalamos sshpass.
cat << "EOF"
Instalamos sshpass.
EOF
sudo apt-get install sshpass -y


# Deshabilitamos host_key_checking en ansible.cfg.
cat << "EOF"
Deshabilitamos host_key_checking en ansible.cfg
EOF
sudo sed -i 's/#host_key_checking = False/host_key_checking = False/' /etc/ansible/ansible.cfg


# Rechazamos los warnings informativos de ansible.
cat << "EOF"
Rechazamos los warnings informativos de ansible.
EOF
sudo sed -i 'deprecation_warnings = False' /etc/ansible/ansible.cfg


# Aumentamos el tiempo de timeout en ansible.cfg
cat << "EOF"
Aumentamos el tiempo de timeout en ansible.cfg
EOF
sudo echo "timeout=30" >> /etc/ansible/ansible.cfg


cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
FIN INSTALACION (1/2) VM10: bento/ubuntu-16.04  (DNSServer-RedProduccion)                          
EOF