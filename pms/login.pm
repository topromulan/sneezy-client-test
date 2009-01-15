


#######
# a perl shell module to login to SneezyMUD
#
#

use pms::tmsg;
use pms::argverify;

tmsg "login code init", -2;

#...


# -- # ==============
# -- #  -- Block statistics
# -- # ----------
# -- # Bytes:   261
# -- # Newlines:        10
# -- # Escapes:         0
# -- #  -- Hex dump:
# -- # ----------
# -- # 0x0a 0x0a 0x0d 0x57  0x65 0x6c 0x63 0x6f 
# -- # 0x6d 0x65 0x20 0x74  0x6f 0x20 0x53 0x6e 
# -- # 0x65 0x65 0x7a 0x79  0x4d 0x55 0x44 0x20 
# -- # 0x76 0x35 0x2e 0x32  0x3a 0x0a 0x0d 0x54 
# -- # 0x68 0x75 0x20 0x4a  0x61 0x6e 0x20 0x20 
# -- # 0x38 0x20 
# -- # ---------- -- Data:
# -- # ----------
# -- # 
# -- # 
#Welcome to SneezyMUD v5.2:
#Thu Jan  8 02:22:26 PST 2009:
#Celebrating 16 years of quality mudding (est. 1 May 1992)
# -- # 
#Please type NEW (case sensitive) for a new account, or ? for help.
#If you need assistance you may email mudadmin@sneezymud.com.
# -- # 
# -- # 
#Login: 

# Maybe we could check the date is correct here to avoid fake
# Sneezy banners from the MITM. 
# (But no player should be able to inject \n so this is sort of safe
#  to assume this is a real login prompt).

sub login_packet {

	return unless argverify(\@_, 1, "login::login takes 1 arg");

	# This sub will scan the argument to see if it is a login prompt.
	# If so, it will return 1. Else, 0.

	if ( $_[0] =~ m/Welcome to SneezyMUD v5.2:\n.*Login: / )
	{
		return true;
	} else {
		return false;
	}


	#$ perl -e '$x="Hi\nI am it.\n\nLogin: "; print "Success\n" if $x =~ m/^Hi\n.*Login:/s'
	#Success




}





#return true to please perl
;1;
