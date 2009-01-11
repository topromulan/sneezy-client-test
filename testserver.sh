
function asdf { 
	echo Listening on port 10000 $*
}

asdf

while tcplisten -irv 10000; do asdf again; done

