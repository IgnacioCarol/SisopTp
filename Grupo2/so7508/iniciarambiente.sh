clear
if [ -z "$1" ]; then
    echo "Por favor, indique el parámetro con el cuál ejecutar este script (\"--iniciarproceso\" o \"--frenarproceso\")."
    echo "`date '+%d/%m/%Y %H:%M:%S'`-WAR-Por favor, indique el parámetro con el cuál ejecutar este script (\"--iniciarproceso\" o \"--frenarproceso\").-iniciarambiente.sh-$USER" >> ./iniciarambiente.log
    exit 0
fi

echo "Bienvenido al programa de inicialización del sistema."
echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Bienvenido al programa de inicialización del sistema.-iniciarambiente.sh-$USER" >> ./iniciarambiente.log
#Verificar configuración.
if [ ! -f "./instalarTP.conf" ] #Vemos si existe el archivo de configuración del sistema.
then
    echo "El sistema no está instalado."
    echo "`date '+%d/%m/%Y %H:%M:%S'`-ERR-El sistema no está instalado.-iniciarambiente.sh-$USER" >> ./iniciarambiente.log
    echo "Realizar la instalación del sistema ejecutando el archivo \"instalarTP.sh\" antes de realizar la inicialización."
    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Realizar la instalación del sistema ejecutando el archivo \"instalarTP.sh\" antes de realizar la inicialización.-iniciarambiente.sh-$USER" >> ./iniciarambiente.log
