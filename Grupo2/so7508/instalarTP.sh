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
	    
	    while grep -Fxq "$ejecutables_temp" $reservados ; do
	        echo "El nombre \"$ejecutables_temp\" no está permitido debido a que el directorio ya existe."
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-El nombre \"$ejecutables_temp\" no está permitido debido a que el directorio ya existe.-instalarTP.sh-`users`" >> ./instalarTP.log
	        read -p "Ingrese un nombre para el directorio de ejecutables (en caso de dejar en blanco, se utilizará el nombre por default \"$ejecutables_default\"): `echo $'\n> '`" ejecutables_temp
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ingrese un nombre para el directorio de ejecutables (en caso de dejar en blanco, se utilizará el nombre por default \"$ejecutables_default\"):-instalarTP.sh-`users`" >> ./instalarTP.log
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$ejecutables_temp-instalarTP.sh-`users`" >> ./instalarTP.log
	    done
	    
	    if [[ -z "$ejecutables_temp" ]] ; then
	        ejecutables_temp=$ejecutables_default
	    fi
	    ejecutables_default=$ejecutables_temp
	    echo $ejecutables_temp > $ingresados
	
	    read -p "Ingrese un nombre para el directorio de tablas del sistema (en caso de dejar en blanco, se utilizará el nombre por default \"$tablas_default\"): `echo $'\n> '`" tablas_temp
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ingrese un nombre para el directorio de tablas del sistema (en caso de dejar en blanco, se utilizará el nombre por default \"$tablas_default\"):-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$tablas_temp-instalarTP.sh-`users`" >> ./instalarTP.log
	    
	    while grep -Fxq "$tablas_temp" $reservados || grep -Fxq "$tablas_temp" $ingresados ; do
	        if grep -Fxq "$tablas_temp" $reservados
	        then
	            echo "El nombre \"$tablas_temp\" no está permitido debido a que el directorio ya existe."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-El nombre \"$tablas_temp\" no está permitido debido a que el directorio ya existe.-instalarTP.sh-`users`" >> ./instalarTP.log
	        else
	            echo "EL nombre \"$tablas_temp\" ya fue seleccionado para otro directorio."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-EL nombre \"$tablas_temp\" ya fue seleccionado para otro directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
	        fi
		    read -p "Ingrese un nombre para el directorio de tablas del sistema (en caso de dejar en blanco, se utilizará el nombre por default \"$tablas_default\"): `echo $'\n> '`" tablas_temp
		    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ingrese un nombre para el directorio de tablas del sistema (en caso de dejar en blanco, se utilizará el nombre por default \"$tablas_default\"):-instalarTP.sh-`users`" >> ./instalarTP.log
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$tablas_temp-instalarTP.sh-`users`" >> ./instalarTP.log
	    done
	    
	    if [[ -z "$tablas_temp" ]] ; then
	        tablas_temp=$tablas_default
	    fi
	    tablas_default=$tablas_temp
	    echo $tablas_temp >> $ingresados
	
	    read -p "Ingrese un nombre para el directorio de novedades (en caso de dejar en blanco, se utilizará el nombre por default \"$novedades_default\"): `echo $'\n> '`" novedades_temp
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ingrese un nombre para el directorio de novedades (en caso de dejar en blanco, se utilizará el nombre por default \"$novedades_default\"):-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$novedades_temp-instalarTP.sh-`users`" >> ./instalarTP.log
	    
	    while  grep -Fxq "$novedades_temp" $reservados || grep -Fxq "$novedades_temp" $ingresados ; do
	        if grep -Fxq "$novedades_temp" $reservados
	        then
	            echo "El nombre \"$novedades_temp\" no está permitido debido a que el directorio ya existe."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-El nombre \"$novedades_temp\" no está permitido debido a que el directorio ya existe.-instalarTP.sh-`users`" >> ./instalarTP.log
	        else
	            echo "EL nombre \"$novedades_temp\" ya fue seleccionado para otro directorio."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-EL nombre \"$novedades_temp\" ya fue seleccionado para otro directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
	        fi
		    read -p "Ingrese un nombre para el directorio de novedades (en caso de dejar en blanco, se utilizará el nombre por default \"$novedades_default\"): `echo $'\n> '`" novedades_temp
		    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ingrese un nombre para el directorio de novedades (en caso de dejar en blanco, se utilizará el nombre por default \"$novedades_default\"):-instalarTP.sh-`users`" >> ./instalarTP.log
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$novedades_temp-instalarTP.sh-`users`" >> ./instalarTP.log
	    done
	    
	    if [[ -z "$novedades_temp" ]] ; then
	        novedades_temp=$novedades_default
	    fi
	    novedades_default=$novedades_temp
	    echo $novedades_temp >> $ingresados
	
	    read -p "Ingrese un nombre para el directorio de archivos rechazados (en caso de dejar en blanco, se utilizará el nombre por default \"$rechazados_default\"): `echo $'\n> '`" rechazados_temp
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ingrese un nombre para el directorio de archivos rechazados (en caso de dejar en blanco, se utilizará el nombre por default \"$rechazados_default\"):-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$rechazados_temp-instalarTP.sh-`users`" >> ./instalarTP.log
	    
	    while  grep -Fxq "$rechazados_temp" $reservados || grep -Fxq "$rechazados_temp" $ingresados ; do
	        if grep -Fxq "$rechazados_temp" $reservados
	        then
	            echo "El nombre \"$rechazados_temp\" no está permitido debido a que el directorio ya existe."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-El nombre \"$rechazados_temp\" no está permitido debido a que el directorio ya existe.-instalarTP.sh-`users`" >> ./instalarTP.log
	        else
	            echo "EL nombre \"$rechazados_temp\" ya fue seleccionado para otro directorio."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-EL nombre \"$rechazados_temp\" ya fue seleccionado para otro directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
	        fi
		    read -p "Ingrese un nombre para el directorio de archivos rechazados (en caso de dejar en blanco, se utilizará el nombre por default \"$rechazados_default\"): `echo $'\n> '`" rechazados_temp
		    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ingrese un nombre para el directorio de archivos rechazados (en caso de dejar en blanco, se utilizará el nombre por default \"$rechazados_default\"):-instalarTP.sh-`users`" >> ./instalarTP.log
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$rechazados_temp-instalarTP.sh-`users`" >> ./instalarTP.log
	    done
	    
	    if [[ -z "$rechazados_temp" ]] ; then
	        rechazados_temp=$rechazados_default
	    fi
	    rechazados_default=$rechazados_temp
	    echo $rechazados_temp >> $ingresados
	
	    read -p "Ingrese un nombre para el directorio de lotes procesados (en caso de dejar en blanco, se utilizará el nombre por default \"$lotes_default\"): `echo $'\n> '`" lotes_temp
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ingrese un nombre para el directorio de lotes procesados (en caso de dejar en blanco, se utilizará el nombre por default \"$lotes_default\"):-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$lotes_temp-instalarTP.sh-`users`" >> ./instalarTP.log
	    
	    while  grep -Fxq "$lotes_temp" $reservados || grep -Fxq "$lotes_temp" $ingresados ; do
	        if grep -Fxq "$lotes_temp" $reservados
	        then
	            echo "El nombre \"$lotes_temp\" no está permitido debido a que el directorio ya existe."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-El nombre \"$lotes_temp\" no está permitido debido a que el directorio ya existe.-instalarTP.sh-`users`" >> ./instalarTP.log
	        else
	            echo "EL nombre \"$lotes_temp\" ya fue seleccionado para otro directorio."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-EL nombre \"$lotes_temp\" ya fue seleccionado para otro directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
	        fi
		    read -p "Ingrese un nombre para el directorio de lotes procesados (en caso de dejar en blanco, se utilizará el nombre por default \"$lotes_default\"): `echo $'\n> '`" lotes_temp
		    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ingrese un nombre para el directorio de lotes procesados (en caso de dejar en blanco, se utilizará el nombre por default \"$lotes_default\"):-instalarTP.sh-`users`" >> ./instalarTP.log
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$lotes_temp-instalarTP.sh-`users`" >> ./instalarTP.log
	    done
	    
	    if [[ -z "$lotes_temp" ]] ; then
	        lotes_temp=$lotes_default
	    fi
	    lotes_default=$lotes_temp
	    echo $lotes_temp >> $ingresados
	
	    read -p "Ingrese un nombre para el directorio de resultados (en caso de dejar en blanco, se utilizará el nombre por default \"$resultados_default\"): `echo $'\n> '`" resultados_temp
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ingrese un nombre para el directorio de resultados (en caso de dejar en blanco, se utilizará el nombre por default \"$resultados_default\"):-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$resultados_temp-instalarTP.sh-`users`" >> ./instalarTP.log
	    while  grep -Fxq "$resultados_temp" $reservados || grep -Fxq "$resultados_temp" $ingresados ; do
	        if grep -Fxq "$resultados_temp" $reservados
	        then
	            echo "El nombre \"$resultados_temp\" no está permitido debido a que el directorio ya existe."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-El nombre \"$resultados_temp\" no está permitido debido a que el directorio ya existe.-instalarTP.sh-`users`" >> ./instalarTP.log
	        else
	            echo "EL nombre \"$resultados_temp\" ya fue seleccionado para otro directorio."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-EL nombre \"$resultados_temp\" ya fue seleccionado para otro directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
	        fi
	    	read -p "Ingrese un nombre para el directorio de resultados (en caso de dejar en blanco, se utilizará el nombre por default \"$resultados_default\"): `echo $'\n> '`" resultados_temp
	    	echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ingrese un nombre para el directorio de resultados (en caso de dejar en blanco, se utilizará el nombre por default \"$resultados_default\"):-instalarTP.sh-`users`" >> ./instalarTP.log
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-$resultados_temp-instalarTP.sh-`users`" >> ./instalarTP.log
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
	
	echo "INSTALACION-`date '+%d/%m/%Y %H:%M:%S'`-`users`" >> ./instalarTP.conf
	echo "Estado de la instalación:                     COMPLETADA"
	echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Estado de la instalación:                     COMPLETADA-instalarTP.sh-`users`" >> ./instalarTP.log
	
else #Caso en el que existe. Vemos si se debe reparar el sistema o no.
	
	#Inicializamos variables con los directorios y archivos que debemos comprobar su existencia.
	dirbin=`grep "^DIRBIN-" instalarTP.conf | sed 's/DIRBIN-\(.*\)/\1/'`
	dirmae=`grep "^DIRMAE-" instalarTP.conf | sed 's/DIRMAE-\(.*\)/\1/'`
	dirin=`grep "^DIRIN-" instalarTP.conf | sed 's/DIRIN-\(.*\)/\1/'`
	dirin_sub="$dirin/ok"
	dirrech=`grep "^DIRRECH-" instalarTP.conf | sed 's/DIRRECH-\(.*\)/\1/'`
	dirproc=`grep "^DIRPROC-" instalarTP.conf | sed 's/DIRPROC-\(.*\)/\1/'`
	dirout=`grep "^DIROUT-" instalarTP.conf | sed 's/DIROUT-\(.*\)/\1/'`
	dirout_sub="$dirout/comisiones"
	
	directorios=("$dirbin" "$dirmae" "$dirin" "$dirin_sub" "$dirrech" "$dirproc" "$dirout" "$dirout_sub")
	
	reparar="No"
	
	for d in "${directorios[@]}"; do
	    if [ ! -d "$d" ]; then
	        reparar="Yes"
	        break
	    fi
	done
	
	if [ "$reparar" = "No" ] ; then
	    if [[ ! -f "$dirmae"/comercios.txt || ! -f "$dirmae"/tarjetashomologadas.txt ]]; then
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
	    echo "Directorio de ejecutables:                $dirbin"
	    echo "Directorio de tablas maestras:            $dirmae"
	    echo "Directorio de novedades:                  $dirin"
	    echo "Directorio de novedades aceptadas:        $dirin_sub"
	    echo "Directorio de rechazados:                 $dirrech"
	    echo "Directorio de lotes procesados:           $dirproc"
	    echo "Directorio de transacciones:              $dirout"
	    echo "Directorio de comisiones:                 $dirout_sub"
	    echo "Estado de la reparación:                  LISTA"
	    echo ""
	    
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Tipo de proceso:                          REPARACIÓN-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio padre:                         $(dirname `pwd`)-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ubicación script de instalación:          `pwd`/instalarTP.sh-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Log de la instalación:                    `pwd`/instalarTP.log-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Archivo de configuración:                 `pwd`/instalarTP.conf-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Log de inicialización:                    `pwd`/iniciarambiente.log-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Log del proceso principal:                `pwd`/pprincipal.log-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de ejecutables:                $dirbin-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de tablas maestras:            $dirmae-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de novedades:                  $dirin-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de novedades aceptadas:        $dirin_sub-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de rechazados:                 $dirrech-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de lotes procesados:           $dirproc-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de transacciones:              $dirout-instalarTP.sh-`users`" >> ./instalarTP.log
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Directorio de comisiones:                 $dirout_sub-instalarTP.sh-`users`" >> ./instalarTP.log
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
	    
	        if [ ! -d "$dirbin" ]; then
	            echo "No se encontró el directorio de ejecutables $dirbin. Reparando directorio."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No se encontró el directorio de ejecutables $dirbin. Reparando directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
                mkdir $dirbin
	        fi
	    
	        if [ ! -d "$dirmae" ]; then
	            echo "No se encontró el directorio de tablas del sistema $dirmae. Reparando directorio."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No se encontró el directorio de tablas del sistema $dirmae. Reparando directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
                mkdir $dirmae
                cp ../original/tablasmaestras/comercios.txt $dirmae/comercios.txt
                cp ../original/tablasmaestras/tarjetashomologadas.txt $dirmae/tarjetashomologadas.txt
	        fi
	    
	        if [ ! -d "$dirin" ]; then
	            echo "No se encontró el directorio de novedades $dirin. Reparando directorio."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No se encontró el directorio de novedades $dirin. Reparando directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
                mkdir $dirin
                mkdir $dirin_sub
	        fi
	    
	        if [ ! -d "$dirin_sub" ]; then
	            echo "No se encontró el directorio de novedades aceptadas $dirin_sub. Reparando directorio."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No se encontró el directorio de novedades aceptadas $dirin_sub. Reparando directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
                mkdir $dirin_sub
	        fi
	    
	        if [ ! -d "$dirrech" ]; then
	            echo "No se encontró el directorio de archivos rechazados $dirrech. Reparando directorio."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No se encontró el directorio de archivos rechazados $dirrech. Reparando directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
                mkdir $dirrech
	        fi
	    
	        if [ ! -d "$dirproc" ]; then
	            echo "No se encontró el directorio de lotes procesados $dirproc. Reparando directorio."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No se encontró el directorio de lotes procesados $dirproc. Reparando directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
                mkdir $dirproc
	        fi
	    
	        if [ ! -d "$dirout" ]; then
	            echo "No se encontró el directorio de resultados $dirout. Reparando directorio."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No se encontró el directorio de resultados $dirout. Reparando directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
                mkdir $dirout
                mkdir $dirout_sub
	        fi
	    
	        if [ ! -d "$dirout_sub" ]; then
	            echo "No se encontró el directorio de comisiones $dirout_sub. Reparando directorio."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No se encontró el directorio de comisiones $dirout_sub. Reparando directorio.-instalarTP.sh-`users`" >> ./instalarTP.log
                mkdir $dirout_sub
	        fi
	    
	        if [ ! -f "$dirmae"/comercios.txt ];then
	            echo "No se encontró el maestro de comercios. Reparando archivo."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No se encontró el maestro de comercios. Reparando archivo.-instalarTP.sh-`users`" >> ./instalarTP.log
	            cp ../original/tablasmaestras/comercios.txt $dirmae/comercios.txt
	        fi
	    
	        if [ ! -f "$dirmae"/tarjetashomologadas.txt ]; then
	            echo "No se encontró el maestro de tarjetas. Reparando archivo."
	            echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-No se encontró el maestro de tarjetas. Reparando archivo.-instalarTP.sh-`users`" >> ./instalarTP.log
	            cp ../original/tablasmaestras/tarjetashomologadas.txt $dirmae/tarjetashomologadas.txt
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
