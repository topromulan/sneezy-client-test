#
# Turtle Shell SneezyMUD Client v2
# Copyright(c) 2003-2009 Dale R. Anderson
#



#######
# The #alias Command for adding aliases
#
#	Syntax: #alias <alias> <...>
#
#		<alias> is 1 word
#		<...> is what the alias expands to
#
#	<...> may contain $1, $2 etc. for user arguments
#
#	EXAMPLE
#
#	#alias run $2*$1

# the aliases will be stored in a global hash
#  but where do we define it, here?
#  are we going to add a method to add handlers to LP, and this module should 
#    define the hash and add the handler?


use pms::tmsg;

tmsg "#alias Command loading", -2;

#...

$cmd_syntax = "Write command syntax for #alias..";

sub tcmd_alias
{
	tmsg "TC #alias called with @_";

	#must have at least 2 args..
	if($#_ < 1) {
		tmsg $cmd_syntax, 2;
		return;
	}

	#ok.. alias_add() will error out if invalid
	
	my $aname = $_[0];		#The first argument
	my $aval = "@_[1..$#_]"; 	#The rest, stuck into a string

	tmsg "tcmd_alias_add(): Now $aname is being aliased to '$aval'!", 1;

	alias_add($aname, $aval);


}










#return true to please perl
;1;
