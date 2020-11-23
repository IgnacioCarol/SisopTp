clear
echo "Bienvenido al programa de instalación/reparación del sistema."
echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Bienvenido al programa de instalación/reparación del sistema.-instalarTP.sh-`users`" >> ./instalarTP.log
if [ ! -f "./instalarTP.conf" ] #Vemos si existe el archivo de configuración del sistema.
then #Caso en el que no existe. Realizamos la instalación.
    echo "Comenzando configuración para la instalación del sistema."
    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Comenzando configuración para la instalación del sistema.-instalarTP.sh-`users`" >> ./instalarTP.log
    
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
	
	    if [ -f $ingresados ]; then
	        rm $ingresados
	    fi
	    
	    read -p "Ingrese un nombre para el directorio de ejecutables (en caso de dejar en blanco, se utilizará el nombre por default \"$ejecutables_default\"): `echo $'\n> '`" ejecutables_temp
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ingrese un nombre para el directorio de ejecutables (en caso de dejar en blanco, se utilizará el nombre por default \"$ejecutables_default\"):-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$ejecutables_temp-instalarTP.sh-`users`" >> ./instalarTP.log
	    
	    while grep -Fxq "$ejecutables_temp" $reservados || [[ $ejecutables_temp == *"."* ]] || [[ $ejecutables_temp == *"/"* ]] ; do
	        if grep -Fxq "$ejecutables_temp" $reservados; then
	            echo "El nombre \"$ejecutables_temp\" no está permitido debido a que el directorio ya existe."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-El nombre \"$ejecutables_temp\" no está permitido debido a que el directorio ya existe.-instalarTP.sh-`users`" >> ./instalarTP.log
	        else
	            echo "No está permitido el uso de los caracteres "/" o "." para el nombre de los directorios."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No está permitido el uso de los caracteres "/" o "." para el nombre de los directorios.-instalarTP.sh-`users`" >> ./instalarTP.log
	        fi
	        
	        read -p "Ingrese un nombre para el directorio de ejecutables (en caso de dejar en blanco, se utilizará el nombre por default \"$ejecutables_default\"): `echo $'\n> '`" ejecutables_temp
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ingrese un nombre para el directorio de ejecutables (en caso de dejar en blanco, se utilizará el nombre por default \"$ejecutables_default\"):-instalarTP.sh-`users`" >> ./instalarTP.log
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$ejecutables_temp-instalarTP.sh-`users`" >> ./instalarTP.log
	    done
	    
	    if [[ -z "$ejecutables_temp" ]] ; then
	        ejecutables_temp=$ejecutables_default
	    fi
	    
	    ejecutables_temp=`echo "$ejecutables_temp" | sed "s/ /_/g"`
	    ejecutables_default=$ejecutables_temp
	    echo $ejecutables_temp > $ingresados
	
	    read -p "Ingrese un nombre para el directorio de tablas del sistema (en caso de dejar en blanco, se utilizará el nombre por default \"$tablas_default\"): `echo $'\n> '`" tablas_temp
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ingrese un nombre para el directorio de tablas del sistema (en caso de dejar en blanco, se utilizará el nombre por default \"$tablas_default\"):-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$tablas_temp-instalarTP.sh-`users`" >> ./instalarTP.log
	    
	    while grep -Fxq "$tablas_temp" $reservados || grep -Fxq "$tablas_temp" $ingresados || [[ $tablas_temp == *"."* ]] || [[ $tablas_temp == *"/"* ]] ; do
	        if grep -Fxq "$tablas_temp" $reservados
	        then
	            echo "El nombre \"$tablas_temp\" no está permitido debido a que el directorio ya existe."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-El nombre \"$tablas_temp\" no está permitido debido a que el directorio ya existe.-instalarTP.sh-`users`" >> ./instalarTP.log
	        else
	            if grep -Fxq "$tablas_temp" $ingresados
	            then
	                echo "EL nombre \"$tablas_temp\" ya fue seleccionado para otro directorio."
	                echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-EL nombre \"$tablas_temp\" ya fue seleccionado para otro directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
	            else
	                echo "No está permitido el uso de los caracteres "/" o "." para el nombre de los directorios."
	                echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No está permitido el uso de los caracteres "/" o "." para el nombre de los directorios.-instalarTP.sh-`users`" >> ./instalarTP.log
	            fi
	        fi
		    read -p "Ingrese un nombre para el directorio de tablas del sistema (en caso de dejar en blanco, se utilizará el nombre por default \"$tablas_default\"): `echo $'\n> '`" tablas_temp
		    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ingrese un nombre para el directorio de tablas del sistema (en caso de dejar en blanco, se utilizará el nombre por default \"$tablas_default\"):-instalarTP.sh-`users`" >> ./instalarTP.log
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$tablas_temp-instalarTP.sh-`users`" >> ./instalarTP.log
	    done
	    
	    if [[ -z "$tablas_temp" ]] ; then
	        tablas_temp=$tablas_default
	    fi
	    
	    tablas_temp=`echo "$tablas_temp" | sed "s/ /_/g"`
	    tablas_default=$tablas_temp
	    echo $tablas_temp >> $ingresados
	
	    read -p "Ingrese un nombre para el directorio de novedades (en caso de dejar en blanco, se utilizará el nombre por default \"$novedades_default\"): `echo $'\n> '`" novedades_temp
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ingrese un nombre para el directorio de novedades (en caso de dejar en blanco, se utilizará el nombre por default \"$novedades_default\"):-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$novedades_temp-instalarTP.sh-`users`" >> ./instalarTP.log
	    
	    while grep -Fxq "$novedades_temp" $reservados || grep -Fxq "$novedades_temp" $ingresados || [[ $novedades_temp == *"."* ]] || [[ $novedades_temp == *"/"* ]] ; do
	        if grep -Fxq "$novedades_temp" $reservados
	        then
	            echo "El nombre \"$novedades_temp\" no está permitido debido a que el directorio ya existe."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-El nombre \"$novedades_temp\" no está permitido debido a que el directorio ya existe.-instalarTP.sh-`users`" >> ./instalarTP.log
	        else
	            if grep -Fxq "$novedades_temp" $ingresados
	            then
	                echo "EL nombre \"$novedades_temp\" ya fue seleccionado para otro directorio."
	                echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-EL nombre \"$novedades_temp\" ya fue seleccionado para otro directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
	            else
	                echo "No está permitido el uso de los caracteres "/" o "." para el nombre de los directorios."
	                echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No está permitido el uso de los caracteres "/" o "." para el nombre de los directorios.-instalarTP.sh-`users`" >> ./instalarTP.log
	            fi
	        fi
		    read -p "Ingrese un nombre para el directorio de novedades (en caso de dejar en blanco, se utilizará el nombre por default \"$novedades_default\"): `echo $'\n> '`" novedades_temp
		    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ingrese un nombre para el directorio de novedades (en caso de dejar en blanco, se utilizará el nombre por default \"$novedades_default\"):-instalarTP.sh-`users`" >> ./instalarTP.log
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$novedades_temp-instalarTP.sh-`users`" >> ./instalarTP.log
	    done
	    
	    if [[ -z "$novedades_temp" ]] ; then
	        novedades_temp=$novedades_default
	    fi
	    
	    novedades_temp=`echo "$novedades_temp" | sed "s/ /_/g"`
	    novedades_default=$novedades_temp
	    echo $novedades_temp >> $ingresados
	
	    read -p "Ingrese un nombre para el directorio de archivos rechazados (en caso de dejar en blanco, se utilizará el nombre por default \"$rechazados_default\"): `echo $'\n> '`" rechazados_temp
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ingrese un nombre para el directorio de archivos rechazados (en caso de dejar en blanco, se utilizará el nombre por default \"$rechazados_default\"):-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$rechazados_temp-instalarTP.sh-`users`" >> ./instalarTP.log
	    
	    while grep -Fxq "$rechazados_temp" $reservados || grep -Fxq "$rechazados_temp" $ingresados || [[ $rechazados_temp == *"."* ]] || [[ $rechazados_temp == *"/"* ]] ; do
	        if grep -Fxq "$rechazados_temp" $reservados
	        then
	            echo "El nombre \"$rechazados_temp\" no está permitido debido a que el directorio ya existe."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-El nombre \"$rechazados_temp\" no está permitido debido a que el directorio ya existe.-instalarTP.sh-`users`" >> ./instalarTP.log
	        else
	            if grep -Fxq "$rechazados_temp" $ingresados
	            then
	                echo "EL nombre \"$rechazados_temp\" ya fue seleccionado para otro directorio."
	                echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-EL nombre \"$rechazados_temp\" ya fue seleccionado para otro directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
	            else
	                echo "No está permitido el uso de los caracteres "/" o "." para el nombre de los directorios."
	                echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No está permitido el uso de los caracteres "/" o "." para el nombre de los directorios.-instalarTP.sh-`users`" >> ./instalarTP.log
	            fi
	        fi
		    read -p "Ingrese un nombre para el directorio de archivos rechazados (en caso de dejar en blanco, se utilizará el nombre por default \"$rechazados_default\"): `echo $'\n> '`" rechazados_temp
		    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ingrese un nombre para el directorio de archivos rechazados (en caso de dejar en blanco, se utilizará el nombre por default \"$rechazados_default\"):-instalarTP.sh-`users`" >> ./instalarTP.log
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$rechazados_temp-instalarTP.sh-`users`" >> ./instalarTP.log
	    done
	    
	    if [[ -z "$rechazados_temp" ]] ; then
	        rechazados_temp=$rechazados_default
	    fi
	    
	    rechazados_temp=`echo "$rechazados_temp" | sed "s/ /_/g"`
	    rechazados_default=$rechazados_temp
	    echo $rechazados_temp >> $ingresados
	
	    read -p "Ingrese un nombre para el directorio de lotes procesados (en caso de dejar en blanco, se utilizará el nombre por default \"$lotes_default\"): `echo $'\n> '`" lotes_temp
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ingrese un nombre para el directorio de lotes procesados (en caso de dejar en blanco, se utilizará el nombre por default \"$lotes_default\"):-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$lotes_temp-instalarTP.sh-`users`" >> ./instalarTP.log
	    
	    while grep -Fxq "$lotes_temp" $reservados || grep -Fxq "$lotes_temp" $ingresados || [[ $lotes_temp == *"."* ]] || [[ $lotes_temp == *"/"* ]] ; do
	        if grep -Fxq "$lotes_temp" $reservados
	        then
	            echo "El nombre \"$lotes_temp\" no está permitido debido a que el directorio ya existe."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-El nombre \"$lotes_temp\" no está permitido debido a que el directorio ya existe.-instalarTP.sh-`users`" >> ./instalarTP.log
	        else
	            if grep -Fxq "$lotes_temp" $ingresados
	            then
	                echo "EL nombre \"$lotes_temp\" ya fue seleccionado para otro directorio."
	                echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-EL nombre \"$lotes_temp\" ya fue seleccionado para otro directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
	            else
	                echo "No está permitido el uso de los caracteres "/" o "." para el nombre de los directorios."
	                echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No está permitido el uso de los caracteres "/" o "." para el nombre de los directorios.-instalarTP.sh-`users`" >> ./instalarTP.log
	            fi
	        fi
		    read -p "Ingrese un nombre para el directorio de lotes procesados (en caso de dejar en blanco, se utilizará el nombre por default \"$lotes_default\"): `echo $'\n> '`" lotes_temp
		    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ingrese un nombre para el directorio de lotes procesados (en caso de dejar en blanco, se utilizará el nombre por default \"$lotes_default\"):-instalarTP.sh-`users`" >> ./instalarTP.log
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$lotes_temp-instalarTP.sh-`users`" >> ./instalarTP.log
	    done
	    
	    if [[ -z "$lotes_temp" ]] ; then
	        lotes_temp=$lotes_default
	    fi
	    
	    lotes_temp=`echo "$lotes_temp" | sed "s/ /_/g"`
	    lotes_default=$lotes_temp
	    echo $lotes_temp >> $ingresados
	
	    read -p "Ingrese un nombre para el directorio de resultados (en caso de dejar en blanco, se utilizará el nombre por default \"$resultados_default\"): `echo $'\n> '`" resultados_temp
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ingrese un nombre para el directorio de resultados (en caso de dejar en blanco, se utilizará el nombre por default \"$resultados_default\"):-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$resultados_temp-instalarTP.sh-`users`" >> ./instalarTP.log
	    
	    while grep -Fxq "$resultados_temp" $reservados || grep -Fxq "$resultados_temp" $ingresados || [[ $resultados_temp == *"."* ]] || [[ $resultados_temp == *"/"* ]] ; do
	        if grep -Fxq "$resultados_temp" $reservados
	        then
	            echo "El nombre \"$resultados_temp\" no está permitido debido a que el directorio ya existe."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-El nombre \"$resultados_temp\" no está permitido debido a que el directorio ya existe.-instalarTP.sh-`users`" >> ./instalarTP.log
	        else
	            if grep -Fxq "$resultados_temp" $ingresados
	            then
	                echo "EL nombre \"$resultados_temp\" ya fue seleccionado para otro directorio."
	                echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-EL nombre \"$resultados_temp\" ya fue seleccionado para otro directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
	            else
	                echo "No está permitido el uso de los caracteres "/" o "." para el nombre de los directorios."
	                echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No está permitido el uso de los caracteres "/" o "." para el nombre de los directorios.-instalarTP.sh-`users`" >> ./instalarTP.log
	            fi
	        fi
	    	read -p "Ingrese un nombre para el directorio de resultados (en caso de dejar en blanco, se utilizará el nombre por default \"$resultados_default\"): `echo $'\n> '`" resultados_temp
	    	echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ingrese un nombre para el directorio de resultados (en caso de dejar en blanco, se utilizará el nombre por default \"$resultados_default\"):-instalarTP.sh-`users`" >> ./instalarTP.log
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$resultados_temp-instalarTP.sh-`users`" >> ./instalarTP.log
	    done
	    
	    if [[ -z "$resultados_temp" ]] ; then
	        resultados_temp=$resultados_default
	    fi
	    
	    resultados_temp=`echo "$resultados_temp" | sed "s/ /_/g"`
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
	    
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Tipo de proceso:                          INSTALACIÓN-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio padre:                         $(dirname `pwd`)-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ubicación script de instalación:          `pwd`/instalarTP.sh-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Log de la instalación:                    `pwd`/instalarTP.log-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Archivo de configuración:                 `pwd`/instalarTP.conf-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Log de inicialización:                    `pwd`/iniciarambiente.log-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Log del proceso principal:                `pwd`/pprincipal.log-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de ejecutables:                $(dirname `pwd`)/$ejecutables_default-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de tablas maestras:            $(dirname `pwd`)/$tablas_default-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de novedades:                  $(dirname `pwd`)/$novedades_default-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de novedades aceptadas:        $(dirname `pwd`)/$novedades_default/ok-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de rechazados:                 $(dirname `pwd`)/$rechazados_default-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de lotes procesados:           $(dirname `pwd`)/$lotes_default-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de transacciones:              $(dirname `pwd`)/$resultados_default-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de comisiones:                 $(dirname `pwd`)/$resultados_default/comisiones-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Estado de la instalación:                 LISTA-instalarTP.sh-`users`" >> ./instalarTP.log
	    
	    read -p "¿Confirma la instalación? (Y/N) `echo $'\n> '`" respuesta
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-¿Confirma la instalación? (Y/N)-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$respuesta-instalarTP.sh-`users`" >> ./instalarTP.log
	    while [[ "$respuesta" != "Y" && "$respuesta" != "y" && "$respuesta" != "N" && "$respuesta" != "n" ]] ; do
	        echo "Respuesta invalida."
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-ERR-Respuesta invalida.-instalarTP.sh-`users`" >> ./instalarTP.log
	        read -p "¿Confirma la instalación? (Y/N) `echo $'\n> '`" respuesta
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-¿Confirma la instalación? (Y/N)-instalarTP.sh-`users`" >> ./instalarTP.log
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$respuesta-instalarTP.sh-`users`" >> ./instalarTP.log
	    done
	    
	    if [[ "$respuesta" = "Y" || "$respuesta" = "y" ]] ; then
	        instalar="Yes"
	    fi
	    
	    clear
	done
	
	#Creamos los directorios.
	echo "GRUPO-$(dirname `pwd`)" > ./instalarTP.conf
	echo "DIRINST-`pwd`" >> ./instalarTP.conf
	
	echo "Creando directorio de ejecutables."
	echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Creando directorio de ejecutables.-instalarTP.sh-`users`" >> ./instalarTP.log
	mkdir $(dirname `pwd`)/$ejecutables_default
	echo "DIRBIN-$(dirname `pwd`)/$ejecutables_default" >> ./instalarTP.conf
	
	echo "Creando directorio de tablas del sistema."
	echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Creando directorio de tablas del sistema.-instalarTP.sh-`users`" >> ./instalarTP.log
	mkdir $(dirname `pwd`)/$tablas_default
	echo "DIRMAE-$(dirname `pwd`)/$tablas_default" >> ./instalarTP.conf
	
	echo "Creando directorio de novedades."
	echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Creando directorio de novedades.-instalarTP.sh-`users`" >> ./instalarTP.log
	mkdir $(dirname `pwd`)/$novedades_default
	mkdir $(dirname `pwd`)/$novedades_default/ok
	echo "DIRIN-$(dirname `pwd`)/$novedades_default" >> ./instalarTP.conf
	
	echo "Creando directorio de archivos rechazados."
	echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Creando directorio de archivos rechazados.-instalarTP.sh-`users`" >> ./instalarTP.log
	mkdir $(dirname `pwd`)/$rechazados_default
	echo "DIRRECH-$(dirname `pwd`)/$rechazados_default" >> ./instalarTP.conf
	
	echo "Creando directorio de lotes procesados."
	echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Creando directorio de lotes procesados.-instalarTP.sh-`users`" >> ./instalarTP.log
	mkdir $(dirname `pwd`)/$lotes_default
	echo "DIRPROC-$(dirname `pwd`)/$lotes_default" >> ./instalarTP.conf
	
	echo "Creando directorio de resultados."
	echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Creando directorio de resultados.-instalarTP.sh-`users`" >> ./instalarTP.log
	mkdir $(dirname `pwd`)/$resultados_default
	mkdir $(dirname `pwd`)/$resultados_default/comisiones
	echo "DIROUT-$(dirname `pwd`)/$resultados_default" >> ./instalarTP.conf
	
	#Copiamos las tablas maestras y los archivos ejecutables.
	cp ../original/tablasmaestras/comercios.txt $(dirname `pwd`)/$tablas_default/comercios.txt
	cp ../original/tablasmaestras/tarjetashomologadas.txt $(dirname `pwd`)/$tablas_default/tarjetashomologadas.txt
	cp ../original/scripts/pprincipal.sh $(dirname `pwd`)/$ejecutables_default/pprincipal.sh
	cp ../original/scripts/salida1.bash $(dirname `pwd`)/$ejecutables_default/salida1.bash
	cp ../original/scripts/salida2.bash $(dirname `pwd`)/$ejecutables_default/salida2.bash
	
	echo "INSTALACION-`date '+%d/%m/%Y %H:%M:%S'`-`users`" >> ./instalarTP.conf
	echo "Estado de la instalación:                     COMPLETADA"
	echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Estado de la instalación:                     COMPLETADA-instalarTP.sh-`users`" >> ./instalarTP.log
	
else #Caso en el que existe. Vemos si se debe reparar el sistema o no.
	
	#Inicializamos variables con los directorios y archivos que debemos comprobar su existencia.
	DIRBIN=`grep "^DIRBIN-" instalarTP.conf | sed 's/DIRBIN-\(.*\)/\1/'`
	DIRMAE=`grep "^DIRMAE-" instalarTP.conf | sed 's/DIRMAE-\(.*\)/\1/'`
	DIRIN=`grep "^DIRIN-" instalarTP.conf | sed 's/DIRIN-\(.*\)/\1/'`
	DIRIN_SUB="$DIRIN/ok"
	DIRRECH=`grep "^DIRRECH-" instalarTP.conf | sed 's/DIRRECH-\(.*\)/\1/'`
	DIRPROC=`grep "^DIRPROC-" instalarTP.conf | sed 's/DIRPROC-\(.*\)/\1/'`
	DIROUT=`grep "^DIROUT-" instalarTP.conf | sed 's/DIROUT-\(.*\)/\1/'`
	DIROUT_SUB="$DIROUT/comisiones"
	
	directorios=("$DIRBIN" "$DIRMAE" "$DIRIN" "$DIRIN_SUB" "$DIRRECH" "$DIRPROC" "$DIROUT" "$DIROUT_SUB")
	
	reparar="No"
	
	for d in "${directorios[@]}"; do
	    if [ ! -d "$d" ]; then
	        reparar="Yes"
	        break
	    fi
	done
	
	if [ "$reparar" = "No" ] ; then
	    if [[ ! -f "$DIRMAE"/comercios.txt || ! -f "$DIRMAE"/tarjetashomologadas.txt ]] || ! -f "$DIRBIN"/pprincipal.sh ]] || ! -f "$DIRBIN"/salida1.bash ]] || ! -f "$DIRBIN"/salida2.bash ]] ; then
	        reparar="Yes"
	    fi
	fi
	
	if [ "$reparar" = "No" ]
	then #Caso en el que no hay que hacer la reparación.
	    echo "El sistema se encuentra correctamente instalado y no necesita reparación alguna."
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-El sistema se encuentra correctamente instalado y no necesita reparación alguna.-instalarTP.sh-`users`" >> ./instalarTP.log
	    cat ./instalarTP.conf
	else #Caso en el que hay que reparar el sistema.
	    
	    clear
	    echo "Tipo de proceso:                          REPARACIÓN"
	    echo "Directorio padre:                         $(dirname `pwd`)"
	    echo "Ubicación script de instalación:          `pwd`/instalarTP.sh"
	    echo "Log de la instalación:                    `pwd`/instalarTP.log"
	    echo "Archivo de configuración:                 `pwd`/instalarTP.conf"
	    echo "Log de inicialización:                    `pwd`/iniciarambiente.log"
	    echo "Log del proceso principal:                `pwd`/pprincipal.log"
	    echo "Directorio de ejecutables:                $DIRBIN"
	    echo "Directorio de tablas maestras:            $DIRMAE"
	    echo "Directorio de novedades:                  $DIRIN"
	    echo "Directorio de novedades aceptadas:        $DIRIN_SUB"
	    echo "Directorio de rechazados:                 $DIRRECH"
	    echo "Directorio de lotes procesados:           $DIRPROC"
	    echo "Directorio de transacciones:              $DIROUT"
	    echo "Directorio de comisiones:                 $DIROUT_SUB"
	    echo "Estado de la reparación:                  LISTA"
	    echo ""
	    
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Tipo de proceso:                          REPARACIÓN-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio padre:                         $(dirname `pwd`)-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ubicación script de instalación:          `pwd`/instalarTP.sh-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Log de la instalación:                    `pwd`/instalarTP.log-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Archivo de configuración:                 `pwd`/instalarTP.conf-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Log de inicialización:                    `pwd`/iniciarambiente.log-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Log del proceso principal:                `pwd`/pprincipal.log-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de ejecutables:                $DIRBIN-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de tablas maestras:            $DIRMAE-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de novedades:                  $DIRIN-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de novedades aceptadas:        $DIRIN_SUB-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de rechazados:                 $DIRRECH-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de lotes procesados:           $DIRPROC-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de transacciones:              $DIROUT-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de comisiones:                 $DIROUT_SUB-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Estado de la reparación:                  LISTA-instalarTP.sh-`users`" >> ./instalarTP.log
	    
	    read -p "¿Confirma la reparación? (Y/N) `echo $'\n> '`" respuesta
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-¿Confirma la instalación? (Y/N)-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$respuesta-instalarTP.sh-`users`" >> ./instalarTP.log
	    while [[ "$respuesta" != "Y" && "$respuesta" != "y" && "$respuesta" != "N" && "$respuesta" != "n" ]] ; do
	        echo "Respuesta invalida."
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-ERR-Respuesta invalida.-instalarTP.sh-`users`" >> ./instalarTP.log
	        read -p "¿Confirma la reparación? (Y/N) `echo $'\n> '`" respuesta
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-¿Confirma la instalación? (Y/N)-instalarTP.sh-`users`" >> ./instalarTP.log
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$respuesta-instalarTP.sh-`users`" >> ./instalarTP.log
	    done
	    
	    if [[ "$respuesta" = "Y" || "$respuesta" = "y" ]]; then
	        
	        clear
	        echo "Comenzando reparación del sistema."
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Comenzando reparación del sistema.-instalarTP.sh-`users`" >> ./instalarTP.log
	    
	        if [ ! -d "$DIRBIN" ]; then
	            echo "No se encontró el directorio de ejecutables $DIRBIN. Reparando directorio."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No se encontró el directorio de ejecutables $DIRBIN. Reparando directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
                mkdir $DIRBIN
				cp ../original/scripts/pprincipal.sh $DIRBIN/pprincipal.sh
				cp ../original/scripts/salida1.bash $DIRBIN/salida1.bash
				cp ../original/scripts/salida2.bash $DIRBIN/salida2.bash
	        fi
	    
	        if [ ! -d "$DIRMAE" ]; then
	            echo "No se encontró el directorio de tablas del sistema $DIRMAE. Reparando directorio."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No se encontró el directorio de tablas del sistema $DIRMAE. Reparando directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
                mkdir $DIRMAE
                cp ../original/tablasmaestras/comercios.txt $DIRMAE/comercios.txt
                cp ../original/tablasmaestras/tarjetashomologadas.txt $DIRMAE/tarjetashomologadas.txt
	        fi
	    
	        if [ ! -d "$DIRIN" ]; then
	            echo "No se encontró el directorio de novedades $DIRIN. Reparando directorio."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No se encontró el directorio de novedades $DIRIN. Reparando directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
                mkdir $DIRIN
                mkdir $DIRIN_SUB
	        fi
	    
	        if [ ! -d "$DIRIN_SUB" ]; then
	            echo "No se encontró el directorio de novedades aceptadas $DIRIN_SUB. Reparando directorio."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No se encontró el directorio de novedades aceptadas $DIRIN_SUB. Reparando directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
                mkdir $DIRIN_SUB
	        fi
	    
	        if [ ! -d "$DIRRECH" ]; then
	            echo "No se encontró el directorio de archivos rechazados $DIRRECH. Reparando directorio."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No se encontró el directorio de archivos rechazados $DIRRECH. Reparando directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
                mkdir $DIRRECH
	        fi
	    
	        if [ ! -d "$DIRPROC" ]; then
	            echo "No se encontró el directorio de lotes procesados $DIRPROC. Reparando directorio."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No se encontró el directorio de lotes procesados $DIRPROC. Reparando directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
                mkdir $DIRPROC
	        fi
	    
	        if [ ! -d "$DIROUT" ]; then
	            echo "No se encontró el directorio de resultados $DIROUT. Reparando directorio."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No se encontró el directorio de resultados $DIROUT. Reparando directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
                mkdir $DIROUT
                mkdir $DIROUT_SUB
	        fi
	    
	        if [ ! -d "$DIROUT_SUB" ]; then
	            echo "No se encontró el directorio de comisiones $DIROUT_SUB. Reparando directorio."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No se encontró el directorio de comisiones $DIROUT_SUB. Reparando directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
                mkdir $DIROUT_SUB
	        fi
	    
	        if [ ! -f "$DIRMAE"/comercios.txt ];then
	            echo "No se encontró el maestro de comercios. Reparando archivo."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No se encontró el maestro de comercios. Reparando archivo.-instalarTP.sh-`users`" >> ./instalarTP.log
	            cp ../original/tablasmaestras/comercios.txt $DIRMAE/comercios.txt
	        fi
	    
	        if [ ! -f "$DIRMAE"/tarjetashomologadas.txt ]; then
	            echo "No se encontró el maestro de tarjetas. Reparando archivo."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No se encontró el maestro de tarjetas. Reparando archivo.-instalarTP.sh-`users`" >> ./instalarTP.log
	            cp ../original/tablasmaestras/tarjetashomologadas.txt $DIRMAE/tarjetashomologadas.txt
	        fi
			
			if [ ! -f "$DIRBIN"/pprincipal.sh ]; then
	            echo "No se encontró el ejecutable del programa principal. Reparando archivo."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No se encontró el ejecutable del programa principal. Reparando archivo.-instalarTP.sh-`users`" >> ./instalarTP.log
	            cp ../original/scripts/pprincipal.sh $DIRBIN/pprincipal.sh
	        fi
			
			if [ ! -f "$DIRBIN"/salida1.bash ]; then
	            echo "No se encontró el ejecutable de archivos de liquidación. Reparando archivo."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No se encontró el ejecutable de archivos de liquidación. Reparando archivo.-instalarTP.sh-`users`" >> ./instalarTP.log
	            cp ../original/scripts/salida1.bash $DIRBIN/salida1.bash
	        fi
			
			if [ ! -f "$DIRBIN"/salida2.bash ]; then
	            echo "No se encontró el ejecutable de cálculo del costo del servicio. Reparando archivo."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No se encontró el ejecutable de cálculo del costo del servicio. Reparando archivo.-instalarTP.sh-`users`" >> ./instalarTP.log
	            cp ../original/scripts/salida2.bash $DIRBIN/salida2.bash
	        fi
	    
	        echo "REPARACION-`date '+%d/%m/%Y %H:%M:%S'`-`users`" >> ./instalarTP.conf
	        echo "Estado de la reparación:                     COMPLETADA"
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Estado de la reparación:                     COMPLETADA-instalarTP.sh-`users`" >> ./instalarTP.log
	        cat ./instalarTP.conf
	    else
	        echo "Cancelando proceso de reparación."
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Cancelando proceso de reparación.-instalarTP.sh-`users`" >> ./instalarTP.log
	    fi	      
	fi
fi
