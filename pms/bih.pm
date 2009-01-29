#
# Turtle Shell SneezyMUD Client v2
# Copyright(c) 2003-2009 Dale R. Anderson
#



#######
# block input handler
#
#

# handle a block of raw sneezy data
# keep hold of a buffer of anything we shouldn't print yet

# what we need to worry about is blocking all program output
#  between the time the cursor jumps down into the fuel gauges and 
#  comes back.. 
#	maybe later worry about incomplete lines (besides a prompt..) 
#	generally perhaps b etter not to hold on the middle of a 
#		room description or something though due to latency

# so bih only releases full lines or full ansi sequences, and a jump/return
#  compound ansi sequence is considered stolid

use strict;
use pms::tmsg;
use pms::argverify;

use pms::doh;

use pms::bih_explorer;

tmsg "bih init", -2;

#...

my $bihbuffer = "";

sub bih {

	tmsg "bih sub", -2;

	return unless argverify(\@_, 1, "block input handler bih() requires 1 arg");
	
	my $block = $_[0];

	## the explorer would like a copy of the block
	#
	bih_explorer_add_block $block;

	##
	# handle the block
	#

	doh_block "$block"; #quotes to preven undefined value

	return;
	
}




#return true to please perl
;1;
