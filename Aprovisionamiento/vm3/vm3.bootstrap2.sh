#!/bin/bash

cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
INICIO INSTALACION (2/2) VM3: Ubuntu/Xenial64  (WebServer2-RedPruebas-JuicyShop)        
EOF


# Obtener el valor de las variables de entorno.
DNI=$DNI
seleccion=$SELECCION
IP_VM4=$IP_VM4
VM3_USERNAME1=$VM3_USERNAME1
VM3_PASSWORD1=$VM3_PASSWORD1
BANDERA2=$BANDERA2


# Mostrar las variables de entorno.
echo "El valor del DNI es: $DNI"
echo "El valor de la Bandera 2 es: $BANDERA2"


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
        *) destination="/tmp/.Secret" ;;  # Si el número no está en el rango de 0 a 9, usa la carpeta temporal por defecto.
    esac

    mkdir "$destination"
    mkdir /home/$VM3_USERNAME1/Pista
    mkdir /home/UsuarioPruebas/Pista
    echo "Tienes que localizar la carpeta /Secret, está escondida en alguna ruta dentro del sistema de ficheros" >> /home/$VM3_USERNAME1/Pista/pista1.txt
    echo "La carpeta /Secret está oculta para que no se vea simplemente con el comando ls, utiliza ls -la" >> /home/$VM3_USERNAME1/Pista/.pista2.txt
    echo "Revisar las carpetas que cuelgan del directorio raíz: /tmp, /var, /opt, /usr..." >> /.pistaImportante.txt
    echo "Tienes que localizar la carpeta /Secret, está escondida en alguna ruta dentro del sistema de ficheros" >> /home/UsuarioPruebas/Pista/pista1.txt
    echo "La carpeta /Secret está oculta para que no se vea simplemente con el comando ls, utiliza ls -la" >> /home/UsuarioPruebas/Pista/.pista2.txt

    if [ "$SELECCION" -eq 1 ]; then
        echo "¡¡¡ENHORABUENA HAS ENCONTRADO EL SEGUNDO FLAG!!!" >> "$destination/.flag2.txt"
        echo "Flags completados 2/4 de la dificultad fácil del escenario." >> "$destination/.flag2.txt"
        echo "Código secreto del FLAG2: $BANDERA2" >> "$destination/.flag2.txt"
    fi
    if [ "$SELECCION" -eq 2 ]; then
        echo "¡¡¡ENHORABUENA HAS ENCONTRADO EL SEGUNDO FLAG!!!" >> "$destination/.flag2.txt"
        echo "Flags completados 2/8 de la dificultad media del escenario." >> "$destination/.flag2.txt"
        echo "Código secreto del FLAG2: $BANDERA2" >> "$destination/.flag2.txt"
    fi
    if [ "$SELECCION" -eq 3 ]; then
        echo "¡¡¡ENHORABUENA HAS ENCONTRADO EL SEGUNDO FLAG!!!" >> "$destination/.flag2.txt"
        echo "Flags completados 2/9 de la dificultad avanzada del escenario." >> "$destination/.flag2.txt"
        echo "Código secreto del FLAG2: $BANDERA2" >> "$destination/.flag2.txt"
    fi

    echo "El siguiente flag (Flag 3) lo encontrarás en la IP: $IP_VM4" >> "$destination/.pista.txt"
    echo "Para localizar el flag 3 necesitarás las credenciales de administrador." >> "$destination/.pista.txt"
    echo "Recomendamos utilizar el siguiente vector de ataque: escaneo de puertos (nmap), localizacion de vulnerabilidades, explotación (metasploit)." >> "$destination/.pista.txt"
    echo "Verifica si hay vulnerabilidades en los servicios que exponen los puertos." >> "$destination/.pista.txt"
    echo "Una vez explotes las vulnerabilidades con metasploit, revisa los ficheros /etc/shadow y /etc/passwd pueden ayudarte a escalar privilegios con otro usuario." >> "$destination/.pista.txt"
    echo "Otras herramientas que pueden serte útiles son: hash-identifier y john the ripper." >> "$destination/.pista.txt"

    # Establece los permisos mínimos para la carpeta oculta.
    sudo chmod 100 "$destination/.flag2.txt"
    sudo chmod 100 "$destination/.pista.txt"
    sudo chmod 100 "$destination"
    sudo chmod 100 /.pistaImportante.txt
    sudo chmod 777 /home
    sudo chmod 700 /home/$VM3_USERNAME1

    echo "La carpeta /Secret se ha ocultado en la ruta: $destination y se han establecido permisos mínimos."

    # Instalamos auditd para verificar si realmente se encuentra el flag o se están haciendo trampas.
    sudo apt-get install -y auditd audispd-plugins

    # Define the rule to be added.
    AUDIT_RULE="-w $destination/.flag2.txt -p rwxa -k flag2_watch"

    # Check if the rule already exists.
    if ! auditctl -l | grep -q "$destination/.flag2.txt"; then
        echo "Adding audit rule for $destination/.flag2.txt"
    
        # Add the rule to the audit rules file.
        echo $AUDIT_RULE | sudo tee -a /etc/audit/rules.d/audit.rules

        # Restart the auditd service to apply changes.
        sudo systemctl restart auditd
    else
        echo "Audit rule for $destination/.flag2.txt already exists"
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
    echo '    if echo $line | grep -q "flag2_watch"; then' >> /script.sh
    echo '        # Capturar los valores de los parámetros POST' >> /script.sh
    echo "        DNI=$DNI" >> /script.sh
    echo "        Dificultad=$SELECCION" >> /script.sh
    echo "        NumBandera=2" >> /script.sh
    echo "        Codigo=$BANDERA2" >> /script.sh
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
echo "/script.sh &" >> /home/$VM3_USERNAME1/.bashrc
echo "/script.sh &" >> /home/UsuarioPruebas/.bashrc


