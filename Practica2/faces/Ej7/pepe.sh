#!/bin/bash
DIR="Paralelo"
FILE="paralelo"

if test -f "res.txt"; then
    rm "res.txt"
fi
for i in `seq 1 5`;
do
	d=$((2**$i))
	echo $d
        cd $DIR	
	./$FILE 10000 $d 0.78
	cp $FILE.data $FILE.test
	for j in `seq 1 20`;
	do	
		./$FILE 250 $d 0.78
		c4.5 -f $FILE -u > $FILE.info
		cd ..		
		./readFile $DIR/$FILE.info $d >> res.txt
		cd $DIR
	done
	cd ..
done

