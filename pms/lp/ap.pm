#
# Turtle Shell SneezyMUD Client v2
# Copyright(c) 2003-2009 Dale R. Anderson
#



#######
# a perl shell module to process aliases
#
#

use pms::tmsg;
use pms::argverify;
use pms::lp;
use pms::alias;

## ap() is currently mostly a sanity check, 
#  alias_process() is the real meat of processing the alias


sub ap {

	return unless argverify(\@_, 1, "ap() requires exactly 1 argument");

	my $arg = $_[0];
	my @args = ();

	foreach my $littletimmy (split(' ', $arg)) {
		push @args, $littletimmy;
	}

	my $cmdword = shift @args;

	if ( is_alias($cmdword) ) 
	{
		tmsg "ap(): cmdword is an alias, $cmdword";
	} else {
		tmsg "ap(): cmdword is not an alias - $cmdword. returning";
		return;
	}

	#What has gone before is essentially a sanity check
	# might just roll these into one long function
	#
	lp(alias_process($cmdword, @args));
}


##Example
#
#AliasHash = { intro="say hello", run=>"$2*$1", gb=>"get $1 bag"
sub alias_process {

	# alias_process("intro", []);
	# alias_process("run", ["n","5"]);
	# alias_process("gb", ["apple"]);
	#
	my @args = @_;
	my $cmdword = shift(@args);

	unless(is_alias($cmdword)) {
		tmsg "alias_process(): '$cmdword' is invalid. returning";
		return;
	}

	my $workstr = get_alias($cmdword);

	tmsg "Alias '$cmdword' is '$workstr', args are '@args'", -1;


	# **** Right now this is either/or, want to improve logic
	#       and possibly be able to do both. Maybe make aliases
	#       into hashes with properties besides their basic
	#       definition to expand behaviors.

	if($workstr =~ m/\$[0-9]/) {
	
		## substitute any arguments for $1 $2 etc.
		for(my $i=0; $i <= $#args; $i++)
		{
			my $n = $i + 1;
	
			$workstr =~ s/\$$n/$args[$i]/g;
		}
	} else {
		## stick any args onto the end.

		$workstr .= " @args";
	}


	my $finishedstr = $workstr;

	return $finishedstr;


}

#return true to please perl
;1;
