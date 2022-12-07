#!/bin/bash

declare -i opcion=0
pathRecoge=$(find /home -name "recoge-prac.sh")

function metodo1 {
		echo "Menú 1 - Programar recogida de prácticas\n"
        	read -p "Asignatura cuyas prácticas desea recoger: " -a asig
                read -p "Ruta con las cuentas de los alumnos: " -a pathAlum
                while [ ! -d $pathAlum ]
                do
                echo $pathAlum
                read -p "Ruta con las cuentas de los alumnos: " -a pathAlum
                done
                read -p "Ruta para almacenar prácticas: " -a pathPrac
                while [ ! -d $pathPrac ]
                do
                echo $pathPrac
                read -p "Ruta para almacenar prácticas: " -a pathPrac
                done
                echo "Se va a programar la recogida de las practicas de $asig para mañana a las 8:00. Origen: $pathAlum Destino: $pathPrac"
                resp="l"
                while [ $resp != "s" -a $resp != "n" ]
                do
                        read -p "¿Está de acuerdo (s/n)?" -a resp
                        if [ $resp == "s" ]
                        then

				crontab -l > tareas
	echo "47 03 6 12 * bash $pathRecoge $pathAlum $pathPrac" >> tareas
				#echo "0 8 $(date -d tomorrow +%d) $(date -d tomorrow+ %m) * bash $pathRecoge $pathAlum $pathPrac" >> tareas
                                #echo "0 8 $(date -d tomorrow +%d) $(date -d tomorrow >
                                crontab tareas
                        elif [ $resp == "n" ]
                        then
                                echo "Operacion cancelada"
                        fi
                done
}

function metodo2 {
	echo "Menú 2 - Empaquetar prácticas de la asignatura\n"
        read -p "Asignatura cuyas prácticas desea empaquetar: " -a asig
        read -p "Ruta absoluta del directorio de prácticas: " -a pathDir
        while [ ! -d $pathAlum ]
        do
        	echo $pathAlum
        	read -p "Ruta con las cuentas de los alumnos: " -a pathAlum
        done
	echo "Se van a empaquetar las práctiacs de la asignatura $asig presentes en el directorio $pathDir\n"
	resp="l"
        while [ $resp != "s" -a $resp != "n" ]
	do
		read -p "¿Está de acuerdo (s/n)?" -a resp
                if [ $resp == "s" ]
                then
			nombreTar=$asig-$(date +%y%m%d).tgz
			tar -czf $nombreTar $pathDir
			cp . $pathDir
			rm nombreTar
		elif [ $resp == "n" ]
                then
                	echo "Operacion cancelada"
                fi
	done
}

function metodo3 {

	echo "Menu 3 - Obtener tamaño y fecha del fichero"
	read -p "Asignatura sobre la que queremos informacion: " -a asig
}

while [ $opcion != 4 ]
do
echo -e "ASO 22/23 - Practica 6\nNombre del Alumno\n--------------------\n"
echo -e "Menú"
echo -e "   1) Programar recogida de practicas"
echo -e "   2) Empaquetado de practica de una asignatura"
echo -e "   3) Ver tamaño y fecha del fichero del fichero"
echo -e "   4) Finalizar programa"
read -p "Opción: " -a opcion
case $opcion in
	1)
		if [ -f $pathRecoge ]
		then
			metodo1
		else
			echo "Error: No se encuentra archivo recoge-prac.sh en /home"
		fi
	;;
	2)
		metodo2
        ;;
	3)
		metodo3
     	;;
	4)
		opcion=4
	;;
	*)
		opcion=0
	;;
esac
done
