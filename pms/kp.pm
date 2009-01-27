

# perl turtleshell keypunch reader
#
#
#

use strict;
use pms::tmsg;

use pms::hotkey_to_english;
use pms::english_to_hotkey;

use pms::quit;

tmsg "kp init", -2;

my $kp_memory=""; #a memory of the user's line of typing

#these variables contain strings that will be searched
#and hardcoded acted on in certain ways by kp()

#très bien, perl
my $kp_normal='abcdeéèëêfghiîïíìjklmnñoòóöôpqrstuùúûüvwxyzABCDEÉÈËÊFGHIÍÌÎÏJKLMNOÔÖÓÒPQRSTUÙÚÜÛVWXYZ1234567890 ;:~`!@#$%^&*()-_+=\|[]{}\'",.<>/?';

my $kp_backspace = "\x7f\x8";
my $kp_return = "\n\r";
my $kp_redraw = "\x12"; #^R
my $kp_clear = "\x15"; #^U
my $kp_prev = "\x10"; #^P
my $kp_next = "\xe"; #^N



my @kp_command_stack = ();


my $user_lark = 0;	# cmd in cmd stack
my $user_antic = 0;	# cursor position in kp memory

sub kp {
	
	return unless argverify(\@_, 1, "kp() call with non-1 args");

	my $key = $_[0];

	tmsg "kp got a ". hotkey_to_english($key) ."!", -3;

	#use length($key) instead of $key because '0' == false
	return unless length($key);

	$kp_memory="" unless defined($kp_memory);

	#$key = "\x1b[5F";
	# .. to avoid the regexps from interpreting ['s and ('s type things
	#   we must escape them with \'s, using $keyregex for pattern matching

	my $keyregex = "\Q$key\E";
	#$keyregex =~ s/\[/\\\[/;
	#$keyregex =~ s/\(/\\\(/;
	#$keyregex =~ s/\*/\\\*/;


	if($kp_normal =~ m/$keyregex/) {

		#echo is ON hard coded presently
		print $key;

		#here we need some smart
		$kp_memory .= $key;

	} elsif ($kp_return =~ m/$keyregex/) {

		#quickly create the image of pressing return button
		print "\n";

		#push the command they were so proud of onto the stack:
		#
		push @kp_command_stack, $kp_memory;

		#reflect the pressing of the button

		$user_lark = 0;
		$user_antic = 0;

		$kp_memory = "";

	} elsif ($kp_backspace =~ m/$keyregex/) {

		if(length($kp_memory) > 0) {
			$kp_memory =~ s/.$//;
			print "\x1b[D \x1b[D"; #left, space, left
		}
	
	} elsif ($kp_redraw =~ m/$keyregex/) {

		#notify the user that they pressed an important ctrl key
		print "^R\n$kp_memory";

	} elsif ($kp_clear =~ m/$keyregex/) {

		#notify the user that they pressed a ctrl key
		print "^U\n";

		$kp_memory = "";
		
	} elsif ($kp_prev =~ m/$keyregex/) {
		#notify the user that they pressed a ctrl key
		print "^P\n";

		#increase the amount of a lark the user is on..
		$user_lark++;

		$kp_memory = $kp_command_stack[$user_lark];

		#print "\x1b[3D";
		
		#maybe implement the antic to carry-over but not now...
		$user_antic = 0;

		print $kp_memory;

		

	###
	## the template for more
	#
	#} elsif ($kp_??? =~ m/$keyregex/) {
	#} elsif ($kp_??? =~ m/$keyregex/) {
	#} elsif ($kp_??? =~ m/$keyregex/) {
	#
	} elsif ($key eq "\x3") {

		tmsg "Hardcoded ^C quit - ok!", 3;
		quit();

	} else {

		tmsg "Unhandled keycode " . hotkey_to_english($key);
	}
}

#returns a reference to an array of any completed commands and clears the stack
sub kp_serve {

	return unless argverify(\@_, 0, "kp_serve does not take arguments");

	my @copy = @kp_command_stack;
	
	@kp_command_stack = ();

	return \@copy;
	
}

;1;
