#!/bin/bash
declare -i opcion=0
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
		echo "Menú 1 - Programar recogida de prácticas\n"
		read -p "Asignatura cuyas prácticas desea recoger: " -a asig
		read -p "Ruta con las cuentas de los alumnos: " -a pathAlum
		while [ ! -d $pathAlum ]
		do
		echo $pathAlum
		read -p "Ruta con las cuentas de los alumnos: " -a pathAlum
		done
echo $pathAlum
		read -p "Ruta para almacenar prácticas: " -a pathPrac
		while [ ! -d $pathPrac ]
		do
		echo $pathPrac
		read -p "Ruta para almacenar prácticas: " -a pathPrac
		done
echo $pathPrac	
		echo "Se va a programar la recogida de las practicas de $asig para mañana a las 8:00. Origen: $pathAlum. Destino: $pathPrac"
		resp="l"
		while [ $resp != "s" -a $resp != "n" ]
		do
			read -p "¿Está de acuerdo (s/n)?" -a resp
			if [ $resp == "s" ]
			then
				crontab -l > tareas
	echo "45 2 6 12 * bash $(pwd)/recoge-prac.sh $pathAlum $pathPrac"
	echo "45 2 6 12 * bash $(pwd)/recoge-prac.sh $pathAlum $pathPrac" >> tareas
				#echo "0 8 $(date -d tomorrow +%d) $(date -d tomorrow +%m) * bash /home/sergiodlx/Documentos/Prac6/recoge-prac.sh $pathAlum $pathPrac" >> tareas
				crontab tareas
			elif [ $resp == "n" ]
			then
				echo "Operacion cancelada"
			fi
		done
	;;
	2)
		echo "2"
        ;;
	3)
		echo "3"
     	;;
	4)
		opcion=4
	;;
	*)
		opcion=0
	;;
esac
done
