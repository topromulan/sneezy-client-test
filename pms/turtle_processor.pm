
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

#Notes:

#tbag/ contains all the turtle commands 
# tbag/squelch.pm
# tbag/list.pm

#the turtle commander loads them..
#
# turtle_commander.pm


sub turtle_processor {

	#verify args
	return unless argverify(\@_, 1, "turtle_processor requires *1* arg");

	my $arg = $_[0];

	tmsg "turtle_processor: handling '$arg'", -1;

	#################################################################
	##temporary (permanent?) hardcoded debugging thing - # - print "hi"
	##
	#################################################################
	if($arg =~ s/^# - //) {
		tmsg "Executing perl code: $arg", 2;
		eval("{ $arg }");
		return;
	}

	#################################################################
	
	#we define these variables to split up $arg into:
	my $turtleword; 
	my @turtleargs = [];

	#Pluck out the turtle word
	$arg =~ m/^#[\s\t]*(\w+)\s*([^\s]*.*)/;  

	#Now, the turtle command word is $1 and the args are $2

	$turtleword = $1;
	tmsg "The turtleword is: $turtleword", -2;

	@turtleargs = split(" ", $2) if defined($2);
	tmsg "The turtle arguments is: @turtleargs", -2;

	#HACK COUGH please add elegance:  please add your worst loaders
	#
	
	#Need to test for the existence of the turtle word somehow to prevent errors like this:

	##asdf
	#Array found where operator expected at (eval 7) line 1, at end of line
	#        (Do you need to predeclare tcmd_asdf?)
	#

	# Stumping me for 3 years now! Daikaiju DIE!

	# Go to main program level to evaluate
	
	tmsg "Evaluating $turtleword \@turtleargs", 3;
	eval "tcmd_$turtleword(\@turtleargs)";


		

}



1;

