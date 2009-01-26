
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
