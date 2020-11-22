# Sistemas Operativos TP1
## Grupo 2
### Lisandro Torresetti, 99846
### Ignacio Carol Lugones, 100073
### Nahuel Minino, 99599


#### Guía para acceder al TP:

1. Acceda al repositorio de Github.
1.1 Ingrese con un navegador de internet a la página https://github.com/IgnacioCarol/SisopTp

#### Guía para la descarga del sistema:

Para descargar el entorno para la instalación y ejecución del sistema se deben seguir los siguientes pasos.

1. Descargue los archivos del sistema

1.1 Abra una terminal y tipee "git clone https://github.com/IgnacioCarol/SisopTp.git"

1.2 Allí encontrará el directorio "Grupo2" con todos los subdirectorios y archivos necesarios para la correcta ejecución del programa

2. Descargue el .zip

2.1 Otra opción es seleccionar la opción "Download zip" desde el repositorio de Github

#### Guía para la instalación del sistema:

Para instalar el sistema de procesamiento de archivos se deben seguir los siguientes pasos.

1. Abra una terminal y navegue hasta el directorio Grupo2 (donde se descargó el programa)

1.1 Tipee "cd Grupo2"

2. Moverse al directorio so7508

2.1 Tipee "cd so7508"

3. Ejecutar el script de instalación del sistema

3.1 Tipee ./instalarTP.sh

4. Ingrese los nombres de los directorios del sistema

4.1 Ingrese uno a uno los nombres indicados por el programa

4.2 No se permite usar los nombres reservados "Grupo2", "so7508", "catedra", "original", "propios" ni "testeos"

4.3 No se permite usar el mismo nombre para distintos directorios (por ejemplo, el mismo nombre para el directorio de ejecutables y el directorio de novedades)

4.4 No se permite usar los caracteres "." o "/" en los nombres

5. Confirme la instalación

5.1 Se le presentará la lista de directorios a crear, si está de acuerdo con los mismos, confirme la instalación ingresando "Y" o "y"

5.2 En caso de que quiera realizar algún cambio, puede rechazar la instalación ingresando "N" o "n" y volver a ingresar los nombres de los directorios

6. Sistema instalado

6.1 Una vez haya finalizado la instalación se le informará por pantalla

6.2 Luego de la instalación, va a encontrar los directorios de ejecutables (en donde se encuentran los archivos ejecutables para correr el programa), de tablas del sistema (donde se encuentran los maestros con la información utilizada para validar el input y generar la salida), de novedades (en donde arriban los archivos que nos envían los comerciantes, y a su vez tiene un subdirectorio con los archivos con formato "válido" para su procesamiento), de rechazados (a donde se envían los archivos que no pasan la validación del sistema), de lotes procesados (en donde se envían los archivos que terminan de procesarse) y de resultados (en donde se almacenan los archivos de salida del procesamiento)

### Guía para la reparación del sistema:

Para reparar el sistema en caso de que se borre algún directorio o archivo se deben seguir los siguientes pasos.

1. Abra una terminal y navegue hasta el directorio Grupo2 (donde se descargó el programa)

1.1 Tipee "cd Grupo2"

2. Moverse al directorio so7508

2.1 Tipee "cd so7508"

3. Ejecutar el script de instalación del sistema

3.1 Tipee ./instalarTP.sh

4. Confirmación de la reparación

4.1 El sistema detectará automáticamente los errores y presentará por pantalla los directorios resultantes luego de la reparación

4.2 En caso de estar de acuerdo, confirmar la reparación ingresando "Y" o "y"  y se le informará los errores y la forma en que se los solucionará

4.3 En caso de no estar de acuerdo, rechazar la reparación ingresando "N" o "n"

#### Guía para la inicialización del sistema:
