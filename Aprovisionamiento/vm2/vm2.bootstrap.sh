#!/bin/bash

cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
INICIO INSTALACION VM2: ubuntu/precise64 (WebServer1-RedPruebas-DVWA)         
EOF


# Obtener el valor de las variables de entorno.
DNI=$DNI
seleccion=$SELECCION
IP_VM3=$IP_VM3
IP_VM4=$IP_VM4
VM3_PASSWORD1=$VM3_PASSWORD1
BANDERA1=$BANDERA1


# Mostrar las variables de entorno.
echo "El valor del DNI es: $DNI"
echo "El valor de la Bandera 1 es: $BANDERA1"


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


# Creamos el usuario AdminPruebas con contraseña cifrada hash sha512 en /etc/shadow.
cat << "EOF"
Creamos el usuario AdminPruebas con contraseña cifrada hash sha512 en /etc/shadow
EOF
sudo addgroup administrators
sudo useradd -u 2087 -c "Cuenta ULTRA secreta" -m -s /bin/bash -G administrators -p $(echo "AdMinistRat0r1" | openssl passwd -1 -stdin) AdminPruebas
sudo echo "AdminPruebas	ALL=(ALL) ALL" >> /etc/sudoers


#Creamos el usuario UsuarioPruebas con contraseña cifrada en /etc/shadow.
cat << "EOF"
Creamos el usuario UsuarioPruebas con contraseña cifrada en /etc/shadow
EOF
sudo useradd -u 2088 -m -s /bin/bash -p $(echo "USeRPruEBas00" | openssl passwd -1 -stdin) UsuarioPruebas


# Modificamos /etc/ssh/sshd_config.
cat << "EOF"
Modificamos /etc/ssh/sshd_config
EOF
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config


# Reiniciamos el servicio ssh.
cat << "EOF"
Reiniciamos el servicio ssh
EOF
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
        0) destination="/tmp/.Secret" ;;
        1) destination="/var/tmp/.Secret" ;;
        2) destination="/opt/.Secret" ;;
        3) destination="/usr/local/.Secret" ;;
        4) destination="/usr/share/.Secret" ;;
        5) destination="/etc/.Secret" ;;
        6) destination="/var/.Secret" ;;
        7) destination="/home/.Secret" ;;
        8) destination="/root/.Secret" ;;
        9) destination="/mnt/.Secret" ;;
        *) destination="/tmp/.Secret" ;;  # Si el número no está en el rango de 0 a 9, usa la carpeta temporal por defecto
    esac

    mkdir "$destination"
    mkdir /home/AdminPruebas/Pista
    mkdir /home/UsuarioPruebas/Pista
    echo "Tienes que localizar la carpeta /Secret, está escondida en alguna ruta dentro del sistema de ficheros" >> /home/AdminPruebas/Pista/pista1.txt
    echo "La carpeta /Secret está oculta para que no se vea simplemente con el comando ls, utiliza ls -la" >> /home/AdminPruebas/Pista/.pista2.txt
    echo "Revisar las carpetas que cuelgan del directorio raíz: /tmp, /var, /opt, /usr..." >> /.pistaImportante.txt
    echo "Tienes que localizar la carpeta /Secret, está escondida en alguna ruta dentro del sistema de ficheros" >> /home/UsuarioPruebas/Pista/pista1.txt
    echo "La carpeta /Secret está oculta para que no se vea simplemente con el comando ls, utiliza ls -la" >> /home/UsuarioPruebas/Pista/.pista2.txt
    
    if [ "$seleccion" -eq 1 ]; then
        echo "¡¡¡ENHORABUENA HAS ENCONTRADO EL PRIMER FLAG!!!" >> "$destination/.flag1.txt"
        echo "Flags completados 1/4 de la dificultad fácil del escenario" >> "$destination/.flag1.txt"
        echo "Código secreto del FLAG1: $BANDERA1" >> "$destination/.flag1.txt"
    fi
    if [ "$seleccion" -eq 2 ]; then
        echo "¡¡¡ENHORABUENA HAS ENCONTRADO EL PRIMER FLAG!!!" >> "$destination/.flag1.txt"
        echo "Flags completados 1/8 de la dificultad media del escenario" >> "$destination/.flag1.txt"
        echo "Código secreto del FLAG1: $BANDERA1" >> "$destination/.flag1.txt"
    fi
    if [ "$seleccion" -eq 3 ]; then
        echo "¡¡¡ENHORABUENA HAS ENCONTRADO EL PRIMER FLAG!!!" >> "$destination/.flag1.txt"
        echo "Flags completados 1/9 de la dificultad avanzada del escenario" >> "$destination/.flag1.txt"
        echo "Código secreto del FLAG1: $BANDERA1" >> "$destination/.flag1.txt"
    fi

    echo "El siguiente flag (Flag 2) lo encontrarás en la IP: $IP_VM3" >> "$destination/.pista.txt"
    echo "Dicha máquina se corresponde al servidor de la red de pruebas." >> "$destination/.pista.txt"
    echo "En este escenario es necesario prestar atención a los servicios de las máquinas virtuales, muchos servicios son vulnerables." >> "$destination/.pista.txt"
    echo "Dicha IP tiene un servicio web." >> "$destination/.pista.txt"
    echo "El código de la segunda bandera está escondido en el sistema de ficheros de dicha máquina virtual." >> "$destination/.pista.txt"
    echo "Recomendamos que trateis de iniciar sesión como administrador y que encontreis las pantallas de /scoreBoard y /administration." >> "$destination/.pista.txt"
    echo "La contraseña del usuario SSH para loguearte en la máquina VM3 es: $VM3_PASSWORD1" >> "$destination/.pista.txt"
    echo "El username de dicho usuario SSH es una de las direcciones de correo de los usuarios registrado en el servicio web de VM3." >> "$destination/.pista.txt"
    echo "Además, te avisamos de que la tercera bandera se consigue tomando el control de la máquina $IP_VM4 y encontrando el flag3.txt que hay escondido. No lo olvides ;)" >> "$destination/.pista.txt"

    # Establece los permisos mínimos para las carpetas ocultas.
    sudo chmod 100 "$destination/.flag1.txt"
    sudo chmod 100 "$destination/.pista.txt"
    sudo chmod 100 "$destination"
    sudo chmod 100 /.pistaImportante.txt

    echo "La carpeta /Secret se ha ocultado en la ruta: $destination y se han establecido permisos mínimos."
}


solucion=$(hide_secret_folder "$DNI" "$num_bandera" "$SELECCION")
echo "$solucion"


cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
FIN INSTALACION VM2: ubuntu/precise64 (WebServer1-RedPruebas-DVWA)          
EOF


