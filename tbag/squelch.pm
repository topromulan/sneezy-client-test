#
# Turtle Shell SneezyMUD Client v2
# Copyright(c) 2003-2009 Dale R. Anderson
#



#######
# The #squelch Command
#
#

use pms::tmsg;
use pms::argverify;

tmsg "#squelch Command loading", -2;

#...


sub tcmd_squelch
{
	tmsg "TC #squelch called with @_", -1;

	if($#_ == 0) {
		tmsg "Got one", 1;
	} else {
		tmsg "Got $#_", 1;
	}

	set_tmsg_squelch($_[0]);



}










#return true to please perl
;1;
