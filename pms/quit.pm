#
# Turtle Shell SneezyMUD Client v2
# Copyright(c) 2003-2009 Dale R. Anderson
#


########
# perl turtleshell quit sub
#
#

use strict;
use Term::ReadKey;

use pms::tmsg;


sub quit {

	ReadMode 1;

	tmsg "Quitting now..", 3;

	exit(0);
}

1
