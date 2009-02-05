#
# Turtle Shell SneezyMUD Client v2
# Copyright(c) 2003-2009 Dale R. Anderson
#



#######
# a perl shell module to split commands on semi colons
#
#

use pms::tmsg;
use pms::argverify;
use pms::lp;

tmsg "lp::scs init", -2;

sub scs {

	return unless argverify(\@_, 1, "scs() requires exactly 1 argument");

	my $arg = $_[0];

	foreach my $littletimmy (split(';', $arg)) {
		lp ($littletimmy);
	}
}


#return true to please perl
;1;
