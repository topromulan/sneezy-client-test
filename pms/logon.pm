


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
	return unless argverify(\@_, 1, "logon::setinfo takes 1 arg");

	unless ( $_[0] =~ m/^([.+\n.+\n])$/s ) {
		
		tmsg "Bad format for logon_setinfo().", 1;

		#reset to default
		$creds="Account\nPassword\n";

		#disable in sneezy 
		sautologon(0);

		return;

	}

	$creds = $1;

	sautologon(1);


}

#my $creds = "";
#logon_setinfo(0);


sub logon_packet {

	return unless argverify(\@_, 1, "logon::logon_packet takes 1 arg");

	# This sub will scan the argument to see if it is a logon prompt.
	# If so, it will return 1. Else, 0.

	if ( $_[0] =~ m/Welcome to SneezyMUD v5.2:\n.*Login: /s )
	{
		tmsg "logon_packet: true", -1;
		return 1;
	} else {
		tmsg "logon_packet: false", -1;
		return 0;
	}


	#$ perl -e '$x="Hi\nI am it.\n\nLogin: "; print "Success\n" if $x =~ m/^Hi\n.*Login:/s'
	#Success




}

sub logon_credentials {

	return $creds;
}





#return true to please perl
;1;
