#!/bin/bash
PROB="paralelo"

# Borrar resultados redes
if test -f $PROB/$PROB.nn; then
    rm $PROB/$PROB.nn
fi



#Borrar resultados naive bayes
if test -f $PROB/$PROB.res; then
    rm $PROB/$PROB.res
fi


#Borrar resultados c4.5
if test -f $PROB/$PROB.t; then
    rm $PROB/$PROB.t
fi


for i in `seq 1 5`;
do
	d=$((2**$i))
	echo $d
	(cd $PROB;./$PROB 10000 $d "0.78")
	./parametrizar $PROB/$PROB.nb $d
	./parametrizar $PROB/$PROB.net $d
	cp $PROB/$PROB.data $PROB/$PROB.test
	for j in `seq 1 20`;
	do	
		
		cd $PROB
		./$PROB 250 $d "0.78" # Crear test
		
		if test -f $PROB.mse; then #Borrar .mse antiguo
			rm $PROB.mse
		fi

		#Correr c4.5
		c4.5 -f $PROB -u >> $PROB.info
		(cd ..;./readFile $PROB/$PROB.info $d >> $PROB/$PROB.t)

		
		# Correr back propagation
		bp $PROB
		Res=$(Rscript printMin.R)
		echo "$d $Res" >> $PROB.nn
		
		# Correr naive bayes
		nb $PROB >> $PROB.res		
		cd ..
	done
done

