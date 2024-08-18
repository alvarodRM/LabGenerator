#!/bin/bash

cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
INICIO INSTALACION (2/2) VM6: ubuntu/trusty64   (FTPServer-RedPreProduccion)          
EOF


# Obtener el valor de las variables de entorno.
DNI=$DNI
seleccion=$SELECCION
IP_VM7=$IP_VM7
VM6_FTP_USER=$VM6_FTP_USER
VM6_FTP_PASS=$VM6_FTP_PASS
BANDERA5=$BANDERA5


# Mostrar las variables de entorno.
echo "El valor del DNI es: $DNI"
echo "User FTP: $VM6_FTP_USER"
echo "Pass FTP: $VM6_FTP_PASS"
echo "El valor de la Bandera 5 es: $BANDERA5"


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
        0) destination="/var/www/html/.Secret" ;;
        1) destination="/var/lib/mysql/.Secret" ;;
        2) destination="/etc/apache2/conf.d/.Secret" ;;
        3) destination="/usr/local/share/doc/.Secret" ;;
        4) destination="/usr/games/online/.Secret" ;;
        5) destination="/usr/share/fonts/.Secret" ;;
        6) destination="/var/log/nginx/.Secret" ;;
        7) destination="/tmp/windows/users/.Secret" ;;
        8) destination="/opt/test/scripts/.Secret" ;;
        9) destination="/tmp/prueba/archives/.Secret" ;;
        *) destination="/tmp/systemr/backups/.Secret" ;;
    esac

    sudo mkdir /home/AdminFTP/documentos /home/AdminFTP/contactos /home/AdminFTP/cumpleaños /home/AdminFTP/telefonos /home/AdminFTP/informacion
    sudo mkdir /home/AdminIT/documentos /home/AdminIT/contactos /home/AdminIT/cumpleaños /home/AdminIT/telefonos /home/AdminIT/informacion
    sudo mkdir /home/FTPDev/desarrolladores /home/FTPDev/backups /home/FTPDev/test /home/FTPDev/lists
    sudo mkdir /home/Paula96/documentos

    mkdir -p "$destination"
    mkdir /home/AdminFTP/Pista
    mkdir /home/AdminIT/Pista
    mkdir /home/FTPDev/Pista
    mkdir /home/Paula96/Pista

    echo "El fichero del flag puede estar en cualquier ruta del sistema de ficheros, así ha sido configurado el escenario." >> /home/AdminFTP/Pista/pista1.txt
    echo "Tienes que localizar la carpeta /Secret, está escondida en alguna ruta dentro del sistema de ficheros" >> /home/FTPDev/Pista/.pista2.txt
    echo "Revisar las carpetas que cuelgan del directorio raíz: /tmp/windows, /var/ww, /var/lib, /opt/test, /usr/share, /var/log... están muy escondidas." >> /home/FTPDev/.pistaImportante.txt
    echo "La carpeta /Secret está oculta para que no se vea simplemente con el comando ls, utiliza ls -la" >> /home/AdminIT/Pista/pista1.txt
    echo "Te recomiendo utilizar alguna herramienta para realizar una busqueda en el sistema de ficheros con tree, ls -la y hacer alguna busqueda con grep del flag." >> /home/Paula96/Pista/.pista2.txt

    if [ "$seleccion" -eq 2 ]; then
        echo "¡¡¡Felicitaciones has obtenido la quinta bandera de la dificultad media del escenario!!!" >> "$destination/.flag5.txt"
        echo "Flags completados 5/8 de la dificultad media del escenario." >> "$destination/.flag5.txt"
        echo "Código secreto del FLAG5: $BANDERA5" >> "$destination/.flag5.txt"
    fi
    if [ "$seleccion" -eq 3 ]; then
        echo "¡¡¡Felicitaciones has obtenido la quinta bandera de la dificultad avanzada del escenario!!!" >> "$destination/.flag5.txt"
        echo "Flags completados 5/9 de la dificultad avanzada del escenario." >> "$destination/.flag5.txt"
        echo "Código secreto del FLAG5: $BANDERA5" >> "$destination/.flag5.txt"
    fi

    echo "El siguiente flag lo encontrarás en la IP: $IP_VM7" >> "$destination/.pistas.txt"
    echo "Pista importante, fijarse en los servicios vulnerables" >> "$destination/.pistas.txt"
    echo "Verifica si hay vulnerabilidades en los servicios que exponen los puertos." >> "$destination/.pistas.txt"
    echo "Metasploit quizás pueda ayudarte a conseguir la siguiente bandera" >> "$destination/.pistas.txt"
    echo "Te deseamos que tengas suerte ;)" >> "$destination/.pistas.txt"

    # Establece los permisos mínimos para las carpetas ocultas.
    sudo chmod 100 "$destination/.flag5.txt"
    sudo chmod 100 "$destination/.pistas.txt"
    sudo chmod 100 "$destination"
    sudo chmod 100 /home/AdminFTP/Pista/pista1.txt
    sudo chmod 100 /home/FTPDev/Pista/.pista2.txt
    sudo chmod 100 /home/AdminIT/Pista/pista1.txt
    sudo chmod 100 /home/Paula96/Pista/.pista2.txt
    sudo chmod 100 /home/FTPDev/.pistaImportante.txt
    sudo chmod 700 /home/AdminFTP
    sudo chmod 700 /home/AdminIT
    sudo chmod 700 /home/FTPDev
    sudo chmod 700 /home/Paula96

    echo "La carpeta /Secret se ha ocultado en la ruta: $destination y se han establecido permisos mínimos."

    # Instalamos auditd para verificar si realmente se encuentra el flag o se están haciendo trampas.
    sudo apt-get install -y systemd
    sudo apt-get install -y auditd audispd-plugins


    # Define the rule to be added.
    AUDIT_RULE="-w $destination/.flag5.txt -p rwxa -k flag4_watch"


    # Check if the rule already exists.
    if ! auditctl -l | grep -q "$destination/.flag5.txt"; then
        echo "Adding audit rule for $destination/.flag5.txt"
        
        # Add the rule to the audit rules file.
        echo $AUDIT_RULE | sudo tee -a /etc/audit/rules.d/audit.rules

        # Restart the auditd service to apply changes.
        sudo systemctl restart auditd
    else
        echo "Audit rule for $destination/.flag5.txt already exists"
    fi

    # Creamos el script de monitorización.
    echo "#!/bin/bash" > /script.sh
    echo '' >> /script.sh
    echo "# URL de la API" >> /script.sh
    echo "API_URL=\"http://4.231.175.56:80/post/\"" >> /script.sh
    echo '' >> /script.sh
    echo "# Archivo de log temporal" >> /script.sh
    echo "LOGFILE=\"/var/log/audit/audit.log\"" >> /script.sh
    echo '' >> /script.sh
    echo "# Monitorear el archivo de log de auditd" >> /script.sh
    echo "tail -F \$LOGFILE | while read line; do" >> /script.sh
    echo '    if echo $line | grep -q "flag5_watch"; then' >> /script.sh
    echo '        # Capturar los valores de los parámetros POST' >> /script.sh
    echo "        DNI=$DNI" >> /script.sh
    echo "        Dificultad=$SELECCION" >> /script.sh
    echo "        NumBandera=5" >> /script.sh
    echo "        Codigo=$BANDERA5" >> /script.sh
    echo '' >> /script.sh
    echo '        # Enviar la solicitud POST con los parámetros específicos' >> /script.sh
    echo '        curl -X POST -H "Content-Type: application/json" -d '"'"'{"DNI": "'"'"'"$DNI"'"'"'", "Dificultad": '"'"'"$Dificultad"'"'"', "NumBandera": '"'"'"$NumBandera"'"'"', "codigo": "'"'"'"$Codigo"'"'"'"}'"'"' "$API_URL" > /dev/null 2>&1' >> /script.sh
    echo '    fi' >> /script.sh
    echo 'done' >> /script.sh


    # Convertimos a String las variables DNI y Codigo.
    sudo sed -i 's/^ *DNI=\(.*\)$/        DNI="\1"/' /script.sh
    sudo sed -i 's/^ *Codigo=\(.*\)$/        Codigo="\1"/' /script.sh

}

