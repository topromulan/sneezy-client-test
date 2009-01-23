


#######
# a perl shell module to logon to SneezyMUD
#
#

use pms::tmsg;
use pms::argverify;

use pms::sneezy;

tmsg "logon code init", -2;

#...


# Maybe we could check the date is correct here to avoid fake
# Sneezy banners from the MITM. 
# (But no player should be able to inject \n so this is sort of safe
#  to assume this is a real logon prompt).


# called by veryfibers
sub logon_setinfo {

	#return unless argverify(\@_, , "logon::setinfo takes 2 args");

	$creds = sprintf("@_");

	$creds =~ s/^\s*//msg;

	sautologon(1);


}

sub logon_packet {

	return unless argverify(\@_, 1, "logon::logon_packet takes 1 arg");

	# This sub will scan the argument to see if it is a logon prompt.
	# If so, it will return 1. Else, 0.

	if ( $_[0] =~ m/\rLogin: $/ )
	{
		tmsg "logon_packet: TRUE", -1;
		return 1;
	} else {
		tmsg "logon_packet: FALSE", -1;
		return 0;
	}




}

sub logon_credentials {

	return $creds;
}





#return true to please perl
;1;
