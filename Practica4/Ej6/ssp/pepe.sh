#!/bin/bash


if test -f knn.info; then
    rm knn.info
fi	  


if test -f bp.info; then
    rm bp.info
fi	

for i in `seq 1 20`;
do
	echo $i	        		        
	knn ssp
        cat ssp.error >> knn.info
	bp ssp
	cat ssp.mse  >> bp.info
done

