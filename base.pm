#
# TurtleShell v2
# Copyright(c) 2003-2009 Dale R. Anderson
#



#######
# a perl shell module to...
#
#


use pms::tmsg;
use pms::argverify;

tmsg "[your module name here] init", -2;

#...

sub yoursubgoeshere {

	return unless argverify(\@_, 0, "your sub error message if bad args are passed");



}





#return true to please perl
;1;