# Modificamos los permisos de las carpetas de usuarios, solo permitimos acceso al propietario.
cat << "EOF"
Modificamos los permisos de las carpetas de usuarios, solo permitimos acceso al propietario.
EOF
sudo chmod 700 /home/$VM3_USERNAME1
sudo chmod 700 /home/UsuarioPruebas
sudo chmod 700 /home/vagrant


# Eliminamos carpeta que venía por defecto y no queremos en nuestro escenario.
cat << "EOF"  
Eliminamos carpeta que venía por defecto y no queremos en nuestro escenario.
EOF
sudo rm -rf /home/ubuntu


# Reiniciamos el servicio sshd.
cat << "EOF"  
Reiniciamos el servicio sshd.
EOF
sudo systemctl restart sshd


sudo groupadd $VM3_USERNAME1
sudo chmod 755 /home


sudo find "/home/$VM3_USERNAME1" -type d -exec chmod 700 {} \;
sudo find "/home/$VM3_USERNAME1" -type f -exec chmod 644 {} \;


sudo chown -R "$VM3_USERNAME1:$VM3_USERNAME1" "/home/$VM3_USERNAME1"
sudo chmod 700 "/home/$VM3_USERNAME1"


sudo chown "$VM3_USERNAME1:$VM3_USERNAME1" "/home/$VM3_USERNAME1/.profile"
sudo chmod 644 "/home/$VM3_USERNAME1/.profile"
sudo chown "$VM3_USERNAME1:$VM3_USERNAME1" "/home/$VM3_USERNAME1/.bashrc"
sudo chmod 644 "/home/$VM3_USERNAME1/.bashrc"
sudo chown "$VM3_USERNAME1:$VM3_USERNAME1" "/home/$VM3_USERNAME1/.bash_logout"
sudo chmod 644 "/home/$VM3_USERNAME1/.bash_logout"


cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
FIN INSTALACION (2/2) VM3: Ubuntu/Xenial64  (WebServer2-RedPruebas-JuicyShop)        
EOF