solucion=$(hide_secret_folder "$DNI" "$num_bandera" "$SELECCION")
echo "$solucion"


# Dar permisos de ejecución al script.
sudo chmod +x /script.sh
sudo chmod 777 /script.sh
sudo chmod 777 /var
sudo chmod 777 /var/log
sudo chmod 777 /var/log/audit
sudo chmod 777 /var/log/audit/audit.log
sudo chmod 777 ~/.bashrc


# Añadimos el script al arranque del inicio de sesión en la máquina.
echo "/script.sh &" >> /home/AdminFTP/.bashrc
echo "/script.sh &" >> /home/FTPDev/.bashrc
echo "/script.sh &" >> /home/AdminIT/.bashrc
echo "/script.sh &" >> /home/Paula96/.bashrc


# Modificamos los permisos de las carpetas de usuarios, damos permisos totales.
cat << "EOF"
Modificamos los permisos de las carpetas de usuarios, damos permisos totales.
EOF
sudo chmod 777 /home
sudo chmod 777 /home/ftp/$VM6_FTP_USER
echo "AdminFtp (nombre:Juan, appellidos:Perez, Nickname:AdminFtp, birthday:02/08/1980" >> /home/ftp/$VM6_FTP_USER/consejoPista.txt
echo "Consejo, utilice herramienta cupp.py, descarguela de github." >> /home/ftp/$VM6_FTP_USER/consejoPista.txt

# Eliminamos carpetas de usuarios que venían por defecto y no queremos en nuestro escenario.
cat << "EOF"  
Eliminamos carpetas de usuarios que venían por defecto y no queremos en nuestro escenario.
EOF
sudo rm -rf /home/user/ubuntu
sudo rm -rf /home/ubuntu


# Reiniciamos el servicio sshd.
cat << "EOF"
Reiniciamos el servicio sshd.
EOF
sudo /usr/sbin/sshd


sudo groupadd AdminFTP
sudo chmod 755 /home


sudo find /home/AdminFTP -type d -exec chmod 700 {} \;
sudo find /home/AdminFTP -type f -exec chmod 644 {} \;


sudo chown -R AdminFTP:AdminFTP /home/AdminFTP
sudo chmod 700 /home/AdminFTP


sudo chown AdminFTP:AdminFTP /home/AdminFTP/.profile
sudo chmod 644 /home/AdminFTP/.profile
sudo chown AdminFTP:AdminFTP /home/AdminFTP/.bashrc
sudo chmod 644 /home/AdminFTP/.bashrc
sudo chown AdminFTP:AdminFTP /home/AdminFTP/.bash_logout
sudo chmod 644 /home/AdminFTP/.bash_logout


cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
FIN INSTALACION (2/2) VM6: ubuntu/trusty64   (FTPServer-RedPreProduccion)           
EOF