import os


# Obtener los valores del DNI y la dificultad de las variables de entorno.
dni = os.environ.get('DNI')
seleccion = os.environ.get('SELECCION')


# Verificamos que la dificultad del escenario y el DNI están bien definidos.
if dni is None:
    raise ValueError("La variable de entorno 'DNI' no está definida")
if seleccion is None:
    raise ValueError("La variable de entorno 'SELECCION' no está definida")


# Definir la variable de dificultad basada en el valor de 'SELECCION'.
if seleccion == '1':
    dificultad = 'difFacil'
elif seleccion == '2':
    dificultad = 'difMedia'
elif seleccion == '3':
    dificultad = 'difAvanzada'
else:
    raise ValueError("El valor de 'SELECCION' no es válido")


# Recoger las direcciones IP de las variables de entorno.
ip_vm1 = os.getenv('IP_VM1')
ip_vm2 = os.getenv('IP_VM2')
ip_vm3 = os.getenv('IP_VM3')
ip_vm4 = os.getenv('IP_VM4')
ip_vm5_1 = os.getenv('IP_VM5_1')
ip_vm5_2 = os.getenv('IP_VM5_2')
ip_vm6 = os.getenv('IP_VM6')
ip_vm7 = os.getenv('IP_VM7')
ip_vm8 = os.getenv('IP_VM8')
ip_vm9_1 = os.getenv('IP_VM9_1')
ip_vm9_2 = os.getenv('IP_VM9_2')


# Obtener el usuario y contraseña de la máquina atacante que se proporciona al usuario.
vm1_username = os.getenv('VM1_USERNAME')
vm1_password = os.getenv('VM1_PASSWORD')


# Direcciones IP del escenario.
print("LABORATORIO NIVEL DE DIFICULTAD: MEDIA")
print("\n")
print("Direcciones IP:")
print("VM1: ", ip_vm1, "  -> KaliLinux-Atacante")
print("VM2: ", ip_vm2, "  -> WebServer")
print("VM3: ", ip_vm3, "  -> WebServer")
print("VM4: ", ip_vm4, "  -> Client1")
print("VM5: ", ip_vm5_1, " , ", ip_vm5_2, "  -> Client2")
print("VM6: ", ip_vm6, "  -> FTPServer")
print("VM7: ", ip_vm7, "  -> Client3")
print("VM8: ", ip_vm8, "  -> Client4")
print("VM9: ", ip_vm9_1, " , ", ip_vm9_2, "  -> WebServer")
print("\n")


# Documentación adicional del escenario para el usuario.
print("- Para comenzar tendrás que iniciar sesión en la máquina VM1 (user: ", vm1_username, " ,password: ", vm1_password)
print("- VM1 es la máquina atacante, que simula un insider malicioso que se ha colado en la red interna de una infraestructura corporativa.")
print("- Tienes que localizar las 8 banderas ocultas en el escenario.")
print("- Las banderas están distribuidas a lo largo de dos redes internas (RED PRUEBAS y RED PREPRODUCCION).")
print("- Se necesitarán emplear técnicas de pivotaje entre redes en el nivel de dificultad media del escenario.")
print("- La primera bandera la localizarás en la máquina VM2.")
print("- Este laboratorio está desarrollado para que trates de localizar las banderas en orden. Primero la bandera 1, luego la 2...")
print("- Las pistas te ayudarán a encontrar la bandera siguiente, si intentas saltarte el orden, te faltarán pistas para encontrar las banderas y dificultará la resolución del laboratorio.")
print("- Las banderas están escondidas en ficheros con el siguiente formato flag1.txt, flag2.txt, dentro tienen un código de 12 caracteres o resultado de la bandera.")
print("- Para acceder a estos ficheros de texto y leer las banderas tendrás que tomar el control de las máquinas del escenario, con permisos de root.")
print("- Recomendamos utilizar las siguientes herramientas en este laboratorio: Nmap, Metasploit, John de Ripper, Burpsuite, Gobuster, dirb, dirbuster, Hydra, whatweb, hash-identifier, crunch, medusa, cupp, WPScan.")
print("- Recomendamos utilizar los siguientes comandos: chmod, ifconfig, route, ping, cat, netcat.")
print("- Para los ataques de contraseña basados en diccionario se recomienda utilizar los diccionarios comunes de Kali Linux: Big.txt, common.txt, rockyou.txt, small.txt...")
print("- Entender la importancia de los ficheros /etc/shadow y /etc/passwd.")
print("- Averiguar cual es el comando para identificar y leer ficheros ocultos.")
print("- Deberás aprender a descifrar (cifrados débiles) y realizar conversiones de binario y hexadecimal a texto.")
print("- Este es un escenario personalizado en función de tu DNI, no copies los resultados de otros alumnos ya que las banderas, IPs y contraseñas son distintas para cada alumno.")
print("- Si tienes problemas de rendimiento con la GUI de la VM1, siempre puedes ampliar recursos de procesamiento y memoria desde VirtualBox. Otra opción es no utilizar la GUI de la VM1 y únicamente utilizar conexión vía SSH (terminal).")
print("- Para conectarte a las máquinas vía ssh, ejecutaremos: ssh -p [port] [Username]@127.0.0.1")
print("- Para conectarte vía ssh, a VM1 ejecutaremos: ssh -p 2220 ",vm1_username, "@127.0.0.1")
print("\n")


# Mostrar los criterios de puntuación del laboratorio.
print("Puntuación del laboratorio:")
print("- Bandera 1: +0,75 puntos.")
print("- Bandera 2: +0,75 puntos.")
print("- Bandera 3: +0,75 puntos.")
print("- Bandera 4: +0,75 puntos.")
print("- Bandera 5: +0,75 puntos.")
print("- Bandera 6: +0,75 puntos.")
print("- Bandera 7: +0,75 puntos.")
print("- Bandera 8: +0,75 puntos.")
print("- Preguntas y respuestas: +2 puntos.")
print("*En el nivel de dificultad media del laboratorio la puntuación máxima es de (8/10).")
print("\n")