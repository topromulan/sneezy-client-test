
clear
echo

if [ "$*" == "live" ];
then

	perl -w veryfibers.pl -port 7900 -login ~/.sneezy.login -squelch 0

else

	perl -w veryfibers.pl -port 10000 -server localhost -squelch -3
fi

#perl -w argvtest.pl

#perl -w tests/debug.pl
#perl -w tests/argverifytests.pl

echo -trycode.bat finished-

