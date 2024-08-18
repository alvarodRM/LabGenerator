import re
import os
import hashlib


print("--------------------------------------------------------------------------------------")
os.system("chmod 777 Animations/1.sh")
os.system("Animations/1.sh")
print("--------------------------------------------------------------------------------------")


# Función para validar el formato del DNI.
def validar_dni(dni):
    # Patrón de expresión regular para un DNI válido.
    patron_dni = r'^\d{8}[a-zA-Z]$'
    return re.match(patron_dni, dni) is not None


# Solicitar el DNI como input repetidamente hasta que sea válido.
dni_valido = False
while not dni_valido:
    dni = input("Por favor, introduce tu DNI: .......... ")
    if validar_dni(dni):
        dni_valido = True
    else:
        print("- !FORMATO DE DNI NO VALIDO! Debe tener 9 caracteres, 8 numeros seguidos de una letra.")
print("- ¡DNI introducido correctamente! -> {}".format(dni))
print("--------------------------------------------------------------------------------------")


# Imprimir el menú de selección de dificultad.
print("\n")
print("Selecciona la dificultad:")
print("(1) DIFICULTAD FACIL")
print("|     -> 1 maquina atacante")
print("|     -> 4 maquinas que hackear")
print("|     -> 4 banderas")
print("|     -> X pistas")
print("(2) DIFICULTAD MEDIA")
print("|     -> 1 maquina atacante")
print("|     -> 8 maquinas que hackear")
print("|     -> 8 banderas")
print("|     -> X pistas")
print("(3) DIFICULTAD AVANZADA")
print("|     -> 1 maquina atacante")
print("|     -> 9 maquinas que hackear")
print("|     -> 9 banderas")
print("|     -> X pistas")


# Selección de dificultad.
seleccion = None
while True:
    seleccion = input("Ingresa el numero correspondiente a la dificultad que deseas: .......... ")

    if seleccion in ["1", "2", "3"]:
        break
    else:
        print("- !SELECCION NO VALIDA!")


# Mensaje correspondiente a la selección.
mensaje_seleccionado = ""
if seleccion == "1":
    mensaje_seleccionado = "DIFICULTAD FACIL"
elif seleccion == "2":
    mensaje_seleccionado = "DIFICULTAD MEDIA"
elif seleccion == "3":
    mensaje_seleccionado = "DIFICULTAD AVANZADA"


# Imprimir el mensaje con la dificultad seleccionada.
print("- ¡Dificultad seleccionada correctamente! -> ({}) {}".format(seleccion, mensaje_seleccionado))
print("--------------------------------------------------------------------------------------")
print("\n")


