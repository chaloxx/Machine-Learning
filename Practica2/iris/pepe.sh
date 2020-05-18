#!/bin/bash

PROB="iris"

if test -f $PROB.mse; then
    rm $PROB.mse
fi

./bp-mc $PROB

