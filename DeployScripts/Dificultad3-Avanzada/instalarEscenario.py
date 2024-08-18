import subprocess
import os
import shutil
import time
import re


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


# Obtenemos los usuarios del escenario.
vm1_username = os.getenv('VM1_USERNAME')
vm3_username1 = os.getenv('VM3_USERNAME1')
vm4_username1 = os.getenv('VM4_USERNAME1')
vm5_username1 = os.getenv('VM5_USERNAME1')
vm5_username2 = os.getenv('VM5_USERNAME2')
vm6_ftp_user = os.getenv('VM6_FTP_USER')


# Obtenemos las contraseñas de los usuarios del escenario.
vm1_password = os.getenv('VM1_PASSWORD')
vm3_password1 = os.getenv('VM3_PASSWORD1')
vm4_password1 = os.getenv('VM4_PASSWORD1')
vm5_password1 = os.getenv('VM5_PASSWORD1')
vm5_password2 = os.getenv('VM5_PASSWORD2')


# Definir la variable de dificultad basada en el valor de 'SELECCION'.
if seleccion == '1':
    dificultad = 'difFacil'
elif seleccion == '2':
    dificultad = 'difMedia'
elif seleccion == '3':
    dificultad = 'difAvanzada'
else:
    raise ValueError("El valor de 'SELECCION' no es válido")


# Función para eliminar ficheros autogenerados residuales que no necesitamos.
def eliminar_ruta_si_existe(ruta):
    if os.path.exists(ruta):
        if os.path.isfile(ruta):
            os.remove(ruta)
            print("")
        elif os.path.isdir(ruta):
            shutil.rmtree(ruta)
            print("")
    else:
        print("")


# Lista de rutas que deseas eliminar.
rutas_a_eliminar = [
    "roles",
    "group_vars",
    "hosts.yml",
    "playbook.yml",
    "ansible.cfg",
    "ubuntu-xenial-16.04-cloudimg-console.log"
]


# Itera sobre la lista y elimina cada ruta si existe.
for ruta in rutas_a_eliminar:
    eliminar_ruta_si_existe(ruta)


# Instalación de Paramiko una librería de python para conectarnos por SSH a las vm.
print("Instalamos Paramiko:")
subprocess.run(["pip", "install", "paramiko"])
import paramiko # type: ignore
print("\n")