# Función para generar las IPs del escenario.
def generate_ip_addresses(dni, seleccion):
    # Calcula el hash basado en el DNI y la dificultad.
    hash_value = hashlib.md5(f"{dni}{seleccion}".encode()).hexdigest()

    # Extraer el primer carácter del hash y convertirlo a un entero.
    num = int(hash_value[0], 16)

    # Asegurar que el número esté dentro del rango 0-4.
    num %= 5

    # Definir la base de la dirección IP.
    base_ip_RED_PRUEBAS = "192.168.56.5"
    base_ip_RED_PRE_PRODUCCION = "192.168.56."
    base_ip_RED_PRODUCCION = "192.168.56.20"

    # Generar las direcciones IP para las máquinas vm1, vm2, vm3, vm4 y vm5.
    ip_vm1 = f"{base_ip_RED_PRUEBAS}{num}"
    ip_vm2 = f"{base_ip_RED_PRUEBAS}{(num + 1) % 5}"  # Asegura que sea diferente de vm1.
    ip_vm3 = f"{base_ip_RED_PRUEBAS}{(num + 2) % 5}"  # Asegura que sea diferente de vm1 y vm2.
    ip_vm4 = f"{base_ip_RED_PRUEBAS}{(num + 3) % 5}"  # Asegura que sea diferente de vm1, vm2 y vm3.
    ip_vm5_1 = f"{base_ip_RED_PRUEBAS}{(num + 4) % 5}"  # Asegura que sea diferente de vm1, vm2, vm3 y vm4.

    # Generar las direcciones IP para las máquinas vm5, vm6, vm7, vm8 y vm9.
    ip_vm5_2 = f"{base_ip_RED_PRE_PRODUCCION}{97 + num}"
    ip_vm6 = f"{base_ip_RED_PRE_PRODUCCION}{98 + (num + 1) % 5}"  # Asegura que sea diferente de vm5.
    ip_vm7 = f"{base_ip_RED_PRE_PRODUCCION}{99 + (num + 2) % 5}"  # Asegura que sea diferente de vm5 y vm6.
    ip_vm8 = f"{base_ip_RED_PRE_PRODUCCION}{100 + (num + 3) % 5}"  # Asegura que sea diferente de vm5, vm6 y vm7.
    ip_vm9_1 = f"{base_ip_RED_PRE_PRODUCCION}{101 + (num + 4) % 5}"  # Asegura que sea diferente de vm5, vm6, vm7 y vm8.

    # Generar las direcciones IP para las máquinas vm9 y vm10.
    ip_vm9_2 = f"{base_ip_RED_PRODUCCION}{1 + num}"
    ip_vm10 = f"{base_ip_RED_PRODUCCION}{2 + (num + 1) % 2}"  # Asegura que sea diferente de vm9.

    # Exportar las IPs como variables de entorno.
    os.environ['IP_VM1'] = ip_vm1
    os.environ['IP_VM2'] = ip_vm2
    os.environ['IP_VM3'] = ip_vm3
    os.environ['IP_VM4'] = ip_vm4
    os.environ['IP_VM5_1'] = ip_vm5_1
    os.environ['IP_VM5_2'] = ip_vm5_2
    os.environ['IP_VM6'] = ip_vm6
    os.environ['IP_VM7'] = ip_vm7
    os.environ['IP_VM8'] = ip_vm8
    os.environ['IP_VM9_1'] = ip_vm9_1
    os.environ['IP_VM9_2'] = ip_vm9_2
    os.environ['IP_VM10'] = ip_vm10

    return {
        'IP_VM1': ip_vm1,
        'IP_VM2': ip_vm2,
        'IP_VM3': ip_vm3,
        'IP_VM4': ip_vm4,
        'IP_VM5_1': ip_vm5_1,
        'IP_VM5_2': ip_vm5_2,
        'IP_VM6': ip_vm6,
        'IP_VM7': ip_vm7,
        'IP_VM8': ip_vm8,
        'IP_VM9_1': ip_vm9_1,
        'IP_VM9_2': ip_vm9_2,
        'IP_VM10': ip_vm10,
    }


# Función para generar las banderas del laboratorio.
def generar_banderas(DNI, num_banderas, seleccion):
    if not isinstance(DNI, str) or not DNI[:-1].isdigit() or not DNI[-1].isalpha() or len(DNI) != 9:
        raise ValueError("El formato del DNI no es válido")
    
    if not 1 <= num_banderas <= 9:
        raise ValueError("El número de banderas debe estar entre 1 y 9")
    
    # Convertir el DNI y el número de banderas a una cadena de bytes.
    data = (DNI + str(num_banderas) + str(seleccion)).encode('utf-8')
    codigo_banderas = ""
    if seleccion =="1":
        # Calcular el hash SHA-256 de los datos.
        codigo_banderas = hashlib.sha256(data).hexdigest()[:12]
    if seleccion =="2":
        # Invertir el orden de los caracteres.
        codigo_banderas = data[::-1]
        codigo_banderas = hashlib.sha256(data).hexdigest()[:12]
    elif seleccion =="3":
        # Aplicar una función hash adicional al código de banderas.
        codigo_banderas = hashlib.md5(data).hexdigest()[:12]
    
    return codigo_banderas


# Función para generar los usuarios de las máquinas virtuales.
def generar_usuarios(nombres, dni, index1, index2, seleccion):
    # Concatenar los tres parámetros.
    concatenated = f"{dni}{index1}{index2}{seleccion}"
    
    # Obtener el hash MD5 de la concatenación.
    hash_md5 = hashlib.md5(concatenated.encode()).hexdigest()
    
    # Extraer el primer número del hash (0 al 9).
    num = int(''.join(filter(str.isdigit, hash_md5))[0])
    
    # Añadir el índice al número extraído.
    final_num = (num + index1) % 100
    
    # Seleccionar el nombre correspondiente al número final.
    nombre = nombres[final_num % len(nombres)]
    
    usuario_generado = f"{nombre}{num}{index1}"  # Añade los números al nombre.
    return usuario_generado


