#
# Turtle Shell SneezyMUD Client v2
# Copyright(c) 2003-2009 Dale R. Anderson
#



#######
# The #help Command
#
#

use pms::tmsg;
use pms::argverify;

tmsg "#help Command loading", -2;

#...


sub tcmd_help
{
	tmsg "TC #help called with @_";

	print "
	
	Here is your help!\n

	I think we should cat a file!\n
	
	\n";

}










#return true to please perl
;1;
