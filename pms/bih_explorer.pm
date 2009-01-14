


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

sub bih_explorer_add {

	return unless argverify(\@_, 1, "The bih() explorer takes one arg!");

	push @bih_explorer_array, $_[0];

	my $big = $#bih_explorer_array + 1;
	my $long = length($_[0]);

	tmsg "bih() explorer added one block! BEA is $big big and that one was $long long!", $biherrlvl;



}

#sub bih_explorer_dir {
#
	#my $n = @bih_explorer_array;
#
	#tmsg "bih_explorer: $n blocks", $biherrlvl;

#}

# Used by tcmd_bihex_dir

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
			"Block %d.) %d bytes", 
			$i, 
			length($bih_explorer_array[$i] )
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
        my $data = $bih_explorer_array[$_[0]];

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



	###################
	# hex dump

	#add the hex dump data to the analysis
	$ana .= " -- Hex dump:\n$separator\n";

        my $hexdump = ""; 

        my $copy = reverse $data;

        while(my $char = chop $copy) {
                $hexdump .= sprintf "0x%02x ", ord($char);
        }

	#split the hex dump into rows of 8 bytes
        $hexdump =~ s/((0x.. ){8})/$1\n/gm;
	#add a space after the 4th
        $hexdump =~ s/^((0x.. ){4})/$1 /gm;

	$ana .= "$hexdump\n$separator";

	###################
	# raw data

	#add the raw data to the analysis
	$ana .= " -- Data:\n$separator\n$data\n$separator\n";

	# translate any escape characters in the analysis into bold ESC
	$ana =~ s/\x1B/\x1B[1mESC\x1B0m/g;

	tmsg $hexdump, $biherrlvl;

	return "$ana\n============";

}






#return true to please perl
;1;