# Función para generar usuario y contraseña de la máquina atacante vm1.
def generar_usuario_y_contraseña_vm1(dni, seleccion):
    # Concatenar DNI y SELECCION.
    hash_value_vm1 = hashlib.md5(f"{dni}{seleccion}".encode()).hexdigest()
    
    # Extraer los primeros dos caracteres del hash para el nombre de usuario.
    user_suffix = hash_value_vm1[:2]
    username = f"Attack{user_suffix}"
    
    # Extraer los últimos 12 caracteres del hash para la contraseña.
    password = hash_value_vm1[-12:]
    
    return username, password


# Función para generar el usuario de la máquina vm3.
def generar_usuario_vm3(dni, seleccion, file_path):
    # Concatenar dni y seleccion.
    concatenado = f"{dni}{seleccion}"
    
    # Obtener el hash SHA-256 de la cadena concatenada.
    hash_object = hashlib.sha256(concatenado.encode())
    hex_dig = hash_object.hexdigest()
    
    # Extraer los primeros 3 dígitos del hash en hexadecimal.
    primeros_tres_digitos = int(hex_dig[:3], 16)
    
    # Convertir los primeros 3 dígitos en un número del 1 al 20.
    numero = (primeros_tres_digitos % 20) + 1
    
    # Leer todas las líneas del archivo.
    with open(file_path, 'r') as file:
        lines = file.readlines()
    
    # Seleccionar la línea correspondiente al número calculado.
    index = (numero - 1) % len(lines)
    username = lines[index].strip()

    return username


# Crear contraseña para las máquinas virtuales.
def generar_contraseña_wordlist(dni, seleccion, index1, index2, fichero):
    # Concatenar los 4 parámetros en un string.
    concatenated = f"{dni}{seleccion}{index1}{index2}"
    
    # Generar el hash MD5 del string concatenado.
    hash_md5 = hashlib.md5(concatenated.encode()).hexdigest()
    
    # Extraer los 3 primeros números del hash (no letras).
    numeros = ''.join(filter(str.isdigit, hash_md5))[:3]
    
    # Convertir los números extraídos en un entero.
    numero = int(numeros)
    
    # Asegurarse de que el número esté en el rango 001-999.
    if numero == 0:
        numero = 1
    numero = f"{numero:03d}"
    
    # Leer la palabra correspondiente del archivo o diccionario proporcionado.
    with open(fichero, 'r') as file:
        for i, line in enumerate(file, start=1):
            if i == int(numero):
                passwordss = line.strip()
                return passwordss


# Lista de nombres posibles para los usuarios de las virtual machines.
nombres = [
    "Ana", "Juan", "Alvaro", "Maria", "Luis", "Carmen", "Pedro", "Marta", "Jorge", "Elena",
    "Pablo", "Laura", "Andres", "Sofia", "Carlos", "Lucia", "Fernando", "Patricia", "Miguel", "Isabel",
    "Raul", "Cristina", "Jose", "Beatriz", "David", "Sara", "Antonio", "Paula", "Javier", "Angela",
    "Francisco", "Claudia", "Diego", "Nuria", "Manuel", "Rosa", "Oscar", "Eva", "Adrian", "Silvia",
    "Ignacio", "Ines", "Ruben", "Alicia", "Eduardo", "Monica", "Guillermo", "Julia", "Vicente", "Teresa",
    "Emilio", "Ariadna", "Sergio", "Noelia", "Alejandro", "Irene", "Gabriel", "Pilar", "Tomas", "Natalia",
    "Samuel", "Rocio", "Ricardo", "Gloria", "Mario", "Sonia", "Hugo", "Victoria", "Joaquin", "Sandra",
    "Marcos", "Cristian", "Esteban", "Veronica", "Alberto", "Lorena", "Daniel", "Adela", "Enrique", "Anais",
    "Gonzalo", "Elsa", "Federico", "Blanca", "Felipe", "Raquel", "Martín", "Carla", "Ramon", "Nerea",
    "Julio", "Miriam", "Arturo", "Valeria", "Alfonso", "Susana", "Hector", "Olga", "Rafael", "Angela"
]

