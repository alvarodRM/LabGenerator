import subprocess
import os
import dropbox # type: ignore
import dropbox.files # type: ignore


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


# Función para verificar si existe la máquina virtual en vagrant.
def check_vm_existence(nombre_vm):
    status_output = subprocess.run(["vagrant", "status", nombre_vm], capture_output=True, text=True)
    # Buscar la cadena "not created" en la salida del comando.
    if "not created" in status_output.stdout:
        return False
    else:
        return True


# Función para apagar y empaquetar las máquinas virtuales.
def package_vm(nombre_vm, nombre_salida, name):
    subprocess.run(["vagrant", "halt", name])
    subprocess.run(["vagrant", "package", "--output", nombre_vm, "--base", nombre_salida])


# Lista de nombres de las VMs.
nombres_vms = [f"vm{i}_{dni}_{dificultad}" for i in range(1, 10)]


# Verificar si todas las VMs existen y en caso correcto empaquetarlas en vagrant boxes.
if all(check_vm_existence(nombre_vm) for nombre_vm in nombres_vms):
    for nombre_vm in nombres_vms:
        if (nombre_vm == f"vm1_{dni}_{dificultad}"):
            package_vm(f"Boxes/{nombre_vm}.box", f"vm1-KaliLinux-Atacante_{dni}_{dificultad}", nombre_vm)
        if (nombre_vm == f"vm2_{dni}_{dificultad}"):
            package_vm(f"Boxes/{nombre_vm}.box", f"vm2-WebServer_{dni}_{dificultad}", nombre_vm)
        if (nombre_vm == f"vm3_{dni}_{dificultad}"):
            package_vm(f"Boxes/{nombre_vm}.box", f"vm3-WebServer_{dni}_{dificultad}", nombre_vm)
        if (nombre_vm == f"vm4_{dni}_{dificultad}"):
            package_vm(f"Boxes/{nombre_vm}.box", f"vm4-Client1_{dni}_{dificultad}", nombre_vm)
        if (nombre_vm == f"vm5_{dni}_{dificultad}"):
            package_vm(f"Boxes/{nombre_vm}.box", f"vm5-Client2_{dni}_{dificultad}", nombre_vm)
        if (nombre_vm == f"vm6_{dni}_{dificultad}"):
            package_vm(f"Boxes/{nombre_vm}.box", f"vm6-FTPServer_{dni}_{dificultad}", nombre_vm)
        if (nombre_vm == f"vm7_{dni}_{dificultad}"):
            package_vm(f"Boxes/{nombre_vm}.box", f"vm7-Client3_{dni}_{dificultad}", nombre_vm)
        if (nombre_vm == f"vm8_{dni}_{dificultad}"):
            package_vm(f"Boxes/{nombre_vm}.box", f"vm8-Client4_{dni}_{dificultad}", nombre_vm)
        if (nombre_vm == f"vm9_{dni}_{dificultad}"):
            package_vm(f"Boxes/{nombre_vm}.box", f"vm9-WebServer_{dni}_{dificultad}", nombre_vm)
    print("- (9) -> !MAQUINAS EMPAQUETADAS CORRECTAMENTE!")
else:
    print("Por favor, despliega todas las máquinas del escenario antes de ejecutar este script.")
    print("- (9) -> !LAS MAQUINAS NO HAN SIDO EMPAQUETADAS!")


# Definir la ruta local de las Vagrant boxes.
boxes_dir = "Boxes"


# Esta funcionalidad permite subir las máquinas virtuales empaquetadas a Dropbox.
while True:
    print("\n")
    seleccion_usuario = input("¿Desea subir las VMs a Dropbox? (1) para Sí, (2) para No: .....")
    if seleccion_usuario == '1':

        # Instalación de la librería de python para Dropbox.
        print("\n")
        print("INSTALANDO LIBRERIA DROPBOX API PARA PYTHON")
        subprocess.run(["pip", "install", "dropbox"])
        print("\n")

        # token de acceso personal de Dropbox
        with open("TOKEN.txt", "r") as f:
            token = f.read()

        dbx = dropbox.Dropbox(token, timeout=900)

        # Obtener la lista de archivos en el directorio local
        box_files = os.listdir(boxes_dir)

        # Nombre de la carpeta en Dropbox donde se guardarán los archivos
        dropbox_folder = "/Boxes"
        
        # Iterar sobre cada archivo en el directorio local
        for file_name in box_files:

            # Construir la ruta local completa del archivo
            local_path = os.path.join(boxes_dir, file_name)

            # Construir la ruta remota del archivo en Dropbox
            remote_path = f"{dropbox_folder}/{file_name}"  # Ruta relativa a la carpeta "Boxes"

            # Verificar si el archivo ya existe en Dropbox
            try:
                dbx.files_get_metadata(remote_path)
                print(f"El archivo {file_name} ya existe en Dropbox. No se subirá nuevamente.")
                continue
            except dropbox.exceptions.ApiError as e:
                if e.error.is_path() and e.error.get_path().is_not_found():
                    pass  # El archivo no existe, se puede subir
                else:
                    raise e
            
            # Subir el archivo a Dropbox en trozos
            with open(local_path, "rb") as f:
                file_size = os.path.getsize(local_path)
                chunk_size = 4 * 1024 * 1024  # Tamaño del trozo: 4 MB
                upload_session_start_result = dbx.files_upload_session_start(f.read(chunk_size))
                cursor = dropbox.files.UploadSessionCursor(session_id=upload_session_start_result.session_id,
                                                            offset=f.tell())
                commit = dropbox.files.CommitInfo(path=remote_path)

                while f.tell() < file_size:
                    if (file_size - f.tell()) <= chunk_size:
                        dbx.files_upload_session_finish(f.read(chunk_size), cursor, commit)
                    else:
                        dbx.files_upload_session_append(f.read(chunk_size), cursor.session_id, cursor.offset)
                        cursor.offset = f.tell()

            print(f"Archivo {file_name} subido correctamente a Dropbox en https://www.dropbox.com/home{remote_path}.")

        break
    elif seleccion_usuario == '2':
        print("\n")
        print("No se subirán las VMs empaquetadas a Dropbox.")
        break
    else:
        print("\n")
        print("Por favor, seleccione (1) para Sí o (2) para No.")