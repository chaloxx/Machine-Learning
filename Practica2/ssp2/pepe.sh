#!/bin/bash

PROB="ssp2"



if test -f $PROB.mse; then
    rm $PROB.mse
fi

./bp-mb $PROB


	
	
	