# Función para eliminar el usuario vagrant usando SSH
def eliminar_usuario_vagrant(vm_name, port):
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    
    try:
        if vm_name == f"vm1_{dni}_{dificultad}":
            ssh.connect('127.0.0.1', port=port, username=vm1_username, password=vm1_password)
            passwd = vm1_password
        if vm_name == f"vm2_{dni}_{dificultad}":
            ssh.connect('127.0.0.1', port=port, username='AdminPruebas', password='AdMinistRat0r1')
            passwd = 'AdMinistRat0r1'
        if vm_name == f"vm3_{dni}_{dificultad}":
            ssh.connect('127.0.0.1', port=port, username=vm3_username1, password=vm3_password1)
            passwd = vm3_password1
        if vm_name == f"vm4_{dni}_{dificultad}":
            ssh.connect('127.0.0.1', port=port, username=vm4_username1, password=vm4_password1)
            passwd = vm4_password1
        if vm_name == f"vm5_{dni}_{dificultad}":
            ssh.connect('127.0.0.1', port=port, username=vm5_username1, password=vm5_password1)
            passwd = vm5_password1
        if vm_name == f"vm6_{dni}_{dificultad}":
            ssh.connect('127.0.0.1', port=port, username="AdminFTP", password="ju4n8019802")
            passwd = vm5_password1
        if vm_name == f"vm7_{dni}_{dificultad}":
            ssh.connect('127.0.0.1', port=port, username="adminSecret", password="S3cr3t1X!")
            passwd = vm5_password1
        if vm_name == f"vm8_{dni}_{dificultad}":
            ssh.connect('127.0.0.1', port=port, username="JuanPe94", password="Juan123xx")
            passwd = vm5_password1
        if vm_name == f"vm9_{dni}_{dificultad}":
            ssh.connect('127.0.0.1', port=port, username="AdminIT", password="AdMiN9021")
            passwd = vm5_password1
        if vm_name == f"vm10_{dni}_{dificultad}":
            ssh.connect('127.0.0.1', port=port, username="012991", password="AdMiN9021")
            passwd = vm5_password1

        # Terminar procesos del usuario vagrant
        command = f'echo "{passwd}" | sudo -S pkill -u vagrant'
        stdin, stdout, stderr = ssh.exec_command(command)
        stdout.channel.recv_exit_status()  # Esperar a que el comando termine
        
        # Eliminar usuario vagrant
        command = f'echo "{passwd}" | sudo -S userdel -r vagrant 2>/dev/null'
        stdin, stdout, stderr = ssh.exec_command(command)
        stdout.channel.recv_exit_status()  # Esperar a que el comando termine
        
        # Capturar salidas para diagnosticar problemas
        out = stdout.read().decode()
        err = stderr.read().decode()
        
        if "user vagrant is currently used by process" in err:
            print(f"Error al eliminar el usuario 'vagrant' en {vm_name}: {err}")
        elif err:
            if f"Could not chdir to home directory /home/{vm3_username1}" in err:
                print(f"Usuario 'vagrant' eliminado correctamente en {vm_name}.")
            if f"Could not chdir to home directory /home/AdminFTP" in err:
                print(f"Usuario 'vagrant' eliminado correctamente en {vm_name}.")
            if f"Could not chdir to home directory /home/JuanPe94" in err:
                print(f"Usuario 'vagrant' eliminado correctamente en {vm_name}.")
            if f"Could not chdir to home directory /home/AdminIT" in err:
                print(f"Usuario 'vagrant' eliminado correctamente en {vm_name}.")
            else:
                print(f"Error inesperado al eliminar el usuario 'vagrant' en {vm_name}: {err}")
        else:
            print(f"Usuario 'vagrant' eliminado correctamente en {vm_name}")
    
    except Exception as e:
        print(f"Error al conectar a {vm_name} en el puerto {port}: {e}")
    finally:
        ssh.close()


# Función para obtener el puerto SSH dinámicamente asignado por Vagrant
def obtener_puerto_ssh(vm_name):
    result = subprocess.run(["vagrant", "port", vm_name], capture_output=True, text=True)
    if result.returncode != 0:
        raise RuntimeError(f"Error obteniendo el puerto SSH para {vm_name}: {result.stderr}")
    
    # Buscar el puerto SSH en la salida
    matches = re.findall(r"22 \(guest\) => (\d+) \(host\)", result.stdout)
    if matches:
        # Tomar el primer puerto 
        if vm_name == f"vm3_{dni}_{dificultad}":
            return int(matches[0])
        else:
            return int(matches[0])
    else:
        raise RuntimeError(f"No se pudo encontrar el puerto SSH en la salida: {result.stdout}")


# Función para desplegar una máquina virtual y eliminar el usuario vagrant
def desplegar_y_eliminar_usuario(vm_index):
    vm_name = f"vm{vm_index}_{dni}_{dificultad}"
    # subprocess.run(["export", "VAGRANT_LOG=DEBUG"])
    subprocess.run(["vagrant", "up", vm_name])
    
    # Esperar a que la VM esté completamente desplegada y SSH esté listo
    time.sleep(20)
    
    puerto_ssh = obtener_puerto_ssh(vm_name)
    eliminar_usuario_vagrant(vm_name, puerto_ssh)

    # Itera sobre la lista y elimina cada ruta si existe
    for ruta in rutas_a_eliminar:
        eliminar_ruta_si_existe(ruta)


# Desplegar y eliminar usuario en las 10 máquinas virtuales
for i in range(1, 11):
    desplegar_y_eliminar_usuario(i)