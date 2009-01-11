


#######
# a perl shell module to clear the terminal
#
#

use pms::tmsg;
use pms::argverify;

tmsg "CLS init", -2;

#...

sub tcmd_cls {

	return unless argverify(\@_, 0, "CLS takes no arguments");

	print "\x1b[2J";



}





#return true to please perl
;1;
