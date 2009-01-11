


#######
# a perl shell module to clear the terminal
#
#

use pms::tmsg;
use pms::argverify;

tmsg "CLS init", -2;

#...

sub tcmd_cls {

	return unless argverify(\@_, 0, "your sub error message if bad args are passed");



}





#return true to please perl
;1;
