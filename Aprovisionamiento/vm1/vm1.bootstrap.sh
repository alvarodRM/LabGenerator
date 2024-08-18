#!/bin/bash

cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
INICIO INSTALACION VM1: KaliLinux (ATACANTE)          
EOF


# Obtener el valor del DNI de la variable de entorno.
DNI=$DNI
SELECCION=$SELECCION
VM1_USERNAME=$VM1_USERNAME
VM1_PASSWORD=$VM1_PASSWORD
IP_VM2=$IP_VM2


# Usar la variable de entorno.
echo "El valor del DNI es: $DNI"
echo "Usuario1: $VM1_USERNAME"
echo "Password1: $VM1_PASSWORD"


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


# Creamos el usuario de VM1 con contraseña cifrada hash sha512 en /etc/shadow.
cat << "EOF"
Creamos el usuario de VM1 con contraseña cifrada hash sha512 en /etc/shadow
EOF
sudo addgroup administrators
sudo useradd -u 1220 -c "Attack Anonymous" -m -s /bin/bash -G administrators -p $(echo "$VM1_PASSWORD" | openssl passwd -1 -stdin) $VM1_USERNAME
echo "$VM1_USERNAME ALL=(ALL) ALL" | sudo tee -a /etc/sudoers


# Crear el directorio Desktop si no existe y los archivos de pistas en el escritorio del usuario Attack.
cat << "EOF"
Creamos el directorio Desktop y los archivos de pistas en el escritorio del usuario Attack
EOF
sudo -u $VM1_USERNAME bash -c "mkdir -p /home/$VM1_USERNAME/Desktop && touch /home/$VM1_USERNAME/Desktop/pista1.txt /home/$VM1_USERNAME/Desktop/pista2.txt"


# Crear los archivos de pistas en el escritorio del usuario de VM1.
cat << "EOF"
Creamos los archivos de pistas en el escritorio del usuario de VM1
EOF
echo "La primera fase antes de comenzar un ataque es la recopilación de información y el escaneo de la red." >> "/home/$VM1_USERNAME/Desktop/pista1.txt"
echo "Recomendamos empezar escaneando la red con nmap para tratar de localizar la IP de la VM2 $IP_VM2, identifica también sus puertos abiertos e investigalos." >> "/home/$VM1_USERNAME/Desktop/pista1.txt"
echo "Otras herramientas útiles para el escaeno de red son: route, ping, ifconfig." >> "/home/$VM1_USERNAME/Desktop/pista2.txt"
echo "Localiza puertos abiertos en VM2 y explora que servicios corren en dichos puertos." >> "/home/$VM1_USERNAME/Desktop/pista2.txt"
echo "Investiga información en internet acerca de dichos servicios, contraseñas comunes de acceso a dichos servicios, etc." >> "/home/$VM1_USERNAME/Desktop/pista2.txt"


# Instalamos Ansible.
cat << "EOF"
Instalamos Ansible
EOF
sudo apt-get install ansible -y < /dev/null
ansible --version


cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
FIN INSTALACION VM1: KaliLinux (ATACANTE)         
EOF