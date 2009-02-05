#
# Turtle Shell SneezyMUD Client v2
# Copyright(c) 2003-2009 Dale R. Anderson
#



#######
# a perl shell module to process comma seperated values
#
#

use pms::tmsg;
use pms::argverify;

tmsg "lp::csv init", -2;

use pms::lp;

sub csv {
	
	return unless argverify(\@_, 1, "csv() requires exactly one arg");

	my $arg = $_[0];

	unless($arg =~ m/\S,\S/) {
		tmsg "pms::lp::csv() called with invalid arg '$arg'";
		return;
	}

	$arg =~ m/(.*?)(\S+,\S[\S,]*)(.*)/;
	my $uno = $1;
	my $dos = $2;
	my $tres = $3;

	foreach my $t (split(',', $dos)) {
		lp($uno . $t . $tres);
	}
}

#return true to please perl
;1;
