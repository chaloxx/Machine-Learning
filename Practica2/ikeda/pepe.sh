#!/bin/bash

PROB="ikeda"

Min=1
for j in `seq 1 20`;
do 

	echo $j
        if test -f $PROB.mse; then
            rm $PROB.mse
        fi
	bp $PROB
	Res=$(Rscript printMin.R) 
	if [ 1 -eq $(echo "${Res} < ${Min}" | bc) ];then
		cp $PROB.mse min.mse		
		Min=$Res
	fi	
done 

	
	
	



