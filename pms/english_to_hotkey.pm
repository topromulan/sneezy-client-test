#
# Turtle Shell SneezyMUD Client v2
# Copyright(c) 2003-2009 Dale R. Anderson
#


# perl turtleshell english_to_hotkey sub
#
# translate english("0x33" or "esc[2d") to byte codes or ansi sequences
#

use strict;
use pms::tmsg;

sub english_to_hotkey {

        unless(defined($_[0])) {
                tmsg "#Internal error. english_to_hotkey() called with no argument!\n", 3;
                return;
        }

        my $str = $_[0];

	#strip the esc and return the rest with an actual escape
        if($str =~ s/^esc\[//i) {
                #ansi
                return "\x1b[$str";
        }

        $str =~ s/^0x//i; #remove optional 0x from bytecode

        if($str =~ m/[0-9A-F]+/i) {
                #its a hex bytecode
                return chr(hex($str));
        }

	tmsg "#Internal warning. english_to_hotkey() unable to translate $str", 0;
        return;
}





1;
