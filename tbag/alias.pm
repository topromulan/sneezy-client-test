#
# Turtle Shell SneezyMUD Client v2
# Copyright(c) 2003-2009 Dale R. Anderson
#



#######
# The #alias Command
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

my $AliasHashPtr;

use pms::tmsg;

tmsg "#alias Command loading", -2;

#...


sub tcmd_alias
{
	tmsg "TC #alias called with @_";

	

}

sub tcmd_alias_add
{
	return unless argverify(\@_, 2, "tcmd takes 2 args..");

	#****do any validation of arg name here
	#

	tmsg "Now $_[0] is being aliased to '$_[1]'!", 1;
	
	AliasHashPtr{@_[0]} = @_[1];


}










#return true to please perl
;1;