else
	#Inicializar variables.
	GRUPO=`grep "^GRUPO-" instalarTP.conf | sed 's/GRUPO-\(.*\)/\1/'`
	DIRINST=`grep "^DIRINST-" instalarTP.conf | sed 's/DIRINST-\(.*\)/\1/'`
	DIRBIN=`grep "^DIRBIN-" instalarTP.conf | sed 's/DIRBIN-\(.*\)/\1/'`
	DIRMAE=`grep "^DIRMAE-" instalarTP.conf | sed 's/DIRMAE-\(.*\)/\1/'`
	DIRIN=`grep "^DIRIN-" instalarTP.conf | sed 's/DIRIN-\(.*\)/\1/'`
	DIRIN_SUB="$DIRIN/ok"
	DIRRECH=`grep "^DIRRECH-" instalarTP.conf | sed 's/DIRRECH-\(.*\)/\1/'`
	DIRPROC=`grep "^DIRPROC-" instalarTP.conf | sed 's/DIRPROC-\(.*\)/\1/'`
	DIROUT=`grep "^DIROUT-" instalarTP.conf | sed 's/DIROUT-\(.*\)/\1/'`
	DIROUT_SUB="$DIROUT/comisiones"
	
	export GRUPO
	export DIRINST
	export DIRBIN
	export DIRMAE
	export DIRIN
	export DIRRECH
	export DIRPROC
	export DIROUT
	
	echo "Variables de ambiente inicializadas correctamente."
	echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Variables de ambiente inicializadas correctamente.-iniciarambiente.sh-$USER" >> ./iniciarambiente.log
	
	#Verificar directorios.
	echo "Verificando directorios."
	echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Verificando directorios.-iniciarambiente.sh-$USER" >> ./iniciarambiente.log
	
	directorios=("$DIRBIN" "$DIRMAE" "$DIRIN" "$DIRIN_SUB" "$DIRRECH" "$DIRPROC" "$DIROUT" "$DIROUT_SUB")
	
	reparar_dir="No"
	
	for d in "${directorios[@]}"; do
	    if [ ! -d "$d" ]; then
	        reparar_dir="Yes"
	        break
	    fi
	done
	
	if [ "$reparar_dir" = "Yes" ] ; then
	    echo "Directorio faltante. Ejecutar el script \"instalarTP.sh\" para reparar el sistema antes de realizar la inicialización."
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-ERR-Directorio faltante. Ejecutar el script \"instalarTP.sh\" para reparar el sistema antes de realizar la inicialización.-iniciarambiente.sh-$USER" >> ./iniciarambiente.log
	else
	    echo "Verificación de directorios: OK."
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Verificación de directorios: OK.-iniciarambiente.sh-$USER" >> ./iniciarambiente.log
	    
	    #Verificar archivos.
		MAE_COMERCIOS="$DIRMAE"/comercios.txt
		MAE_TARJETAS="$DIRMAE"/tarjetashomologadas.txt
		EJE_PRINCIPAL="$DIRBIN"/pprincipal.sh
		EJE_SALIDA1="$DIRBIN"/salida1.bash
		EJE_SALIDA2="$DIRBIN"/salida2.bash
		
	    echo "Verificando archivos."
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Verificando archivos.-iniciarambiente.sh-$USER" >> ./iniciarambiente.log
	    
		archivos=("$MAE_COMERCIOS" "$MAE_TARJETAS" "$EJE_PRINCIPAL" "$EJE_SALIDA1" "$EJE_SALIDA2")
		
		reparar_arch="No"
		
		for a in "${archivos[@]}"; do
			if [ ! -f "$a" ]; then
				reparar_arch="Yes"
				break
			fi
		done
		
	    if [ "$reparar_arch" = "Yes" ] ; then
	        echo "Archivo faltante. Ejecutar el script \"instalarTP.sh\" para reparar el sistema antes de realizar la inicialización."
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-ERR-Archivo faltante. Ejecutar el script \"instalarTP.sh\" para reparar el sistema antes de realizar la inicialización.-iniciarambiente.sh-$USER" >> ./iniciarambiente.log
	    else
	        echo "Verificación de archivos: OK"
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-ERR-Verificación de archivos: OK.-iniciarambiente.sh-$USER" >> ./iniciarambiente.log
	        
	        #Verificar permisos.
	        echo "Verificando permisos."
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Verificando permisos.-iniciarambiente.sh-$USER" >> ./iniciarambiente.log
	        
	        if [ ! -r "$MAE_COMERCIOS" ] ; then
	            chmod a+r "$MAE_COMERCIOS"
	        fi
	        
	        if [ ! -r "MAE_TARJETAS" ] ; then
	            chmod a+r "$MAE_TARJETAS"
	        fi
			
	        if [ ! -x "$EJE_PRINCIPAL" ] ; then
	            chmod a+x "$EJE_PRINCIPAL"
	        fi
			
	        if [ ! -x "$EJE_SALIDA1" ] ; then
	            chmod a+x "$EJE_SALIDA1"
	        fi
			
	        if [ ! -x "$EJE_SALIDA2" ] ; then
	            chmod a+x "$EJE_SALIDA2"
	        fi
			
	        echo "Verificación de permisos: OK"
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-ERR-Verificación de permisos: OK.-iniciarambiente.sh-$USER" >> ./iniciarambiente.log

	        #Llamado al programa principal.
	        clear
	        
	        process=../original/auxiliares/process_id.txt
	        
	        if [ "$1" = '--iniciarproceso' ]; then
	            if [ -f $process ]; then
	                echo "Sistema ya inicializado. Si se quiere volver a ejecutar, primero ejecutar este script con el parámetro \"--frenarproceso\"."
	                echo "`date '+%d/%m/%Y %H:%M:%S'`-ERR-Sistema ya inicializado. Si se quiere volver a ejecutar, primero ejecutar este script con el parámetro \"--frenarproceso\".-iniciarambiente.sh-$USER" >> ./iniciarambiente.log
	            else
	                "$EJE_PRINCIPAL" &
	                
	                #Informamos el pid
	                process_id="$!"
	                echo $process_id > $process
	                
	                echo "Ejecutando proceso principal con process ID \"$process_id\"."
	                echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Ejecutando proceso principal con process ID \"$process_id\".-iniciarambiente.sh-$USER" >> ./iniciarambiente.log
	                
	                #Iniciar proceso/Frenar proceso
			        echo "Si desea terminar con la ejecución del sistema, ejecute este script pasando el parámetro \"--frenarproceso\"."
			        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Si desea terminar con la ejecución del sistema, ejecute este script pasando el parámetro \"--frenarproceso\".-iniciarambiente.sh-$USER" >> ./iniciarambiente.log
			
			        echo "Si desea volver a iniciar la ejecución del sistema, ejecute este script pasando el parámetro \"--iniciarproceso\"."
			        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Si desea terminar con la ejecución del sistema, ejecute este script pasando el parámetro \"--frenarproceso\".-iniciarambiente.sh-$USER" >> ./iniciarambiente.log
	            fi
            elif [ "$1" = '--frenarproceso' ]; then
                if [ -f $process ]; then
                    process_id=$(head -n 1 $process)
                    
                    kill "$process_id"
                    rm $process
                    
                    echo "Proceso finalizado. Para volver a ejecutarlo, corra este script con el parámetro \"--iniciarproceso\"."
                    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Proceso finalizado. Para volver a ejecutarlo, corra este script con el parámetro \"--iniciarproceso\".-iniciarambiente.sh-$USER" >> ./iniciarambiente.log
                else
                    echo "El proceso no está en ejecución. Si desea iniciarlo, ejecute este script con el parámetro \"--iniciarproceso\"."
                    echo "`date '+%d/%m/%Y %H:%M:%S'`-ERR-El proceso no está en ejecución. Si desea iniciarlo, ejecute este script con el parámetro \"--iniciarproceso\".-iniciarambiente.sh-$USER" >> ./iniciarambiente.log
                fi
            else
                echo "Parámetro inválido. Solo se aceptan los siguientes parámetros: \"--iniciarproceso\" y \"--frenarproceso\"."
                echo "`date '+%d/%m/%Y %H:%M:%S'`-ERR-Parámetro inválido. Solo se aceptan los siguientes parámetros: \"--iniciarproceso\" y \"--frenarproceso\".-iniciarambiente.sh-$USER" >> ./iniciarambiente.log
            fi
	    fi
	fi
fi