# Generamos las IPs del escenario.
ip_addresses = generate_ip_addresses(dni, seleccion)

# Generamos las Banderas del laboratorio.
bandera1 = generar_banderas(dni, 1, seleccion)
bandera2 = generar_banderas(dni, 2, seleccion)
bandera3 = generar_banderas(dni, 3, seleccion)
bandera4 = generar_banderas(dni, 4, seleccion)
bandera5 = generar_banderas(dni, 5, seleccion)
bandera6 = generar_banderas(dni, 6, seleccion)
bandera7 = generar_banderas(dni, 7, seleccion)
bandera8 = generar_banderas(dni, 8, seleccion)
bandera9 = generar_banderas(dni, 9, seleccion)

# Generamos los usuarios para las virtual machines.
usuario, contraseña = generar_usuario_y_contraseña_vm1(dni, seleccion)
vm3_username1 = generar_usuario_vm3(dni, seleccion, 'Wordlists/vm3_user.txt')
vm4_username1 = generar_usuarios(nombres, dni, 4, 1, seleccion)
vm4_username2 = generar_usuarios(nombres, dni, 4, 2, seleccion)
vm5_username1 = generar_usuarios(nombres, dni, 5, 1, seleccion)
vm5_username2 = generar_usuarios(nombres, dni, 5, 2, seleccion)
vm6_ftp_user = generar_usuarios(nombres, dni, 6, 60, seleccion)

# Generamos las contraseñas de los usuarios para las virtual machines.
vm3_password1 = generar_contraseña_wordlist(dni, seleccion, 3, 1, "Wordlists/passwords_vm3.txt")
vm4_password1 = generar_contraseña_wordlist(dni, seleccion, 4, 1, "Wordlists/rockyou.txt")
vm5_password1 = generar_contraseña_wordlist(dni, seleccion, 5, 1, "Wordlists/rockyou.txt")
vm5_password2 = generar_contraseña_wordlist(dni, seleccion, 5, 1, "Wordlists/common.txt")
vm6_ftp_pass = generar_contraseña_wordlist(dni, seleccion, 6, 1, "Wordlists/ftp_password.txt")

# Establecemos el DNI como variable de entorno.
os.environ["DNI"] = dni
os.environ["SELECCION"] = seleccion

# Establecemos las banderas como variables de entorno.
os.environ["BANDERA1"] = bandera1
os.environ["BANDERA2"] = bandera2
os.environ["BANDERA3"] = bandera3
os.environ["BANDERA4"] = bandera4
os.environ["BANDERA5"] = bandera5
os.environ["BANDERA6"] = bandera6
os.environ["BANDERA7"] = bandera7
os.environ["BANDERA8"] = bandera8
os.environ["BANDERA9"] = bandera9

# Establecemos los usuarios como variables de entorno.
os.environ['VM1_USERNAME'] = usuario
os.environ['VM3_USERNAME1'] = vm3_username1
os.environ["VM4_USERNAME1"] = vm4_username1
os.environ["VM4_USERNAME2"] = vm4_username2
os.environ["VM5_USERNAME1"] = vm5_username1
os.environ["VM5_USERNAME2"] = vm5_username2
os.environ["VM6_FTP_USER"] = vm6_ftp_user

# Establecemos las contraseñas de los usuarios como variables de entorno.
os.environ['VM1_PASSWORD'] = contraseña
os.environ['VM3_PASSWORD1'] = vm3_password1
os.environ['VM4_PASSWORD1'] = vm4_password1
os.environ['VM5_PASSWORD1'] = vm5_password1
os.environ['VM5_PASSWORD2'] = vm5_password2
os.environ['VM6_FTP_PASS'] = vm6_ftp_pass


