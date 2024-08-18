import subprocess
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


# Vagrant destroy para eliminar las máquinas del escenario.
print("\n")
subprocess.run(["vagrant", "destroy", "-f", f"vm1_{dni}_{dificultad}", f"vm2_{dni}_{dificultad}", f"vm3_{dni}_{dificultad}", f"vm4_{dni}_{dificultad}", f"vm5_{dni}_{dificultad}", f"vm6_{dni}_{dificultad}", f"vm7_{dni}_{dificultad}", f"vm8_{dni}_{dificultad}", f"vm9_{dni}_{dificultad}"])
print("\n")