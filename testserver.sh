
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

# **** this is screwed up right now i think because tail -f never dies
# **** just restart the server while the client is trying to connect

while true 
do 
	loginprompt > sneezy.namedpipe &

	tail -f sneezy.namedpipe | tcplisten -irv 10000

	asdf again

done
