


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

	tmsg "bih() explorer adding one block!", $biherrlvl;



}

sub bih_explorer_dir {

	my $n = @bih_explorer_array;

	tmsg "bih_explorer: $n blocks", $biherrlvl;

}

sub bih_explorer_show {

	return unless argverify(\@_, "1n", "bih_explorer_show() requires 1 arg");
	
	my $n = $_[0];

	my $buff = @bih_explorer_array[$n];

	$buff =~ s/\x1b/ESC/g;
	$buff =~ s/\n/\\n/g;
	$buff =~ s/\r/\\r/g;

	tmsg $buff, $biherrlvl;
}






#return true to please perl
;1;
