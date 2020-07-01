#!/bin/bash
PROB="diagonal"


if test -f $PROB/$PROB.knn.info; then
    rm $PROB/$PROB.knn.info
fi	  

for i in `seq 1 5`;
do
	d=$((2**$i))
	echo $d
	desvEst=$(cd $PROB;./$PROB 10000 $d "0.78")
	distMax=$(awk "BEGIN {print sqrt($d*(5*$desvEst)^2)}")
	./parametrizar2 $PROB/$PROB.knn $d $distMax
	cp $PROB/$PROB.data $PROB/$PROB.test
	for j in `seq 1 20`;	
	do	
		echo "iter $j"
		cd $PROB
		./$PROB 250 $d "0.78" # Crear test
		        		        
		# Correr knn
		knn $PROB >> $PROB.knn.info
		cd ..
	done
done

