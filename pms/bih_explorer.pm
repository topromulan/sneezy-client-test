


#######
# a perl shell module to explore bih blocks
#
#

use strict;
use pms::tmsg;
use pms::argverify;

tmsg "The bih() explorer! init", -2;

#...

my @bih_explorer_array;

my $biherrlvl=5; # 

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
		tmsg "an entry!!";
		$listing .= bih_explorer_dir_entry($n) . "\n";

	}

	return $listing;

}

sub bih_explorer_dir_entry {

	tmsg "Before";

	my $entry = sprintf ("Block %d.) %d bytes", 
		$_[0], 
		length($bih_explorer_array[$_[0]] )
		);
		#$_[0],
		#strlen($bih_explorer_array[$_[0]] )
		#
		#);
	
	tmsg "AFter";

	return $entry;

}


sub bih_explorer_show {

	return unless argverify(\@_, "1n", "bih_explorer_show() requires 1 arg");
	
        #This is the raw data from Telnet
        my $data = $bih_explorer_array[$_[0]];

        #Begin constructing a multi-line string of the analysis.
        my $ana = "Analysis:\n--------";

        my $hexdump = ""; #Start with a hex dump

        my $copy = reverse $data;

        while(my $char = chop $copy) {
                $hexdump .= sprintf "0x%3x ";
        }

        $hexdump =~ s/(0x... ){8}/$1\n/;

	tmsg $hexdump, $biherrlvl;






	##my $n = $_[0];
#
	#my $buff = @bih_explorer_array[$n];
#
	#$buff =~ s/\x1b/ESC/g;
	#$buff =~ s/\n/\\n/g;
	#$buff =~ s/\r/\\r/g;
#
#
#
	#tmsg $buff, $biherrlvl;
}






#return true to please perl
;1;
