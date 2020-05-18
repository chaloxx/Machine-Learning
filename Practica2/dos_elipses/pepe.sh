#!/bin/bash

PROB="dos_elipses"



if test -f vals; then
   rm vals
fi




for j in `seq 1 20`;
do 
	echo $j
	if test -f $PROB.mse; then
		rm $PROB.mse
        fi		
	bp $PROB
	echo $(Rscript printMin.R) >> vals
done 
Rscript printMedian.R






if test -f $PROB.mse; then
   rm $PROB.mse
fi


#while [ $Bool -eq 1]
#do  
#	if test -f $PROB.mse; then
#		rm $PROB.mse
#	fi
 #      	bp $PROB
#	Res=$(./parse $(Rscript printRes.R))
#	echo $Res
#	Bool=$(`echo "$Res < .03" | bc`) 
#done


	
	
	



