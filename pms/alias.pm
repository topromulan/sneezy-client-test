#
# TurtleShell v2
# Copyright(c) 2003-2009 Dale R. Anderson
#



#######
# a perl shell module to handle aliases
#
#


use pms::tmsg;
use pms::argverify;


my %AliasHash = ();

sub is_alias {
	return unless argverify(\@_, 1, "isalias() takes 1 args");


	#chop off the command word in case we were passed a whole line
	$_[0] =~ m/^([a-z1-9]*)/i;

	$question = $1;



	return 1 if defined($AliasHash{$question});

	return 0;


}

sub get_alias {

	return unless argverify(\@_, 1, "get_alias() takes 1 args");

	my $what = $_[0];

	unless(defined($AliasHash{$what}))
	{
		tmsg "get_alias(): No such alias '$what'", 0;
		return "";
	}

	return $AliasHash{$_[0]};
	

}

sub alias_add {

	return unless argverify(\@_, 2, "alias_add() takes 2 args");

	my $aname = $_[0];
	my $aval = $_[1];

	#check name is valid - alphanumeric, no spaces
	# return if not
	
	if ( $aname !~ m/^[a-z0-9]+$/i )
	{
		tmsg "alias_add(): invalid name for alias ($aname)", 3;
		return;
	}

	# leaving case intact for now.. maybe change later

	#log a message if we are overwriting an existing alias
	if ( defined($AliasHash{$aname}) ) 
	{
		tmsg "alias_add(): Overwriting alias $aname", 0;
	}

	#Insert the alias
	tmsg "alias_add(): Setting alias $aname to '$aval'", 1;
	$AliasHash{$aname} = $aval;


}

sub alias_clear {

	return unless argverify(\@_, 1, "alias_clear() takes 1 args");

	my $proposed_victim = $_[0];

	if( defined $AliasHash{$proposed_victim} )
	{
		tmsg "alias_clear(): Undefining alias '$proposedvictim'";
		# syntax? ****
		delete $AliasHash{$proposed_victim};
	}
	else
	{
		
		tmsg "alias_clear(): No alias '$proposedvictim' exists";

	}



}

#return true to please perl
;1;
