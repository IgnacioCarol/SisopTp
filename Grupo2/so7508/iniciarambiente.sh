clear
echo "Bienvenido al programa de inicialización del sistema."
echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Bienvenido al programa de inicialización del sistema.-iniciarambiente.sh-`users`" >> ./iniciarambiente.log
#Verificar configuración.
if [ ! -f "./instalarTP.conf" ] #Vemos si existe el archivo de configuración del sistema.
then
    echo "El sistema no está instalado."
    echo "`date '+%d/%m/%Y %H:%M:%S'`-ERR-El sistema no está instalado.-iniciarambiente.sh-`users`" >> ./iniciarambiente.log
    echo "Realizar la instalación del sistema ejecutando el archivo \"instalarTP.sh\" antes de realizar la inicialización."
    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Realizar la instalación del sistema ejecutando el archivo \"instalarTP.sh\" antes de realizar la inicialización.-iniciarambiente.sh-`users`" >> ./iniciarambiente.log
else
    #Inicializar variables.
    grupo=`grep "^GRUPO-" instalarTP.conf | sed 's/GRUPO-\(.*\)/\1/'`
    dirinst=`grep "^DIRINST-" instalarTP.conf | sed 's/DIRINST-\(.*\)/\1/'`
	dirbin=`grep "^DIRBIN-" instalarTP.conf | sed 's/DIRBIN-\(.*\)/\1/'`
	dirmae=`grep "^DIRMAE-" instalarTP.conf | sed 's/DIRMAE-\(.*\)/\1/'`
	dirin=`grep "^DIRIN-" instalarTP.conf | sed 's/DIRIN-\(.*\)/\1/'`
	dirin_sub="$dirin/ok"
	dirrech=`grep "^DIRRECH-" instalarTP.conf | sed 's/DIRRECH-\(.*\)/\1/'`
	dirproc=`grep "^DIRPROC-" instalarTP.conf | sed 's/DIRPROC-\(.*\)/\1/'`
	dirout=`grep "^DIROUT-" instalarTP.conf | sed 's/DIROUT-\(.*\)/\1/'`
	dirout_sub="$dirout/comisiones"
	
	echo "Variables de ambiente inicializadas correctamente."
	echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Variables de ambiente inicializadas correctamente.-iniciarambiente.sh-`users`" >> ./iniciarambiente.log
	
	#Verificar directorios.
	echo "Verificando directorios."
	echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Verificando directorios.-iniciarambiente.sh-`users`" >> ./iniciarambiente.log
	
	directorios=("$dirbin" "$dirmae" "$dirin" "$dirin_sub" "$dirrech" "$dirproc" "$dirout" "$dirout_sub")
	
	reparar="No"
	
	for d in "${directorios[@]}"; do
	    if [ ! -d "$d" ]; then
	        reparar="Yes"
	        break
	    fi
	done
	
	if [ "$reparar" = "Yes" ] ; then
	    echo "Directorio faltante. Ejecutar el script \"instalarTP.sh\" para reparar el sistema antes de realizar la inicialización."
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-ERR-Directorio faltante. Ejecutar el script \"instalarTP.sh\" para reparar el sistema antes de realizar la inicialización.-iniciarambiente.sh-`users`" >> ./iniciarambiente.log
	else
	    echo "Verificación de directorios: OK."
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Verificación de directorios: OK.-iniciarambiente.sh-`users`" >> ./iniciarambiente.log
	    
	    #Verificar archivos.
	    echo "Verificando archivos."
	    echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Verificando archivos.-iniciarambiente.sh-`users`" >> ./iniciarambiente.log
	    
	    if [[ ! -f "$dirmae"/comercios.txt || ! -f "$dirmae"/tarjetashomologadas.txt ]]; then
	        echo "Archivo faltante. Ejecutar el script \"instalarTP.sh\" para reparar el sistema antes de realizar la inicialización."
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-ERR-Archivo faltante. Ejecutar el script \"instalarTP.sh\" para reparar el sistema antes de realizar la inicialización.-iniciarambiente.sh-`users`" >> ./iniciarambiente.log
	    else
	        echo "Verificación de archivos: OK"
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-ERR-Verificación de archivos: OK.-iniciarambiente.sh-`users`" >> ./iniciarambiente.log
	        
	        #Verificar permisos.
	        echo "Verificando permisos."
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-INF-Verificando permisos.-iniciarambiente.sh-`users`" >> ./iniciarambiente.log
	        
	        if [ ! -r "$dirmae"/comercios.txt ] ; then
	            chmod +r "$dirmae"/comercios.txt
	        fi
	        
	        if [ ! -r "$dirmae"/tarjetashomologadas.txt ] ; then
	            chmod +r "$dirmae"/tarjetashomologadas.txt
	        fi
	        
	        echo "Verificación de permisos: OK"
	        echo "`date '+%d/%m/%Y %H:%M:%S'`-ERR-Verificación de permisos: OK.-iniciarambiente.sh-`users`" >> ./iniciarambiente.log
	        
	       #Aca ejecutar el programa principal!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	       
	    fi
	fi
fi
