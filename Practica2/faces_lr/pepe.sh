#!/bin/bash

PROB="faces_lr"

if test -f $PROB.mse; then
    rm $PROB.mse
fi

bp $PROB

