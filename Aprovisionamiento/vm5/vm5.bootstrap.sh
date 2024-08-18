#!/bin/bash

cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
INICIO INSTALACION (1/2) VM5:  (Client2-RedPruebas-RedPreProduccion)             
EOF


# Obtener el valor de las variables de entorno.
DNI=$DNI
seleccion=$SELECCION
IP_VM5=$IP_VM5
VM5_USERNAME1=$VM5_USERNAME1
VM5_PASWORD1=$VM5_PASSWORD1
VM5_USERNAME2=$VM5_USERNAME2
VM5_PASWORD2=$VM5_PASSWORD2
BANDERA4=$BANDERA4


# Mostrar las variables de entorno.
echo "El valor del DNI es: $DNI"
echo "El valor de la Bandera 4 es: $BANDERA4"
echo "Usuario1: $VM5_USERNAME1"
echo "Password1: $VM5_PASSWORD1"
echo "Usuario2: $VM5_USERNAME2"
echo "Password2: $VM5_PASSWORD2"


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
Actualizamos paquetes
EOF
sudo apt-get update -y


# Creamos el usuario $VM5_USERNAME1 con contraseña cifrada hash sha512 en /etc/shadow.
cat << "EOF"
Creamos el usuario $VM5_USERNAME1 con contraseña cifrada hash sha512 en /etc/shadow
EOF
sudo addgroup administrators
sudo useradd -u 1220 -c "$VM5_USERNAME1 Account" -m -s /bin/bash -G administrators -p "$(echo "$VM5_PASSWORD1" | openssl passwd -1 -stdin)" "$VM5_USERNAME1"
sudo echo "$VM5_USERNAME1	ALL=(ALL) ALL" >> /etc/sudoers


# Creamos el usuario $VM5_USERNAME2 con contraseña cifrada hash sha512 en /etc/shadow.
cat << "EOF"
Creamos el usuario $VM5_USERNAME2 con contraseña cifrada hash sha512 en /etc/shadow
EOF
sudo useradd -u 1221 -c "$VM5_USERNAME2 Account" -m -s /bin/bash -G administrators -p "$(echo "$VM5_PASSWORD2" | openssl passwd -1 -stdin)" "$VM5_USERNAME2"


# Instalamos Ansible.
cat << "EOF"
Instalamos Ansible
EOF
sudo apt-get install ansible -y
ansible --version


cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
FIN INSTALACION (1/2) VM5: ubuntu/trusty64  (Client2-RedPruebas-RedPreProduccion)            
EOF


