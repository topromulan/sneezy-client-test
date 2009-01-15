
clear
echo

if [ "$*" == "live" ];
then

	perl -w veryfibers.pl -port 7900 -logon ~/.sneezy.creds -squelch 0

else

	perl -w veryfibers.pl -port 10000 -server localhost -squelch -3 -logon test.credentials
fi

echo -trycode.bat finished-

