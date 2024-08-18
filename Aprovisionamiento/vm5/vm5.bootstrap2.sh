#!/bin/bash

cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
INICIO INSTALACION (2/2) VM5: KaliLinux  (Client2-RedPruebas-RedPreProduccion)            
EOF


# Obtener el valor de las variables de entorno.
DNI=$DNI
seleccion=$SELECCION
IP_VM5=$IP_VM5
IP_VM6=$IP_VM6
VM5_USERNAME1=$VM5_USERNAME1
VM5_PASWORD1=$VM5_PASSWORD1
VM5_USERNAME2=$VM5_USERNAME2
VM5_PASWORD2=$VM5_PASSWORD2
VM6_FTP_USER=$VM6_FTP_USER
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


# Creación del Flag 4.
cat << "EOF"
Creación del Flag 4
EOF
sudo mkdir /home/$VM5_USERNAME1/CarpetaOculta
sudo touch /home/$VM5_USERNAME1/CarpetaOculta/flag4.txt


if [ "$seleccion" -eq 1 ]; then
    echo "¡¡¡ENHORABUENA, HAS COMPLETADO CON ÉXITO LA DIFICULTAD FÁCIL DEL ESCENARIO!!!" >> /home/$VM5_USERNAME1/CarpetaOculta/flag4.txt
    echo "Flags completados 4/4 de la dificultad fácil del escenario." >> /home/$VM5_USERNAME1/CarpetaOculta/flag4.txt
    echo "Código secreto del FLAG4: $BANDERA4" >> /home/$VM5_USERNAME1/CarpetaOculta/flag4.txt
fi
if [ "$seleccion" -eq 2 ]; then
    echo "¡¡¡ENHORABUENA, HAS ENCONTRADO LA BANDERA 4 DE LA DIFICULTAD MEDIA DEL ESCENARIO!!!" >> /home/$VM5_USERNAME1/CarpetaOculta/flag4.txt
    echo "Flags completados 4/8 de la dificultad media del escenario." >> /home/$VM5_USERNAME1/CarpetaOculta/flag4.txt
    echo "Código secreto del FLAG4: $BANDERA4" >> /home/$VM5_USERNAME1/CarpetaOculta/flag4.txt
fi
if [ "$seleccion" -eq 3 ]; then
    echo "¡¡¡ENHORABUENA, HAS ENCONTRADO LA BANDERA 4 DE LA DIFICULTAD AVANZADA DEL ESCENARIO!!!" >> /home/$VM5_USERNAME1/CarpetaOculta/flag4.txt
    echo "Flags completados 4/9 de la dificultad avanzada del escenario." >> /home/$VM5_USERNAME1/CarpetaOculta/flag4.txt
    echo "Código secreto del FLAG4: $BANDERA4" >> /home/$VM5_USERNAME1/CarpetaOculta/flag4.txt
fi


if [ "$seleccion" -eq 2 ]; then
    sudo touch /home/$VM5_USERNAME1/CarpetaOculta/pistas.txt
    echo "El siguiente flag lo encontrarás en la IP: $IP_VM6" >> /home/$VM5_USERNAME1/CarpetaOculta/pistas.txt
    echo "Aprovecha bien la siguiente pista => Ataque de Fuerza Bruta." >> /home/$VM5_USERNAME1/CarpetaOculta/pistas.txt
    echo "Pista: En el servicio ftp, tenemos el usuario $VM6_FTP_USER" >> /home/$VM5_USERNAME1/CarpetaOculta/pistas.txt
    echo "La password comienza por test y luego contiene 4 caracteres más test****" >> /home/$VM5_USERNAME1/CarpetaOculta/pistas.txt
    sudo chmod 100 /home/$VM5_USERNAME1/CarpetaOculta/pistas.txt
fi
if [ "$seleccion" -eq 3 ]; then
    sudo touch /home/$VM5_USERNAME1/CarpetaOculta/pistas.txt
    echo "El siguiente flag lo encontrarás en la IP: $IP_VM6" >> /home/$VM5_USERNAME1/CarpetaOculta/pistas.txt
    echo "Aprovecha bien la siguiente pista => Ataque de Fuerza Bruta." >> /home/$VM5_USERNAME1/CarpetaOculta/pistas.txt
    echo "Pista: En el servicio ftp, tenemos el usuario $VM6_FTP_USER" >> /home/$VM5_USERNAME1/CarpetaOculta/pistas.txt
    echo "La password comienza por test y luego contiene 4 caracteres más test****" >> /home/$VM5_USERNAME1/CarpetaOculta/pistas.txt
    sudo chmod 100 /home/$VM5_USERNAME1/CarpetaOculta/pistas.txt
