#!/bin/bash
PROB="paralelo"

# Borrar resultados redes
if test -f $PROB/$PROB.nn.info; then
    rm $PROB/$PROB.nn.info
fi




#Borrar resultados naive bayes
if test -f $PROB/$PROB.nb.info; then
    rm $PROB/$PROB.nb.info
fi


#Borrar resultados c4.5
if test -f $PROB/$PROB.tree.info; then
    rm $PROB/$PROB.tree.info
fi

#Borrar resultados knn
if test -f $PROB/$PROB.knn.info; then
    rm $PROB/$PROB.knn.info
fi	  

for i in `seq 1 5`;
do
	d=$((2**$i))
	echo "\nd:$d"
	(cd $PROB;./$PROB 10000 $d "0.78")
	./parametrizar $PROB/$PROB.nb $d
	./parametrizar $PROB/$PROB.net $d
	./parametrizar $PROB/$PROB.knn $d
	cp $PROB/$PROB.data $PROB/$PROB.test
	for j in `seq 1 20`;	
	do	
		echo "iter $j"
		cd $PROB
		./$PROB 250 $d "0.78" # Crear test
		

		#Correr c4.5
		c4.5 -f $PROB -u >> $PROB.info
		(cd ..;./readFile $PROB/$PROB.info $d >> $PROB/$PROB.tree.info;rm $PROB/$PROB.info)

		
		# Correr back propagation
		bp $PROB >> $PROB.nn.info
		
		# Correr naive bayes
		nb $PROB >> $PROB.nb.info		

		# Correr knn
		knn $PROB >> $PROB.knn.info
		cd ..
	done
done

