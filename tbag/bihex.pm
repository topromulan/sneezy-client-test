
#######
# a perl shell tbag leaf to...
#
#

use pms::tmsg;
use pms::argverify;

tmsg "bihex init", -2;

#...

$cmd_syntax = 

	"\n#bihex syntax:\n\n" .
	"#bihex dir\n" .
	"#bihex dir [range]\n" .
	"  ex. #bihex dir 23-35\n" .
	"\n" .
	"#bihex grep [word]\n" .
	"#bihex grep [word] [range]\n" .
	"  ex. #bihex grep sword 23-35\n" .
	"\n" .
	"#bihex show [block number]\n" .
	"  ex. #bihex show 23\n";

sub tcmd_bihex {

	print "Bihex certainly was called!\n";

	tmsg "The block input handler (bih) explorer! (bihex)", 1;

	tmsg "Args bihex got are: @_", 1;

	#might be no word
	if ( !defined $_[0] ) {
		tmsg $cmd_syntax, 2;

	}
	#first word may be dir, grep, or show
	elsif ( $_[0] eq "dir" ) {
		tcmd_bihex_dir(@_[1..$#_]);

	} elsif ( $_[0] eq "grep" ) {
		tcmd_bihex_grep(@_[1..$#_]);

	} elsif ( $_[0] eq "show" ) {
		tcmd_bihex_show(@_[1..$#_]);

	} else {
	#flunk!
		tmsg "Invalid syntax for #bihex.", 2;
		tmsg $cmd_syntax, 0;
	}
		
	# Have a nice day.

}


sub tcmd_bihex_dir {



	#there could be no args
	if(!defined($_[0])) {

		tmsg bih_explorer_dir(), 3;

	} 
	#could be a range
	elsif ($#_ == 1 && $_[0] =~ m/^([0-9]+)-([0-9]+)$/ ) {
		#That's great they used a valid syntax.
		my $begin = $1;
		my $end = $2;

		my $out = "";

		for($n=$1; $n<=$2; $n++) {
			$out .= bih_explorer_dir_entry $n;
		}

		tmsg $out, 3;


	} else {
	#flunk!
		tmsg "Invalid syntax for #bihex dir.", 2;
		tmsg $cmd_syntax, 0;
	}
	

}

# Have to call over into pms::bih_explorer to get info.
#  used only by tcmd_bihex_dir
sub tcmd_bihex_dir_entry {

	return sprintf "%d.)\t%s\n", $_[0], bih_explorer_dir_entry();


}












sub tcmd_bihex_grep {

	if (1) {
	} else {
	#flunk!
		tmsg "Invalid syntax for #bihex grep.", 2;
		tmsg $cmd_syntax, 0;
	}

}

sub tcmd_bihex_show {

	if (1) {
	} else {
	#flunk!
		tmsg "Invalid syntax for #bihex show.", 2;
		tmsg $cmd_syntax, 0;
	}

}


#return true to please perl
;1;
