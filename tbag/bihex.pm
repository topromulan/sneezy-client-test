
#######
# a perl shell tbag leaf to...
#
#

use pms::tmsg;
use pms::argverify;

tmsg "bihex init", -2;

#...

sub tcmd_bihex {

	return unless argverify(\@_, 1, "bihex takes one argument");

	tmsg "The block input handler (bih) explorer! (bihex)", 1;

	#we're going to also dump this to std err as well as tmsg
	# and improve tmsg handling of multi-lines





}





#return true to please perl
;1;
