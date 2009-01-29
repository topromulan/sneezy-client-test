#!/bin/bash

# Test Server for Turtle Shell v2 development
# Copyright(c) 2009 Dale R. Anderson



# This handy test server works pretty well for a bash script.
#
#  It should send a login message after 5 seconds from a connection
# you can send more "MUD" server data via the file sneezy.namedpipe
# while the client is connected.
#

function asdf { 
	echo Listening on port 10000 $*
}

asdf

if [ -e sneezy.namedpipe ]; 
then
	rm sneezy.namedpipe;
fi

mkfifo sneezy.namedpipe

function loginprompt {
	sleep 5
	cat sneezy.loginprompt
}


while true 
do 
	loginprompt > sneezy.namedpipe &

	tail -f sneezy.namedpipe | 
		(
		tcplisten -irv 10000

		#have to do this to or else tail never dies and
		# the test server doesn't restart..
		echo "\x1C" > sneezy.namedpipe
		)

	asdf again

done
