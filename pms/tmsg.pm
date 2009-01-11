
# perl turtleshell message output system
#
#
#
#

use strict;

print "messaging initialization\n";

my $msg_squelch = -2;
my $msg_default = 1;
my $msg_verbose = 1;
my $msg_hard = 0;
## tmsg 
# string
# volume
sub tmsg {
##
#
	unless($_[0]) {
		print "\n#\n";
		return;
	}
	
	my $str=$_[0];

	my $vol=$msg_default;
	$vol = $_[1] if defined($_[1]);

	my $op = "#";

	$op .= sprintf(" %2d #", $vol) if $msg_verbose;

	#pad with a space if f.l. is lowercase
	if($str =~ m/^[a-z]/) {
		$op .= " ";
	}

	$op .= $str;

	print "\n" if $msg_hard;

	if($vol > $msg_squelch) {
		print "$op\n";
	}

}

sub set_tmsg_squelch {

	return unless argverify(\@_, 1, "set_tmsg_squelch() takes 1 arg");

	# **** should verify this is a number

	$msg_squelch = $_[0];

}

	
sub msg_test {


	print "This is how your tmsg() calls will look:\n\n";

	tmsg "Debug", -1;
	tmsg "Spam", 0;
	tmsg "Info", 1;
	tmsg "Note", 2;
	tmsg "Error", 3;

	print "\n";

}




1;
