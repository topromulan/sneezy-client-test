
#######
# a perl shell tbag leaf to...
#
#

use pms::tmsg;
use pms::argverify;

tmsg "YourFunctionHere init", -2;

#...

sub YourFunctionHere {

	return unless argverify(\@_, 0, "your sub error message if bad args are passed");



}





#return true to please perl
;1;
