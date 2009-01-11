
#######
# a perl shell tbag leaf to...
#
#

use pms::tmsg;
use pms::argverify;

tmsg "bihex init", -2;

#...

# syntax:
#
# #bihex dir
# #bihex dir 23-35
# #bihex grep sword
# #bihex grep sword [23-35]
# 
# #bihex show 23
#

sub tcmd_bihex {

	return unless argverify(\@_, 1, "bihex takes one argument");

	tmsg "The block input handler (bih) explorer! (bihex)", 1;

	#we're going to also dump this to std err as well as tmsg
	# and improve tmsg handling of multi-lines







}





#return true to please perl
;1;
