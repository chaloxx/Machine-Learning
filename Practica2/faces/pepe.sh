#!/bin/bash

PROB="faces"

if test -f $PROB.mse; then
    rm $PROB.mse
fi

./bp-mc $PROB

