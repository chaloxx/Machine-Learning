#!/bin/bash


DIR="Diagonal"
FILE="diagonal"


# En res.txt voy armando una matriz con los siguientes valores:
# clase (parámetro), cantidad de nodos, training error, test error

#Esto lo hago para que se borren los resultados anteriores y no hacerlo a mano
if test  -f "res.txt"; then
	rm "res.txt"
fi

# Esto lo hago para crear un nuevo test antes del experimento
cd $DIR
./$FILE 10000 2 0.78
cp $FILE.data $FILE.test
cd ..


# Este es el experimento
for i in `seq 0 5`;
do
  #Calculo el tamaño del conjunto de entranamiento
	size=$((125*2**i))
  #Hacemos 20 pasadas con c4.5 para cada size
	for j in `seq 1 20`;
	do
		cd $DIR/
    #Mi generador de datos se llama $FILE, primero recibe la cantidad de datos luego la dimensión y el c
		./$FILE $size 2 0.78
    # Creo el árbol con la opción -u para pruebe el árbol con el test, con > guardo lo que imprimi en $FILE.info
		c4.5 -f $FILE -u > $FILE.info
		cd ..
    #readFile me parsea la salida y agrega los resultados a res.txt
		./readFile $DIR/$FILE.info $size >> res.txt
	done
done