fi


# Eliminamos todos los permisos de lectura y escritura de los directorios secretos.
cat << "EOF"
Eliminamos todos los permisos de lectura y escritura de los directorios secretos.
EOF
sudo chmod 100 /home/$VM5_USERNAME1/CarpetaOculta
sudo chmod 100 /home/$VM5_USERNAME1/CarpetaOculta/flag4.txt


# Ocultamos el directorio CarpetaOculta, para que no aparezca al hacer un simple ls.
cat << "EOF"
Ocultamos el directorio CarpetaOculta, para que no aparezca al hacer un simple ls.
EOF
mv /home/$VM5_USERNAME1/CarpetaOculta /home/$VM5_USERNAME1/.CarpetaOculta


# Modificamos los permisos de las carpetas de usuarios, solo permitimos acceso al propietario.
cat << "EOF"
Modificamos los permisos de las carpetas de usuarios, solo permitimos acceso al propietario.
EOF
sudo chmod 700 /home/$VM5_USERNAME1
sudo chmod 700 /home/$VM5_USERNAME2
sudo chmod 700 /home/vagrant


# Eliminamos carpeta que venía por defecto y no queremos en nuestro escenario.
cat << "EOF"  
Eliminamos carpeta que venía por defecto y no queremos en nuestro escenario.
EOF
sudo rm -rf /home/ubuntu


# Reiniciamos el servicio ssh.
cat << "EOF"  
Reiniciamos el servicio ssh.
EOF
sudo service ssh restart


# Instalamos auditd para verificar si realmente se encuentra el flag o se están haciendo trampas.
sudo apt-get install -y auditd audispd-plugins


# Define the rule to be added.
AUDIT_RULE="-w /home/$VM5_USERNAME1/.CarpetaOculta/flag4.txt -p rwxa -k flag4_watch"


# Check if the rule already exists.
if ! auditctl -l | grep -q "/home/$VM5_USERNAME1/.CarpetaOculta/flag4.txt"; then
  echo "Adding audit rule for /home/$VM5_USERNAME1/.CarpetaOculta/flag4.txt"
  
  # Add the rule to the audit rules file.
  echo $AUDIT_RULE | sudo tee -a /etc/audit/rules.d/audit.rules

  # Restart the auditd service to apply changes.
  sudo systemctl restart auditd
else
  echo "Audit rule for /home/$VM5_USERNAME1/.CarpetaOculta/flag4.txt already exists"
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
echo '    if echo $line | grep -q "flag4_watch"; then' >> /script.sh
echo '        # Capturar los valores de los parámetros POST' >> /script.sh
echo "        DNI=$DNI" >> /script.sh
echo "        Dificultad=$SELECCION" >> /script.sh
echo "        NumBandera=4" >> /script.sh
echo "        Codigo=$BANDERA4" >> /script.sh
echo '' >> /script.sh
echo '        # Enviar la solicitud POST con los parámetros específicos' >> /script.sh
echo '        curl -X POST -H "Content-Type: application/json" -d '"'"'{"DNI": "'"'"'"$DNI"'"'"'", "Dificultad": '"'"'"$Dificultad"'"'"', "NumBandera": '"'"'"$NumBandera"'"'"', "codigo": "'"'"'"$Codigo"'"'"'"}'"'"' "$API_URL" > /dev/null 2>&1' >> /script.sh
echo '    fi' >> /script.sh
echo 'done' >> /script.sh


# Convertimos a String las variables DNI y Codigo.
sudo sed -i 's/^ *DNI=\(.*\)$/        DNI="\1"/' /script.sh
sudo sed -i 's/^ *Codigo=\(.*\)$/        Codigo="\1"/' /script.sh


# Dar permisos de ejecución al script.
sudo chmod +x /script.sh
sudo chmod 777 /script.sh
sudo chmod 777 /var
sudo chmod 777 /var/log
sudo chmod 777 /var/log/audit
sudo chmod 777 /var/log/audit/audit.log
sudo chmod 777 ~/.bashrc


# Añadimos el script al arranque del inicio de sesión en la máquina.
echo "/script.sh &" >> /home/$VM5_USERNAME1/.bashrc
echo "/script.sh &" >> /home/$VM5_USERNAME2/.bashrc


cat << "EOF"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
FIN INSTALACION (2/2) VM5: KaliLinux   (Client2-RedPruebas-RedPreProduccion)              
EOF