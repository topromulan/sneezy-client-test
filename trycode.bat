
clear
echo

if [ "$*" == "live" ];
then

	perl -w veryfibers.pl -port 7900 -login sneezy.login -fubar 1 23 go

else

	perl -w veryfibers.pl -port 10000 -server localhost
fi

#perl -w argvtest.pl

#perl -w tests/debug.pl
#perl -w tests/argverifytests.pl

echo -trycode.bat finished-

