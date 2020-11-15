clear
echo "Bienvenido al programa de instalación del sistema."
if [ ! -f "./instalarTP.conf" ] #Vemos si existe el archivo de configuración del sistema.
then #Caso en el que no existe. Realizamos la instalación.
    echo "Comenzando configuración para la instalación del sistema."
	reservados=../original/auxiliares/nombres_reservados.txt
	ingresados=../original/auxiliares/nombres_ingresados.txt
	
	ejecutables_default="bin"
	tablas_default="master"
	novedades_default="input"
	rechazados_default="rechazos"
	lotes_default="lotes"
	resultados_default="output"
	
	instalar="No"
	
	while [ "$instalar" = "No" ] ; do
	
	    if [ -f $ingresados ]
	    then
	        rm $ingresados
	    fi
	    
	    read -p "Ingrese un nombre para el directorio de ejecutables (en caso de dejar en blanco, se utilizará el nombre por default \"$ejecutables_default\"): `echo $'\n> '`" ejecutables_temp
	    while grep -Fxq "$ejecutables_temp" $reservados ; do
	        echo "El nombre \"$ejecutables_temp\" no está permitido debido a que el directorio ya existe."
	        read -p "Ingrese un nombre para el directorio de ejecutables (en caso de dejar en blanco, se utilizará el nombre por default \"$ejecutables_default\"): `echo $'\n> '`" ejecutables_temp
	    done
	    if [[ -z "$ejecutables_temp" ]] ; then
	        ejecutables_temp=$ejecutables_default
	    fi
	    ejecutables_default=$ejecutables_temp
	    echo $ejecutables_temp > $ingresados
	
	    read -p "Ingrese un nombre para el directorio de tablas del sistema (en caso de dejar en blanco, se utilizará el nombre por default \"$tablas_default\"): `echo $'\n> '`" tablas_temp
	    while grep -Fxq "$tablas_temp" $reservados || grep -Fxq "$tablas_temp" $ingresados ; do
	        if grep -Fxq "$tablas_temp" $reservados
	        then
	            echo "El nombre \"$tablas_temp\" no está permitido debido a que el directorio ya existe."
	        else
	            echo "EL nombre \"$tablas_temp\" ya fue seleccionado para otro directorio."
	        fi
		    read -p "Ingrese un nombre para el directorio de tablas del sistema (en caso de dejar en blanco, se utilizará el nombre por default \"$tablas_default\"): `echo $'\n> '`" tablas_temp
	    done
	    if [[ -z "$tablas_temp" ]] ; then
	        tablas_temp=$tablas_default
	    fi
	    tablas_default=$tablas_temp
	    echo $tablas_temp >> $ingresados
	
	    read -p "Ingrese un nombre para el directorio de novedades (en caso de dejar en blanco, se utilizará el nombre por default \"$novedades_default\"): `echo $'\n> '`" novedades_temp
	    while  grep -Fxq "$novedades_temp" $reservados || grep -Fxq "$novedades_temp" $ingresados ; do
	        if grep -Fxq "$novedades_temp" $reservados
	        then
	            echo "El nombre \"$novedades_temp\" no está permitido debido a que el directorio ya existe."
	        else
	            echo "EL nombre \"$novedades_temp\" ya fue seleccionado para otro directorio."
	        fi
		    read -p "Ingrese un nombre para el directorio de novedades (en caso de dejar en blanco, se utilizará el nombre por default \"$novedades_default\"): `echo $'\n> '`" novedades_temp
	    done
	    if [[ -z "$novedades_temp" ]] ; then
	        novedades_temp=$novedades_default
	    fi
	    novedades_default=$novedades_temp
	    echo $novedades_temp >> $ingresados
	
	    read -p "Ingrese un nombre para el directorio de archivos rechazados (en caso de dejar en blanco, se utilizará el nombre por default \"$rechazados_default\"): `echo $'\n> '`" rechazados_temp
	    while  grep -Fxq "$rechazados_temp" $reservados || grep -Fxq "$rechazados_temp" $ingresados ; do
	        if grep -Fxq "$rechazados_temp" $reservados
	        then
	            echo "El nombre \"$rechazados_temp\" no está permitido debido a que el directorio ya existe."
	        else
	            echo "EL nombre \"$rechazados_temp\" ya fue seleccionado para otro directorio."
	        fi
		    read -p "Ingrese un nombre para el directorio de archivos rechazados (en caso de dejar en blanco, se utilizará el nombre por default \"$rechazados_default\"): `echo $'\n> '`" rechazados_temp
	    done
	    if [[ -z "$rechazados_temp" ]] ; then
	        rechazados_temp=$rechazados_default
	    fi
	    rechazados_default=$rechazados_temp
	    echo $rechazados_temp >> $ingresados
	
	    read -p "Ingrese un nombre para el directorio de lotes procesados (en caso de dejar en blanco, se utilizará el nombre por default \"$lotes_default\"): `echo $'\n> '`" lotes_temp
	    while  grep -Fxq "$lotes_temp" $reservados || grep -Fxq "$lotes_temp" $ingresados ; do
	        if grep -Fxq "$lotes_temp" $reservados
	        then
	            echo "El nombre \"$lotes_temp\" no está permitido debido a que el directorio ya existe."
	        else
	            echo "EL nombre \"$lotes_temp\" ya fue seleccionado para otro directorio."
	        fi
		    read -p "Ingrese un nombre para el directorio de lotes procesados (en caso de dejar en blanco, se utilizará el nombre por default \"$lotes_default\"): `echo $'\n> '`" lotes_temp
	    done
	    if [[ -z "$lotes_temp" ]] ; then
	        lotes_temp=$lotes_default
	    fi
	    lotes_default=$lotes_temp
	    echo $lotes_temp >> $ingresados
	
	    read -p "Ingrese un nombre para el directorio de resultados (en caso de dejar en blanco, se utilizará el nombre por default \"$resultados_default\"): `echo $'\n> '`" resultados_temp
	    while  grep -Fxq "$resultados_temp" $reservados || grep -Fxq "$resultados_temp" $ingresados ; do
	        if grep -Fxq "$resultados_temp" $reservados
	        then
	            echo "El nombre \"$resultados_temp\" no está permitido debido a que el directorio ya existe."
	        else
	            echo "EL nombre \"$resultados_temp\" ya fue seleccionado para otro directorio."
	        fi
	    	read -p "Ingrese un nombre para el directorio de resultados (en caso de dejar en blanco, se utilizará el nombre por default \"$resultados_default\"): `echo $'\n> '`" resultados_temp
	    done
	    if [[ -z "$resultados_temp" ]] ; then
	        resultados_temp=$resultados_default
	    fi
	    resultados_default=$resultados_temp
	    echo $resultados_temp >> $ingresados
	    
	    clear
	    echo "Tipo de proceso:                          INSTALACIÓN"
	    echo "Directorio padre:                         $(dirname `pwd`)"
	    echo "Ubicación script de instalación:          `pwd`/instalarTP.sh"
	    echo "Log de la instalación:                    `pwd`/instalarTP.log"
	    echo "Archivo de configuración:                 `pwd`/instalarTP.conf"
	    echo "Log de inicialización:                    `pwd`/iniciarambiente.log"
	    echo "Log del proceso principal:                `pwd`/pprincipal.log"
	    echo "Directorio de ejecutables:                $(dirname `pwd`)/$ejecutables_default"
	    echo "Directorio de tablas maestras:            $(dirname `pwd`)/$tablas_default"
	    echo "Directorio de novedades:                  $(dirname `pwd`)/$novedades_default"
	    echo "Directorio de novedades aceptadas:        $(dirname `pwd`)/$novedades_default/ok"
	    echo "Directorio de rechazados:                 $(dirname `pwd`)/$rechazados_default"
	    echo "Directorio de lotes procesados:           $(dirname `pwd`)/$lotes_default"
	    echo "Directorio de transacciones:              $(dirname `pwd`)/$resultados_default"
	    echo "Directorio de comisiones:                 $(dirname `pwd`)/$resultados_default/comisiones"
	    echo "Estado de la instalación:                 LISTA"
	    echo ""
	    
	    read -p "¿Confirma la instalación? (Y/N) `echo $'\n> '`" respuesta
	    while [[ "$respuesta" != "Y" && "$respuesta" != "y" && "$respuesta" != "N" && "$respuesta" != "n" ]] ; do
	        echo "Respuesta invalida."
	        read -p "¿Confirma la instalación? (Y/N) `echo $'\n> '`" respuesta
	    done
	    
	    if [[ "$respuesta" = "Y" || "$respuesta" = "y" ]] ; then
	        instalar="Yes"
	    fi
	    
	    clear
	done
	
	#Creamos los directorios.
	echo "Creando directorio de ejecutables."
	mkdir $(dirname `pwd`)/$ejecutables_default
	echo "Creando directorio de tablas del sistema."
	mkdir $(dirname `pwd`)/$tablas_default
	echo "Creando directorio de novedades."
	mkdir $(dirname `pwd`)/$novedades_default
	mkdir $(dirname `pwd`)/$novedades_default/ok
	echo "Creando directorio de archivos rechazados."
	mkdir $(dirname `pwd`)/$rechazados_default
	echo "Creando directorio de lotes procesados."
	mkdir $(dirname `pwd`)/$lotes_default
	echo "Creando directorio de resultados."
	mkdir $(dirname `pwd`)/$resultados_default
	mkdir $(dirname `pwd`)/$resultados_default/comisiones
	
	#Copiamos las tablas maestras y los archivos ejecutables.
	cp ../original/tablasmaestras/comercios.txt $(dirname `pwd`)/$tablas_default/comercios.txt
	cp ../original/tablasmaestras/tarjetashomologadas.txt $(dirname `pwd`)/$tablas_default/tarjetashomologadas.txt
	
	echo "Estado de la instalación:                     COMPLETADA"
	
else #Caso en el que existe. Vemos si se debe reparar el sistema o no.
	echo "Ver si hay que reparar."
fi
