#!/bin/bash

PROB="ssp"



if test -f $PROB.mse; then
    rm $PROB.mse
fi

./bp-wd $PROB


	
	
	



