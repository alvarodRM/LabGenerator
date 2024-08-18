#!/bin/bash

cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
INICIO INSTALACION VM4: Ubuntu/Metasploitable2 (Client1-RedPruebas)           
EOF


# Obtener el valor de las variables de entorno.
DNI=$DNI
seleccion=$SELECCION
IP_VM1=$IP_VM1
IP_VM4=$IP_VM4
IP_VM5=$IP_VM5
VM4_USERNAME1=$VM4_USERNAME1
VM4_PASSWORD1=$VM4_PASSWORD1
VM4_USERNAME2=$VM4_USERNAME2
VM5_USERNAME2=$VM5_USERNAME2
BANDERA3=$BANDERA3


# Mostrar las variables de entorno.
echo "El valor del DNI es: $DNI"
echo "El valor de la Bandera 3 es: $BANDERA3"
echo "Usuario1: $VM4_USERNAME1"
echo "Password1: $VM4_PASSWORD1"
echo "Usuario2: $VM4_USERNAME2"


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


# Creamos el usuario $VM4_USERNAME1 con contraseña cifrada hash sha512 en /etc/shadow.
cat << "EOF"  
Creamos el usuario $VM4_USERNAME1 con contraseña cifrada hash sha512 en /etc/shadow.
EOF
sudo addgroup administrators
sudo useradd -c "Bandera ;)" -m -s /bin/bash -G administrators -p "$(echo "$VM4_PASSWORD1" | openssl passwd -1 -stdin)" "$VM4_USERNAME1"
sudo echo "$VM4_USERNAME1	ALL=(ALL) ALL" >> /etc/sudoers


# Creamos el usuario $VM4_USERNAME2 con contraseña cifrada en /etc/shadow.
cat << "EOF"  
Creamos el usuario $VM4_USERNAME2 con contraseña cifrada en /etc/shadow.
EOF
sudo useradd -m -s /bin/bash -p $(echo "NaChO1991" | openssl passwd -1 -stdin) "$VM4_USERNAME2"


# Modificamos /etc/ssh/sshd_config.
cat << "EOF"  
Modificamos /etc/ssh/sshd_config.
EOF
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo /usr/sbin/sshd


hide_secret_folder() {
    local dni="$1"
    local flag="$2"
    local selection="$3"

    # Concatenar los tres parámetros.
    local concatenated="$dni$flag$selection"

    # Obtener el hash SHA256 de la concatenación.
    local hash=$(echo -n "$concatenated" | sha256sum)

    # Extraer el primer número del hash (0 al 9).
    local num=$(echo "$hash" | grep -oE '[0-9]' | head -n 1)

    # Determina la ruta de destino según el número calculado.
    case $num in
        0) destination="/var/www/.Secret" ;;
        1) destination="/var/lib/.Secret" ;;
        2) destination="/etc/release/.Secret" ;;
        3) destination="/usr/local/sbin/.Secret" ;;
        4) destination="/usr/games/.Secret" ;;
        5) destination="/usr/share/.Secret" ;;
        6) destination="/var/log/.Secret" ;;
        7) destination="/tmp/windows/.Secret" ;;
        8) destination="/opt/test/.Secret" ;;
        9) destination="/tmp/prueba/.Secret" ;;
        *) destination="/tmp/systemr/.Secret" ;;
    esac

    echo "$destination"
    mkdir -p "$destination"
    mkdir /home/$VM4_USERNAME2/Pista
    mkdir /home/$VM4_USERNAME1/Pista
    mkdir /home/$VM4_USERNAME1/settings /home/$VM4_USERNAME1/configurations /home/$VM4_USERNAME1/holaAtodos

    echo "Esta bandera está escondida mejor que las banderas anteriores, tendrás que rebuscar bien entre el sistema de ficheros." >> /home/$VM4_USERNAME2/Pista/pista1.txt
    echo "La bandera está contenida en una carpeta llamada /Secret en algún punto del sistema de ficheros." >> /home/$VM4_USERNAME2/Pista/.pista2.txt
    echo "Esto es una trampa, ya dimos muchas pistas... ;) suerte." >> /.pistaImportante.txt
    echo "Hay herramientas de terminal que permiten buscar nombres concretos de carpetas dentro de un sistema de ficheros. Recomendamos localizar la bandera así." >> /home/$VM4_USERNAME1/Pista/pista1.txt
    echo "La carpeta /Secret que contiene la bandera flag.txt está oculta (utilizar ls -la) y con permisos de acceso mínimos (requiere usar chmod para cambiarlos)." >> /home/$VM4_USERNAME1/Pista/.pista2.txt

    if [ "$seleccion" -eq 1 ]; then
        echo "¡¡¡ENHORABUENA, ya solo te queda una bandera para superar la dificultad fácil del escenario!!!" >> "$destination/.flag3.txt"
        echo "Flags completados 3/4 de la dificultad fácil del escenario." >> "$destination/.flag3.txt"
        echo "Código secreto del FLAG3: $BANDERA3" >> "$destination/.flag3.txt"
    fi

    if [ "$seleccion" -eq 2 ]; then
        echo "¡¡¡ENHORABUENA, has encontrado la tercera bandera de la dificultad media del escenario!!!" >> "$destination/.flag3.txt"
        echo "Flags completados 3/8 de la dificultad media del escenario." >> "$destination/.flag3.txt"
        echo "Código secreto del FLAG3: $BANDERA3" >> "$destination/.flag3.txt"
    fi
    
    if [ "$seleccion" -eq 3 ]; then
        echo "¡¡¡ENHORABUENA, has encontrado la tercera bandera de la dificultad avanzada del escenario!!!" >> "$destination/.flag3.txt"
        echo "Flags completados 3/9 de la dificultad avanzada del escenario." >> "$destination/.flag3.txt"
        echo "Código secreto del FLAG3: $BANDERA3" >> "$destination/.flag3.txt"
    fi

    echo "El siguiente flag lo encontrarás en la IP: $IP_VM5" >> "$destination/.pistas.txt"
    echo "Dicha máquina se corresponde a un endpoint (equipo local de usuario) que tiene conectividad con los servidores del escenario." >> "$destination/.pistas.txt"
    echo "Pista: Un usuario del sistema es $VM5_USERNAME2" >> "$destination/.pistas.txt"

    # Establece los permisos mínimos para la carpeta oculta.
    sudo chmod 100 "$destination/.flag3.txt"
    sudo chmod 100 "$destination/.pistas.txt"
    sudo chmod 100 "$destination"
    sudo chmod 100 /home/$VM4_USERNAME2/Pista/pista1.txt
    sudo chmod 100 /home/$VM4_USERNAME2/Pista/.pista2.txt
    sudo chmod 100 /home/$VM4_USERNAME1/Pista/pista1.txt
    sudo chmod 100 /home/$VM4_USERNAME1/Pista/.pista2.txt
    sudo chmod 100 /.pistaImportante.txt

    echo "La carpeta /Secret se ha ocultado en la ruta: $destination y se han establecido permisos mínimos."
}


