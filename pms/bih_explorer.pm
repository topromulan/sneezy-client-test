


#######
# a perl shell module to explore bih blocks
#
# bih.pm adds in blocks of raw telnet data it recieves 
#     by calling bih_explorer_add()
#
# some of these functions are called by tbag/bihex.pm
#

use strict;
use pms::tmsg;
use pms::argverify;

tmsg "The bih() explorer! init", -2;

#...

my @bih_explorer_array;

my $biherrlvl=-1; # 

sub bih_explorer_add_block {

	return unless argverify(\@_, 1, "The bih() explorer takes one arg!");

	push @bih_explorer_array, {};

	my $n = $#bih_explorer_array;

	$bih_explorer_array[$n]{block} = $_[0];

	my $long = length($_[0]);

	tmsg "bih() explorer added one block! That is block $n and that one was $long long!", $biherrlvl;

	
	return $n;

}

sub bih_explorer_add_buffer {
	return unless argverify(\@_, 2, "add buffer takes two args");

	my $n = $_[0];
	my $buf = $_[1];

	if ( $n > $#bih_explorer_array )
	{
		#this should never happen.. just called by bih
		tmsg "error. buffer n > #BEA", 3;
		return;
	}

	$bih_explorer_array[$n]{buffered} = $buf;

}
sub bih_explorer_add_export {
	return unless argverify(\@_, 2, "add export takes two args");

	my $n = $_[0];
	my $exp = $_[1];

	if ( $n > $#bih_explorer_array )
	{
		#this should never happen.. just called by bih
		tmsg "error. export n > #BEA", 3;
		return;
	}

	$bih_explorer_array[$n]{exported} = $exp;

}



# Used by tcmd_bihex_dir .. should make a function to return the array size
#  and it can call dir_entry itself for the full list

sub bih_explorer_dir {

	tmsg "bih explorer dir!!";

	my $listing = "";
	my $big = $#bih_explorer_array;

	for (my $n=0; $n<=$big; $n++) {
		$listing .= bih_explorer_dir_entry($n) . "\n";

	}

	return $listing;

}

sub bih_explorer_dir_entry {

	my $i = $_[0];

	my $entry;

	if( ($i >= 0) && ($i <= $#bih_explorer_array) )
	{
		$entry = sprintf (
			"Block %d.) %4d bytes. %4d exported, %4d buffered.", 
			$i, 
			length($bih_explorer_array[$i]{block} ),
			length($bih_explorer_array[$i]{exported} ),
			length($bih_explorer_array[$i]{buffered} )
			);
	} else {
		$entry = sprintf (
			"Block %d.) INVALID BLOCK NUMBER",
			$i
			);
	}
	
	return $entry;

}


sub bih_explorer_show {

	return unless argverify(\@_, "1n", "bih_explorer_show() requires 1 arg");
	
        #This is the raw data from Telnet
	# **** this should check that it is valid number
        my $data = $bih_explorer_array[$_[0]]{block};

        #Begin constructing a multi-line string of the analysis.
        my $ana = " -- Analysis:\n==============\n";

	my $separator = "----------";


	###################
	# block stats

	$ana .= " -- Block statistics\n$separator\n";

	$ana .= sprintf
		(
			"Bytes: \t%d\n"		.
			"Newlines: \t%d\n"	.
			"Escapes: \t%d\n",

			length($data),
			$data =~ tr/\n//,
			$data =~ tr/\x1B//
		);

	#add the hex dump data to the analysis
	$ana .= " -- Hex dump of block:\n$separator\n";
	$ana .= bih_explorer_hexdump ( $data );


	#$ana .= " -- Hex dump of export:\n$separator\n";
	#$ana .= bih_explorer_hexdump ( $bih_explorer_array[$_[0]]{exported} );

	$ana .= " -- Hex dump of buffered data:\n$separator\n";
	$ana .= bih_explorer_hexdump ( $bih_explorer_array[$_[0]]{buffered} );


}

sub bih_explorer_hexdump {

	return unless argverify(\@_, 1, "bih_explorer_hexdump() requires 1 arg");

	###################
	# hex dump

        my $hexdump = "===========\n"; 

        my $copy = reverse $_[0];	#is there a chop for the first char?

        while(length(my $char = chop $copy) == 1) {

		#display the hex value
                $hexdump .= sprintf "0x%02x ", ord($char);

		#display the char or a description
		# widths should be: 4 with at least one trailing space

		if (ord($char) >= 0x20) {
			#display the literal character
			$hexdump .= " $char  ";
		} else {
			#display a descriptive string for common
			# control characters or else a dot

			if($char eq "\x1b") {
				#ESC
				$hexdump .= 'ESC ';
			} elsif($char eq " ") {
				#SPACE
				$hexdump .= "' ' ";
			} elsif($char eq "\r") {
				#CARRIAGE RETURN
				$hexdump .= ' \r ';
			} elsif($char eq "\n") {
				#LINE FEED
				$hexdump .= ' \n ';
			} else {
				#Something else
				$hexdump .= ' .  ';
			}


		}


	}
	
	#split the hex dump into rows of 8 bytes
        #$hexdump =~ s/(0x.. 0x.. 0x.. 0x.. 0x.. 0x.. 0x.. 0x.. )/$1\n/gm;
        $hexdump =~ s/(0x.. ... 0x.. ... 0x.. ... 0x.. ... 0x.. ... 0x.. ... 0x.. ... 0x.. ... )/$1\n/gm;
	#add an extra space after the 4th
        $hexdump =~ s/^((0x.. ... ){4})/$1 /gm;


	return "$hexdump\n==========\n";

}




#return true to please perl
;1;
