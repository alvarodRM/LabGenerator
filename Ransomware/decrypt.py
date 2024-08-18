from cryptography.fernet import Fernet # type: ignore
import os


# Esta función carga la clave de encriptación almacenada en un archivo 'key.key'. 
def cargar_key():
    # Abre el archivo 'key.key' en modo de lectura binaria y lee su contenido.
    return open('key.key', 'rb').read()


# Función que desencripta una lista de archivos utilizando la clave proporcionada.
def decrypt(items, key):
    f = Fernet(key)
    for item in items:
        with open(item, 'rb') as file: # iteramos en cada fichero.
            encrypted_data = file.read()
        decrypted_data = f.decrypt(encrypted_data) # Desencripta los datos leídos.
        with open(item, 'wb') as file:
            file.write(decrypted_data)


if __name__ == '__main__':

    # Define el directorio cuyo contenido será desencriptado.
    path_to_encrypt = '/home'

    # Elimina el archivo 'readme.txt' en el directorio especificado.
    os.remove(path_to_encrypt+'\\'+'readme.txt')

    # Lista todos los elementos en el directorio especificado.
    items = os.listdir(path_to_encrypt) 

    # Crea una lista de rutas completas para cada elemento.
    full_path = [path_to_encrypt+'\\'+item for item in items]

    # Carga la clave de desencriptación desde el archivo 'key.key'.
    key = cargar_key()

    # Desencripta los archivos en la lista 'full_path' utilizando la clave cargada.
    decrypt(full_path, key)