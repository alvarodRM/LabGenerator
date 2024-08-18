import csv
import hashlib
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


def generar_banderas(DNI, num_banderas, seleccion):
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


# Solicitar la lista de DNIs como input.
print("\n")
dnis = input("Ingrese una lista de DNIs separados por comas: ").split(",")


# Nombre del archivo donde se guardarán los resultados.
nombre_archivo = "resultados_DNIs.txt"
nombre_csv = "resultados_DNIs.csv"


# Generar resultados para cada DNI y escribir en el mismo archivo.
with open(nombre_archivo, 'w') as f_txt, open(nombre_csv, 'w', newline='') as f_csv:
    # Crear escritor CSV
    csv_writer = csv.writer(f_csv)
    csv_writer.writerow(["DNI", "Dificultad", "Número de bandera", "Código de bandera"])

    for dni in dnis:
        dni = dni.strip()  # Eliminar espacios en blanco al inicio y al final.
        
        f_txt.write("DNI: {}\n".format(dni))
        f_txt.write("--------------------------------------------\n")
        f_txt.write("\n")
        f_txt.write("DIFICULTAD FÁCIL:\n")

        for num_banderas in range(1, 5):
            codigo = generar_banderas(dni, num_banderas, "1")
            f_txt.write("Bandera{}:\t{}\n".format(num_banderas, codigo))
            csv_writer.writerow([dni, "Dificultad Fácil", num_banderas, codigo])

        f_txt.write("\n")
        f_txt.write("DIFICULTAD MEDIA:\n")

        for num_banderas in range(1, 9):
            codigo = generar_banderas(dni, num_banderas, "2")
            f_txt.write("Bandera{}:\t{}\n".format(num_banderas, codigo))
            csv_writer.writerow([dni, "Dificultad Media", num_banderas, codigo])

        f_txt.write("\n")
        f_txt.write("DIFICULTAD AVANZADA:\n")

        for num_banderas in range(1, 10):
            codigo = generar_banderas(dni, num_banderas, "3")
            f_txt.write("Bandera{}:\t{}\n".format(num_banderas, codigo))
            csv_writer.writerow([dni, "Dificultad Avanzada", num_banderas, codigo])

        f_txt.write("\n")


# Mensaje de logs con la ruta donde se han generado los ficheros resultado.
print("Se han generado los resultados para los DNIs en los archivos '{}' y '{}'".format(nombre_archivo, nombre_csv))