solucion=$(hide_secret_folder "$DNI" "$num_bandera" "$SELECCION")
echo "$solucion"


# Modificamos los permisos de las carpetas de usuarios, solo permitimos acceso al propietario.
cat << "EOF"
Modificamos los permisos de las carpetas de usuarios, solo permitimos acceso al propietario.
EOF
sudo chmod 700 /home/$VM4_USERNAME1
sudo chmod 700 /home/$VM4_USERNAME2
sudo chmod 700 /home/vagrant


# Eliminamos carpetas de usuarios que venían por defecto y no queremos en nuestro escenario.
cat << "EOF"  
Eliminamos carpetas de usuarios que venían por defecto y no queremos en nuestro escenario.
EOF
sudo rm -rf /home/user
sudo rm -rf /home/service
sudo rm -rf /home/msfadmin
sudo rm -rf /home/ftp


# Reiniciamos el servicio sshd.
cat << "EOF"  
Reiniciamos el servicio sshd.
EOF
sudo /usr/sbin/sshd


# Filtramos los puertos con vulnerabilidades que no queremos exponer al usuario del escenario.
cat << "EOF"  
Filtramos los puertos con vulnerabilidades que no queremos exponer al usuario del escenario.
EOF
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
sudo iptables -A INPUT -p tcp --dport 3632 -j DROP
sudo iptables -A INPUT -p tcp --dport 5432 -j DROP
sudo iptables -A INPUT -p tcp --dport 5900 -j DROP
sudo iptables -A INPUT -p tcp --dport 6000 -j DROP
sudo iptables -A INPUT -p tcp --dport 6667 -j DROP
sudo iptables -A INPUT -p tcp --dport 6697 -j DROP
sudo iptables -A INPUT -p tcp --dport 8009 -j DROP
sudo iptables -A INPUT -p tcp --dport 8180 -j DROP
sudo iptables -A INPUT -p tcp --dport 8787 -j DROP
sudo iptables -A INPUT -p tcp --dport 44796 -j DROP
sudo iptables -A INPUT -p tcp --dport 56305 -j DROP
sudo iptables -A INPUT -p tcp --dport 58360 -j DROP
sudo iptables -A INPUT -p tcp --dport 60342 -j DROP


# Bloqueamos los puertos con vulnerabilidades para la IP atacante.
cat << "EOF"  
# Bloqueamos los puertos con vulnerabilidades para la IP atacante.
EOF
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
sudo iptables -A OUTPUT -p tcp --dport 3632 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 5432 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 5900 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 6000 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 6667 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 6697 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 8009 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 8180 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 44796 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 56305 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 58360 -d $IP_VM1 -j DROP
sudo iptables -A OUTPUT -p tcp --dport 60342 -d $IP_VM1 -j DROP


cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
FIN INSTALACION VM4: Ubuntu/Metasploitable2 (Client1-RedPruebas)              
EOF


