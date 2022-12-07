#!/bin/bash
for alumno in $(ls $1)
do
cp $1/$alumno/prac.sh $2/$alumno.sh
done
