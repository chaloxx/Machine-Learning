#!/bin/bash
DIR="Paralelo"
FILE="paralelo"

if test -f "res.txt"; then
    rm "res.txt"
fi

if test -f "bayes.txt"; then
    rm "bayes.txt"
fi

for i in `seq 1 5`;
do
        c=$(bc <<< "scale=2;1/2*$i")
        cd $DIR	
	./$FILE 10000 5 $c
	cp $FILE.data $FILE.test
	for j in `seq 1 20`;
	do	
		./$FILE 250 5 $c
		c4.5 -f $FILE -u > $FILE.info
		cd ..		
		./readFile $DIR/$FILE.info $c >> res.txt
		cd $DIR
	done	
	cd ..
	./bayes $FILE $c >> bayes.txt
done

