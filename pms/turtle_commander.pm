#
# Turtle Shell SneezyMUD Client v2
# Copyright(c) 2003-2009 Dale R. Anderson
#



#######
# Turtle Commander
#
#  Load all the Turtle Commands into the program
#

use pms::tmsg;
use pms::argverify;

tmsg "Turtle Commander init", -2;

#...


##
#
#  this sub returns a list of the use statements for veryfibers
#

sub tcmd_scan {

	tmsg "Turtle Command: Scanning for Turtle Commands.", 1;

	#open up the tbag/ directory
	#  and load up all the tcmd_* with eval
	
	
	opendir(TBAG, "tbag/");
	
	#the extra . at the beginning to avoid the blank "# command!" file the tbag script has a 
	# habit of creating..
	my @files = grep (/.\.pm$/, readdir(TBAG));
	
	closedir(TBAG);
	
	#proceed
	#
	# **** is there just a regex to do this

	my $use;

	foreach $leaf (@files) {

		tmsg "Turtle command file: $leaf\n", -2;

		$leaf =~ s/\.pm$//;

		$use .= "use tbag::$leaf;\n";
		
	}

	return $use;


}

	

	
	

#find all the turtle command files
#
	
#load each one up and check for success
#
	







#return true to please perl
;1;
