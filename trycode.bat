#!/bin/bash

# trycode.bat
# Test script for running TurtleShell v2
# 
# Execute this with no argments to connect to the local server (testserver.sh)
# Execute with the following syntax to connect to actually connect SneezyMUD
#
# ./trycode.bat live
#

clear
echo

if [ "$*" == "live" ];
then

	perl -w veryfibers.pl -port 7900 -logon ~/.sneezy.creds -squelch 0

else

	perl -w veryfibers.pl -port 10000 -server localhost -squelch -3 -logon test.credentials
fi

echo -trycode.bat finished-

