
################
# perl turtleshell '#' command processor
#
#
# this is a module to handle # commands!
#
#

use strict;
use pms::tmsg;

tmsg "turtle_processor init", -2;



#use pms::turtle_processor::

sub turtle_processor {

	#verify args
	return unless argverify(\@_, 1, "turtle_processor requires *1* arg");

	my $arg = $_[0];

	tmsg "turtle_processor: handling '$arg'", -1;

	##temporary (permanent?) hardcoded debugging thing - # - print "hi"
	##
	if($arg =~ s/^# - //) {
		tmsg "Executing perl code: $arg", 2;
		eval("{ $arg }");
		return;
	}

	#cut out the first word
	#
	
	#we define these variables to act upon $arg with:
	my $turtleword; 
	my @turtleargs;

	#$arg =~ m/^#\s*(\w+)\s*([^\s]*\s.*)/;  # **** is \s space or all whitespace, i'd prefer the latter
	$arg =~ m/^#\s*(\w+)\s*([^\s]*.*)/;  # **** is \s space or all whitespace, i'd prefer the latter
	$turtleword = $1;
	tmsg "here I am, a turtleword: $turtleword\n", -2;
	@turtleargs = split(" ", $2) if defined($2);

	#HACK COUGH please add elegance:  please add your worst loaders
	#

	
	#test for existence of the turtleword somehow.. is perl introspective.. if not then need to keep a hash when we tcmd scan

	if(@turtleargs) {
		tmsg "turtle_processor: word '$turtleword' args '@turtleargs'", -1;
		eval "tcmd_$turtleword \@turtleargs" or tmsg "Unrecognized Turtle Command", 3;
	} else {
		tmsg "turtle_processor: word '$turtleword'", -1;
		eval "tcmd_$turtleword \@turtleargs" or tmsg "Unrecognized Turtle Command", 3;
	}


#turtle_bag/ contains all the turtle commands 
# tbag/squelch.pm
# tbag/list.pm

#the turtle commander loads them..
#
# turtle_commander.pm
		




}



1;

