#
# Turtle Shell SneezyMUD Client v2
# Copyright(c) 2003-2009 Dale R. Anderson
#

# perl turtleshell message output system
#
#
#
#

use strict;


my $msg_squelch = -2;
my $msg_default = 1;
my $msg_verbose = 1;
my $msg_hard = 0;

my $msg_stderr_bar = 2;

print "###### Turtle messaging initialization\n";

print "##  ##  - The bar for STDERR is set at: $msg_stderr_bar\n";
print "##  ##  - The user squelch is set at: $msg_squelch\n";

print "##  ##\n";


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

	## op = OutPut
	#
	my $op = "#";

	$op .= sprintf(" %2d #", $vol) if $msg_verbose;

	#pad with a space if f.l. is lowercase
	if($str =~ m/^[a-z]/) {
		$op .= " ";
	}

	#if multi-line..
	$str =~ s/\n/\n# -- # /g;

	$op .= $str;

	tmsg_dest_print ("\n", $vol) if $msg_hard;

	if($vol > $msg_squelch) {
		tmsg_dest_print ("$op\n", $vol);
	}

}

## 
#
# tmsg_dest_print()
#
#   A print command that may duplicate the print to stderr if 
#    the message level is above the $msg_stderr_bar
#
#   pretty lax 'cause only use is above in tmsg

sub tmsg_dest_print {
	
	my $str=$_[0];
	my $high=$_[1];

	my $err=0;
	
	$err=1 if $high > $msg_stderr_bar;

	print "\x1b[1;37m$str\x1b[0m" if $high < 10;

	print STDERR $str if $err;

}

sub set_tmsg_squelch {

	return unless argverify(\@_, 1, "set_tmsg_squelch() takes 1 arg");

	tmsg "Setting tmsg squelch to $_[0]", 2;

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
