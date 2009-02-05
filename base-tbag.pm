#
# TurtleShell v2
# Copyright(c) 2003-2009 Dale R. Anderson
#

#######
# a perl shell tbag leaf to...
#
#



use pms::tmsg;
use pms::argverify;

#...

$cmd_syntax = "Write command syntax for #YourFunctionHere"

sub tcmd_YourFunctionHere {

	return unless argverify(\@_, 0, "your sub error message if bad args are passed");



}





#return true to please perl
;1;