# Solicitar al usuario que elija una opción
print("{}".format(mensaje_seleccionado))
print("-----------------------")
print("Selecciona una opcion:")
print("(1)  -> Apagar Escenario")
print("(2)  -> Detener Escenario")
print("(3)  -> Eliminar Escenario")
print("(4)  -> Iniciar Escenario")
print("(5)  -> Instalar Escenario")
print("(6)  -> Cambiar Dificultad Escenario")
print("(7)  -> Informacion acerca del Escenario")
print("(8)  -> Mostrar resultados de las banderas")
print("(9)  -> Empaquetar maquinas virtuales")
print("(10) -> Corregir banderas de listado de DNIs")
print("(11) -> SALIR")

# Verificar si la opción ingresada es válida
opcion = None
while True:
    opcion = input("Ingresa el numero correspondiente a la accion que deseas realizar: .......... ")

    if opcion in ["1", "2", "3", "4", "5","6", "7", "8", "9", "10", "11"]:
        break
    else:
        print("- !SELECCION NO VALIDA!")

continuar = True
while (continuar == True):
    # Dificultad fácil
    if (opcion == "1" and seleccion=="1"):
        print("- (1) -> EJECUTANDO SCRIPT: apagarEscenario.py")
        os.system("python3 DeployScripts/Dificultad1-Facil/apagarEscenario.py")
        print("- (1) -> !ESCENARIO DIFICULTAD FACIL APAGADO!")
    elif (opcion == "2" and seleccion=="1"):
        print("- (2) -> EJECUTANDO SCRIPT: detenerEscenario.py")
        os.system("python3 DeployScripts/Dificultad1-Facil/detenerEscenario.py")
        print("- (2) -> !ESCENARIO DIFICULTAD FACIL DETENIDO!")
    elif (opcion == "3" and seleccion=="1"):
        print("- (3) -> EJECUTANDO SCRIPT: eliminarEscenario.py")
        os.system("python3 DeployScripts/Dificultad1-Facil/eliminarEscenario.py")
        print("- (3) -> !ESCENARIO DIFICULTAD FACIL ELIMINADO!")
    elif (opcion == "4" and seleccion=="1"):
        print("- (4) -> EJECUTANDO SCRIPT: iniciarEscenario.py")
        os.system("python3 DeployScripts/Dificultad1-Facil/iniciarEscenario.py")
        print("- (4) -> !ESCENARIO DIFICULTAD FACIL INICIADO!")
    elif (opcion == "5" and seleccion=="1"):
        print("- (5) -> EJECUTANDO SCRIPT: instalarEscenario.py")
        os.system("python3 DeployScripts/Dificultad1-Facil/instalarEscenario.py")
        print("- (5) -> !ESCENARIO DIFICULTAD FACIL INSTALADO!")
    elif (opcion == "8" and seleccion=="1"):
        print("- (8) -> EJECUTANDO SCRIPT: mostrarBanderas.py")
        print("\n")
        os.system("python3 DeployScripts/Dificultad1-Facil/mostrarBanderas.py")
        print("- (8) -> !FICHERO TXT CON LOS RESULTADOS DE LAS BANDERAS GENERADO!")
    elif (opcion == "9" and seleccion=="1"):
        print("- (9) -> EJECUTANDO SCRIPT: empaquetarVMs.py")
        os.system("python3 DeployScripts/Dificultad1-Facil/empaquetarVMs.py")
    elif (opcion == "10" and seleccion=="1"):
        print("- (10) -> EJECUTANDO SCRIPT: corregirBanderasDNIs.py")
        os.system("python3 DeployScripts/CorregirDNIs/corregirBanderasDNIs.py")
        print("- (10) -> !FICHERO TXT CON LOS RESULTADOS DE LAS BANDERAS GENERADO!")

    # Dificultad media
    if (opcion == "1" and seleccion=="2"):
        print("- (1) -> EJECUTANDO SCRIPT: apagarEscenario.py")
        os.system("python3 DeployScripts/Dificultad2-Media/apagarEscenario.py")
        print("- (1) -> !ESCENARIO DIFICULTAD MEDIA APAGADO!")
    elif (opcion == "2" and seleccion=="2"):
        print("- (2) -> EJECUTANDO SCRIPT: detenerEscenario.py")
        os.system("python3 DeployScripts/Dificultad2-Media/detenerEscenario.py")
        print("- (2) -> !ESCENARIO DIFICULTAD MEDIA DETENIDO!")
    elif (opcion == "3" and seleccion=="2"):
        print("- (3) -> EJECUTANDO SCRIPT: eliminarEscenario.py")
        os.system("python3 DeployScripts/Dificultad2-Media/eliminarEscenario.py")
        print("- (3) -> !ESCENARIO DIFICULTAD MEDIA ELIMINADO!")
    elif (opcion == "4" and seleccion=="2"):
        print("- (4) -> EJECUTANDO SCRIPT: iniciarEscenario.py")
        os.system("python3 DeployScripts/Dificultad2-Media/iniciarEscenario.py")
        print("- (4) -> !ESCENARIO DIFICULTAD MEDIA INICIADO!")
    elif (opcion == "5" and seleccion=="2"):
        print("- (5) -> EJECUTANDO SCRIPT: instalarEscenario.py")
        os.system("python3 DeployScripts/Dificultad2-Media/instalarEscenario.py")
        print("- (5) -> !ESCENARIO DIFICULTAD MEDIA INSTALADO!")
    elif (opcion == "8" and seleccion=="2"):
        print("- (8) -> EJECUTANDO SCRIPT: mostrarBanderas.py")
        os.system("python3 DeployScripts/Dificultad2-Media/mostrarBanderas.py")
        print("- (8) -> !FICHERO TXT CON LOS RESULTADOS DE LAS BANDERAS GENERADO!")
    elif (opcion == "9" and seleccion=="2"):
        print("- (9) -> EJECUTANDO SCRIPT: empaquetarVMs.py")
        os.system("python3 DeployScripts/Dificultad2-Media/empaquetarVMs.py")
    elif (opcion == "10" and seleccion=="2"):
        print("- (10) -> EJECUTANDO SCRIPT: corregirBanderasDNIs.py")
        os.system("python3 DeployScripts/CorregirDNIs/corregirBanderasDNIs.py")
        print("- (10) -> !FICHERO TXT CON LOS RESULTADOS DE LAS BANDERAS GENERADO!")

    # Dificultad avanzada
    if (opcion == "1" and seleccion=="3"):
        print("- (1) -> EJECUTANDO SCRIPT: apagarEscenario.py")
        os.system("python3 DeployScripts/Dificultad3-Avanzada/apagarEscenario.py")
        print("- (1) -> !ESCENARIO DIFICULTAD AVANZADA APAGADO!")
    elif (opcion == "2" and seleccion=="3"):
        print("- (2) -> EJECUTANDO SCRIPT: detenerEscenario.py")
        os.system("python3 DeployScripts/Dificultad3-Avanzada/detenerEscenario.py")
        print("- (2) -> !ESCENARIO DIFICULTAD AVANZADA DETENENIDO!")
    elif (opcion == "3" and seleccion=="3"):
        print("- (3) -> EJECUTANDO SCRIPT: eliminarEscenario.py")
        os.system("python3 DeployScripts/Dificultad3-Avanzada/eliminarEscenario.py")
        print("- (3) -> !ESCENARIO DIFICULTAD AVANZADA ELIMINADO!")
    elif (opcion == "4" and seleccion=="3"):
        print("- (4) -> EJECUTANDO SCRIPT: iniciarEscenario.py")
        os.system("python3 DeployScripts/Dificultad3-Avanzada/iniciarEscenario.py")
        print("- (4) -> !ESCENARIO DIFICULTAD AVANZADA INICIADO!")
    elif (opcion == "5" and seleccion=="3"):
        print("- (5) -> EJECUTANDO SCRIPT: instalarEscenario.py")
        os.system("python3 DeployScripts/Dificultad3-Avanzada/instalarEscenario.py")
        print("- (5) -> !ESCENARIO DIFICULTAD AVANZADA INSTALADO!")
    elif (opcion == "8" and seleccion=="3"):
        print("- (8) -> EJECUTANDO SCRIPT: mostrarBanderas.py")
        os.system("python3 DeployScripts/Dificultad3-Avanzada/mostrarBanderas.py")
        print("- (8) -> !FICHERO TXT CON LOS RESULTADOS DE LAS BANDERAS GENERADO!")
    elif (opcion == "9" and seleccion=="2"):
        print("- (9) -> EJECUTANDO SCRIPT: empaquetarVMs.py")
        os.system("python3 DeployScripts/Dificultad3-Avanzada/empaquetarVMs.py")
    elif (opcion == "10" and seleccion=="3"):
        print("- (10) -> EJECUTANDO SCRIPT: corregirBanderasDNIs.py")
        os.system("python3 DeployScripts/CorregirDNIs/corregirBanderasDNIs.py")
        print("- (10) -> !FICHERO TXT CON LOS RESULTADOS DE LAS BANDERAS GENERADO!")
    
    elif (opcion == "6"):
        print("\n")
        print("- (6) -> !SELECCIONE NUEVO NIVEL DE DIFICULTAD!")
        print("(1) DIFICULTAD FACIL")
        print("|     -> 1 maquina atacante")
        print("|     -> 4 maquinas que hackear")
        print("|     -> 4 banderas")
        print("|     -> X pistas")
        print("(2) DIFICULTAD MEDIA")
        print("|     -> 1 maquina atacante")
        print("|     -> 8 maquinas que hackear")
        print("|     -> 8 banderas")
        print("|     -> X pistas")
        print("(3) DIFICULTAD AVANZADA")
        print("|     -> 1 maquina atacante")
        print("|     -> 9 maquinas que hackear")
        print("|     -> 9 banderas")
        print("|     -> X pistas")

        seleccion = None
        while True:
            seleccion = input("Ingresa el numero correspondiente a la dificultad que deseas: .......... ")

            if seleccion in ["1", "2", "3"]:
                os.environ["SELECCION"] = seleccion
                break
            else:
                print("- !SELECCION NO VALIDA!")

        # Generamos las IPs del escenario.
        ip_addresses = generate_ip_addresses(dni, seleccion)

        # Generamos banderas del escenario.
        bandera1 = generar_banderas(dni, 1, seleccion)
        bandera2 = generar_banderas(dni, 2, seleccion)
        bandera3 = generar_banderas(dni, 3, seleccion)
        bandera4 = generar_banderas(dni, 4, seleccion)
        bandera5 = generar_banderas(dni, 5, seleccion)
        bandera6 = generar_banderas(dni, 6, seleccion)
        bandera7 = generar_banderas(dni, 7, seleccion)
        bandera8 = generar_banderas(dni, 8, seleccion)
        bandera9 = generar_banderas(dni, 9, seleccion)

        # Generamos los nombres para las virtual machines.
        usuario, contraseña = generar_usuario_y_contraseña_vm1(dni, seleccion)
        vm3_username1 = generar_usuario_vm3(dni, seleccion, 'Wordlists/vm3_user.txt')
        vm4_username1 = generar_usuarios(nombres, dni, 4, 1, seleccion)
        vm4_username2 = generar_usuarios(nombres, dni, 4, 2, seleccion)
        vm5_username1 = generar_usuarios(nombres, dni, 5, 1, seleccion)
        vm5_username2 = generar_usuarios(nombres, dni, 5, 2, seleccion)
        vm6_ftp_user = generar_usuarios(nombres, dni, 6, 60, seleccion)

        # Generamos las passwords para los usuarios de las virtual machines.
        vm4_password1 = generar_contraseña_wordlist(dni, seleccion, 4, 1, "Wordlists/rockyou.txt")
        vm5_password1 = generar_contraseña_wordlist(dni, seleccion, 5, 1, "Wordlists/rockyou.txt")
        vm5_password2 = generar_contraseña_wordlist(dni, seleccion, 5, 1, "Wordlists/common.txt")
        vm6_ftp_pass = generar_contraseña_wordlist(dni, seleccion, 6, 1, "Wordlists/ftp_password.txt")

        # Establecemos el DNI y dificultad como variables de entorno.
        os.environ["DNI"] = dni
        os.environ["SELECCION"] = seleccion

        # Establecemos las banderas como variables de entorno.
        os.environ["BANDERA1"] = bandera1
        os.environ["BANDERA2"] = bandera2
        os.environ["BANDERA3"] = bandera3
        os.environ["BANDERA4"] = bandera4
        os.environ["BANDERA5"] = bandera5
        os.environ["BANDERA6"] = bandera6
        os.environ["BANDERA7"] = bandera7
        os.environ["BANDERA8"] = bandera8
        os.environ["BANDERA9"] = bandera9

        # Establecemos los usuarios como variables de entorno.
        os.environ['VM1_USERNAME'] = usuario
        os.environ['VM3_USERNAME1'] = vm3_username1
        os.environ["VM4_USERNAME1"] = vm4_username1
        os.environ["VM4_USERNAME2"] = vm4_username2
        os.environ["VM5_USERNAME1"] = vm5_username1
        os.environ["VM5_USERNAME2"] = vm5_username2
        os.environ["VM6_FTP_USER"] = vm6_ftp_user

        # Establecemos las passwords para los usuarios de las virtual machines como variables de entorno.
        os.environ['VM1_PASSWORD'] = contraseña
        os.environ['VM4_PASSWORD1'] = vm4_password1
        os.environ['VM5_PASSWORD1'] = vm5_password1
        os.environ['VM5_PASSWORD2'] = vm5_password2
        os.environ['VM6_FTP_PASS'] = vm6_ftp_pass

        # Mensaje correspondiente a la selección.
        mensaje_seleccionado = ""
        if seleccion == "1":
            mensaje_seleccionado = "DIFICULTAD FACIL"
        elif seleccion == "2":
            mensaje_seleccionado = "DIFICULTAD MEDIA"
        elif seleccion == "3":
            mensaje_seleccionado = "DIFICULTAD AVANZADA"
        
        # Imprimir el mensaje con la dificultad seleccionada.
        print("- ¡Dificultad cambiada correctamente! -> ({}) {}".format(seleccion, mensaje_seleccionado))
    
    elif (opcion == "7" and seleccion=="1"):
        print("- (7) -> EJECUTANDO SCRIPT: informacionEscenario.py")
        print("\n")
        print("DOCUMENTACION DIFICULTAD FACIL")
        os.system("python3 DeployScripts/Dificultad1-Facil/informacionEscenario.py")
    elif (opcion == "7" and seleccion=="2"):
        print("- (7) -> EJECUTANDO SCRIPT: informacionEscenario.py")
        print("\n")
        print("DOCUMENTACION DIFICULTAD MEDIA")
        os.system("python3 DeployScripts/Dificultad2-Media/informacionEscenario.py")
    elif (opcion == "7" and seleccion=="3"):
        print("- (7) -> EJECUTANDO SCRIPT: informacionEscenario.py")
        print("\n")
        print("DOCUMENTACION DIFICULTAD AVANZADA")
        os.system("python3 DeployScripts/Dificultad3-Avanzada/informacionEscenario.py")

    elif (opcion == "11"):
        continuar = False
        break

    while True:
        print("--------------------------------------------------------------------------------------")
        print("\n")
        print("¿Desea realizar alguna otra accion?")
        print("(1) -> SI")
        print("(2) -> NO")
        continuar2 = input("Ingresa el numero correspondiente: ")

        if continuar2 == "2":
            print("- SE HA SALIDO DEL LABORATORIO EXITOSAMENTE")
            print("--------------------------------------------------------------------------------------")
            continuar == False
            break
        elif (continuar2 != "1" and continuar2 != "2"):
            print("- !SELECCION NO VALIDA!")
        else:
            print("--------------------------------------------------------------------------------------")
            print("\n")
            # Solicitar al usuario que elija una opción.
            print("{}".format(mensaje_seleccionado))
            print("-----------------------")
            print("Selecciona una opcion:")
            print("(1)  -> Apagar Escenario")
            print("(2)  -> Detener Escenario")
            print("(3)  -> Eliminar Escenario")
            print("(4)  -> Iniciar Escenario")
            print("(5)  -> Instalar Escenario")
            print("(6)  -> Cambiar Dificultad Escenario")
            print("(7)  -> Informacion acerca del Escenario")
            print("(8)  -> Mostrar resultados de las banderas")
            print("(9)  -> Empaquetar maquinas virtuales")
            print("(10) -> Corregir banderas de listado de DNIs")
            print("(11) -> SALIR")
            opcion = input("Ingresa el numero correspondiente a la accion que deseas realizar: .......... ")
            continuar == True
            break
    if continuar2 == "2":
        break

print("SE HA SALIDO CORRECTAMENTE")