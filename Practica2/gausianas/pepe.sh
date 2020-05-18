#!/bin/bash
PROB="diagonal"

if test -f $PROB.txt; then
    rm $PROB.txt
fi
for i in `seq 1 5`;
do
	d=$((2**$i))
	echo $d
	(cd $PROB;./$PROB 10000 $d "0.78")
	./parametrizar $PROB/$PROB.net $d
	cp $PROB/$PROB.data $PROB/$PROB.test
	for j in `seq 1 20`;
	do	
		
		cd $PROB
		if test -f $PROB.mse; then
			rm $PROB.mse
		fi
		./$PROB 250 $d "0.78"
		bp  $PROB 
		Res=$(Rscript printMin.R) 
		cd ..
		echo "$d $Res" >> $PROB.nn		
	done
done

