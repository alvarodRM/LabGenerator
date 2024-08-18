# PowerShell script to replicate the Bash script output


# Define the multi-line string
$asciiArt = @"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
INICIO INSTALACION (1/1) VM7: rapid7/metasploitable3-win2k8 (Client3-RedProduccion)
"@


# Output the multi-line string
Write-Host $asciiArt


# Obtener el valor de las variables de entorno.
$dni = $env:DNI
$seleccion = $env:SELECCION
$ip_vm6 = $env:IP_VM6
$ip_vm7 = $env:IP_VM7
$ip_vm8 = $env:IP_VM8
$bandera6 = $env:BANDERA6


# Mostrar las variables de entorno.
Write-Host "El valor del DNI es: $dni"
Write-Host "Codigo secreto de la bandera 6: $bandera6"
Write-Host "La IP de VM7 es: $ip_vm7"


# Inicializar una variable para almacenar el valor hexadecimal con espacios.
$bandera6Hex = ""
$ip_vm8Hex = ""


# Convertir cada carácter de la cadena a su valor hexadecimal.
foreach ($char in $bandera6.ToCharArray()) {
    $bandera6Hex += [Convert]::ToString([int][char]$char, 16).PadLeft(2, '0') + " "
}


# Convertir cada carácter de la cadena a su valor hexadecimal.
foreach ($char in $ip_vm8.ToCharArray()) {
    $ip_vm8Hex += [Convert]::ToString([int][char]$char, 16).PadLeft(2, '0') + " "
}


# Imprimir el valor hexadecimal de la bandera con espacios.
Write-Host "Valor hexadecimal de la bandera 6: $bandera6Hex"
Write-Host "Valor hexadecimal de la IP VM8: $ip_vm8Hex"


# Remover el último espacio extra.
$bandera6Hex = $bandera6Hex.TrimEnd()
$ip_vm8Hex = $ip_vm8Hex.TrimEnd()


# Creamos las carpetas para ocultar las pistas y la bandera.
mkdir /secret
mkdir /confidencial1
mkdir /confidencial2
mkdir /confidencial3
mkdir /confidencial4
mkdir /confidencial5
mkdir /confidencial6
mkdir /confidencial7
mkdir /confidencial8
mkdir /confidencial9
mkdir /confidencial10


# Creación de un usuario administrador.
$adminUser = "adminSecret"
$adminPassword = "S3cr3t1X!"


# Creación del usuario.
net user $adminUser $adminPassword /add


# Añadimos el usuario al grupo de administradores.
net localgroup Administrators $adminUser /add


# Define el mensaje y los nombres de los archivos.
$message = "no hay nada, picaste ;)"
$filenames = @("passwords.txt", "facturas.txt", "importante.txt")


# Crea el mensaje en cada archivo y muévelos a los directorios correspondientes.
for ($i = 1; $i -le 10; $i++) {
    foreach ($file in $filenames) {
        # Escribir el mensaje en el archivo.
        echo $message >> $file
        
        # Mover el archivo al directorio correspondiente.
        $destination = "/confidencial$i/$file"
        mv $file $destination
    }
}


# Creación de la bandera con el contenido en formato hexadecimal.
echo "46 65 6C 69 63 69 74 61 63 69 6F 6E 65 73 20 68 61 73 20 65 6E 63 6F 6E 74 72 61 64 6F 20 6C 61 20 73 65 78 74 61 20 62 61 6E 64 65 72 61 20 64 65 6C 20 65 73 63 65 6E 61 72 69 6F 21" >> flag6.txt
echo "53 69 20 68 61 73 20 6C 6C 65 67 61 64 6F 20 68 61 73 74 61 20 61 71 75 ED 20 65 73 20 71 75 65 20 65 72 65 73 20 72 65 61 6C 6D 65 6E 74 65 20 62 75 65 6E 6F 2F 61 2E" >> flag6.txt
echo "43 F3 64 69 67 6F 20 73 65 63 72 65 74 6F 20 64 65 6C 20 46 6C 61 67 36 3A 20 $bandera6Hex" >> flag6.txt


# Creación de la pista con el contenido en formato hexadecimal.
echo "50 49 53 54 41 3A 20 4C 61 20 73 69 67 75 69 65 6E 74 65 20 62 61 6E 64 65 72 61 20 6C 61 20 65 6E 63 6F 6E 74 72 61 72 61 73 20 65 6E 20 6C 61 20 49 50 20 2D 3E $ip_vm8Hex" >> pistas.txt
echo "52 65 76 69 73 65 20 6C 6F 73 20 73 65 72 76 69 63 69 6F 73 20 76 75 6C 6E 65 72 61 62 6C 65 73 20 64 65 20 64 69 63 68 61 20 6D 61 71 75 69 6E 61 20 79 20 63 6F 6E 73 69 67 61 20 70 65 72 6D 69 73 6F 73 20 64 65 20 61 64 6D 69 6E 69 73 74 72 61 64 6F 72 20 64 65 6C 20 73 69 73 74 65 6D 61 2E 20 53 65 20 72 65 63 6F 6D 69 65 6E 64 61 20 75 74 69 6C 69 7A 61 72 20 4D 65 74 61 73 70 6C 6F 69 74" >> pistas.txt
echo "4C 61 20 62 61 6E 64 65 72 61 20 73 69 65 74 65 20 6C 61 20 65 6E 63 6F 6E 74 72 61 72 61 73 20 65 6E 20 65 6C 20 73 69 73 74 65 6D 61 20 64 65 20 66 69 63 68 65 72 6F 73 20 64 65 20 64 69 63 68 61 20 6D 61 71 75 69 6E 61 2E 20 53 75 65 72 74 65 20 3B 29" >> pistas.txt


# Movemos los ficheros a la carpeta secret.
mv flag6.txt /secret/flag6.txt
mv pistas.txt /secret/pistas.txt


# Define the multi-line string
$asciiArt = @"
 __      _
/ _\ ___| |_ _   _ _ __
\ \ / _ \ __| | | | '_ \
_\ \  __/ |_| |_| | |_) |
\__/\___|\__|\__,_| .__/
                  |_|
FIN INSTALACION (1/1) VM7: rapid7/metasploitable3-win2k8 (Client3-RedProduccion)
"@


# Output the multi-line string
Write-Host $asciiArt