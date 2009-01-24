


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

use pms::bih_explorer;

tmsg "bih init", -2;

#...

my $bihbuffer = "";

sub bih {


	tmsg "bih sub", -2;

	return unless argverify(\@_, 1, "block input handler bih() requires 1 arg");
	

	my $block = $_[0];

	
	## BIH Explorer. Put the raw block in the buffer.
	#
	my $blocknum = bih_explorer_add $block;
	#
	##

	#append it to anything in the buffer for export, then erase the buffer.
	# below we will transfer $working into $export and leave any remainder
	# back in $bihbuffer

	my $working = $bihbuffer . $block;
	$bihbuffer = "";

	my $export = "";

	##
	#
	# Check for unfinished jump/return 
	#  and buffer from the jump on
	#
	# ESC7 		= save pos
	# ESC[x;yH	= jump
	# ESC8 		= return to saved pos
	#

	#unfinished ANSI codes
	#unfinished lines that are not prompts
	#jump codes that do not have returns

	#asdfasdfJUMPasdfasdfRETURNasdfadsf
	#asdfasdfasdfaJUMPadsfadsfRET
	
	# suck all these off the top at once:
	#      s/^(.*?JUMP.*RETURN)//
	#  no greed ^      ^ greed ok

	if ( $working =~ s/^(.*?\x1b\[[0-9;]+H.*\x1b8)//ms ) {
		tmsg "\x1b[35mbih($blocknum) sucked jump/returns off", 10;
		$export .= $1;
	}

	# now get anything prior to any jump that may be left
	#     s/^(.*)(JUMP)/$2/
	
	if ( $working =~ s/^(.*)(\x1b\[[0-9;]+H)/$2/ms ) {
		tmsg "\x1b[36mbih($blocknum) has a jump to buffer", 10;
		$export .= $1;
	} 
	
	# if that was not the case check for unfinished codes and lines
	#     s/^(.*)//
	
	else 
	{
		# first, export any complete lines

		if ( $working =~ s/^(.*\n)//ms ) {
			tmsg "\x1b[33mbih($blocknum) had some whole lines left", 10;
			$export .= $1;
		}

		# now take anything left up to an unfinished vt100 code

		if ( $working =~ s/^(.*\x1b(8|[0-9;]*[A-Za-z]))//ms ) {
			tmsg "\x1b[34mbih($blocknum) had some more valid codes", 10;
			$export .= $1;
		}

		# if there is an escape code left.. take up to it

		if ( $working =~ s/^([^\x1b]*)\x1b/\x1b/ms ) {
			tmsg "\x1b[34mbih($blocknum) there is an incomplete vt100 code", 10;
			$export .= $1;
		}

	}
		
	# **** wish this fit in above but.. 
	#        check what we got to export and if there is an incomplete
	#        line make sure it is a prompt

	if( $working !~ m/\n$/ms ) {
		tmsg "\x1b[35mbih($blocknum) export doesn't end in a newline", 10;
		if( $working !~ m/\n$/ms ) {
			tmsg "\x1b[36mbih($blocknum) ..but that's OK it's a prompt", 10;
			$export .= $working;
			$working="";
			
		}
	}

	

	if ( length($working) > 0) {
		tmsg "\x1b[38mbih($blocknum) did buffer some info", 10;
		$bihbuffer = $working;
	}

	my $tmp = $export;
	$tmp =~ s/\x1b/ESC/msg;
	$tmp =~ s/\r/\\r/msg;
	tmsg "\x1b[32mThe export on bih($blocknum) is:\n $tmp", 10;
	$tmp = $bihbuffer;
	$tmp =~ s/\x1b/ESC/msg;
	$tmp =~ s/\r/\\r/msg;
	tmsg "\x1b[31mThe buffer on bih($blocknum) is:\n $tmp", 10;
	
	print $export;
	return;

	#if ( $export =~ m/.*(\x1b\[[0-9]+;[0-9]+H.*)$/ )
	#{
		#tmsg "\x1b[33mBlock $blocknum has a jump", 2;
#
		#my $lastjumpon = $1;
#
		#if($jumpon !~ m/\x1b8/ || 
			#$jumpon =~ m/\x1b8.*\x1b\[[0-9;]+H
		#{
			##no return
			#tmsg "\x1b[31mBlock $blocknum jump was unfinished", 2;
#
			#my $tmp = $jumpon;
			#$tmp =~ s/\x1b/ESC/mg;
			#$tmp =~ s/\r/\\r/mg;
			#tmsg "\x1b[32mbuffered $tmp", 3;
#
			##put that part in the buffer:
			#$bihbuffer = $jumpon;
#
			##and cut it off the export
			##this doesn't work.. $export =~ s/$lastjumpon$//;
			#$export = substr (
				#$export,
				#0,
				#length($export) - length($jumpon) -1
				#);
#
			#$tmp = $export;
			#$tmp =~ s/\x1b/ESC/mg;
			#$tmp =~ s/\r/\\r/mg;
			#tmsg "\x1b[33mexporting$tmp", 3;
#
		#}
	#}

	#print $export;
	
}




#return true to please perl
;1;
