


#######
# block input handler
#
#

# handle a block of raw sneezy data
# seperate it into lines for processing/logging
# keep hold of a buffer of any incomplete line or incomplete ansi code information
# release complete lines and complete ansi codes

# what we really need to worry about is blocking all output
#  between the time the cursor jumps down into the fuel gauges and 
#  comes back.. partial lines are a concern also
# 

# so bih only releases full lines or full ansi sequences, and a jump/return
#  compound ansi sequence is considered stolid

use strict;
use pms::tmsg;
use pms::argverify;

use pms::bih_explorer;

tmsg "bih init", -2;

#...

my $bihbuffer = "";

sub bih {


	tmsg "bih sub", -2;

	return unless argverify(\@_, 1, "block input handler bih() requires 1 arg");
	

	my $block = $_[0];
	my $export;
	#append it to anything in the buffer, and erase the buffer

	## BIH Explorer. Put the raw block in the buffer.
	#
	bih_explorer_add $block;

	print $block;
	
}




#return true to please perl
;1;
