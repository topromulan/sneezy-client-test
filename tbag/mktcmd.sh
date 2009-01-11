#!/bin/bash

if [ -e "$1" ]
then
	echo Error: File $1.pm exists already.
	exit 1
fi

if [ ! -e tcmd_base.pm.txt ]
then
	echo Error: tcmd_base.pm.txt not found!
	exit 1
fi

cat tcmd_base.pm.txt |
	sed 's/--\(#*\)TCMD--/\1'$1'/g' > $1.pm

cat $1.pm
	
