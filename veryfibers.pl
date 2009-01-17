#!/usr/bin/perl
#
# Turtle Shell SneezyMUD Client
# You reconnected with negative hit points, automatic death RE-occurring.
#
# 2003-2005 <3 Dale
#
# test

use strict;
my $turtlever = "0.9¹²³";

#SNUH
#AnotherSnuh

unless( -t STDIN) {
	print "TurtleShell version $turtlever\n";
	exit 0;
}

###############
#
# list of perl modules
#

## perl distro
#use IO; #for logfile flushing

use warnings;

## homemade
use pms::tmsg; 
#msg_test();

use pms::log;

use pms::lp;
use pms::kp;

use pms::bih;
#use pms::bih_explorer;

use pms::turtle_key;
use pms::hotkey_to_english;
use pms::english_to_hotkey;

use pms::turtle_processor;
use pms::turtle_commander;


my $tcmds = tcmd_scan();		#(returns the list of modules to load)

tmsg "Loading these fine Turtle Commands:\n$tcmds\n", 1;
eval $tcmds;

use pms::sneezy;

use pms::cmdlineargs;

use pms::quit;

tmsg 
	"\n\nTurtleShell version $turtlever firing up..\n" .
	"-- \n" .
	"\n" .
	1;
	

###############
#
# startup and commandline parse.
#

my %startuphash = (
	'server' => "sneezy.saw.net",
	'port' => "7900",
	'common' => "turtleshell.common",
	'squelch' => -4,
	'logon' => 0
);

#merge the commandline args
my $cmdhashref = cmdlineargs(\%startuphash,@ARGV);

#display the startup config
tmsg "--- Startup config ---";
foreach my $key (keys(%startuphash)) {
	tmsg "$key: $startuphash{$key}";
}
tmsg "----------------------";

#Set the squelch
tmsg "Startup set squelch to $startuphash{'squelch'}";
set_tmsg_squelch($startuphash{'squelch'});

#Set the server info
tmsg "Startup set server to $startuphash{'squelch'} and port to $startuphash{'port'}";
ssetserver($startuphash{server});
ssetport($startuphash{port});

#Set automatical logon info
tmsg "Startup set logon to $startuphash{'logon'}";
logon_setinfo($startuphash{logon});

###############
#
# main program body
#

tmsg "TurtleShell v. $turtlever";

tmsg "Setting ReadMode to 4..", -1;
ReadMode 4;

tmsg "Entering main program loop.", 3;


my $sneezy_in;
my $sneezy_out;
my $k;
my $hotcake;
my $short_stack_ref;

$| = 1;

sconnect();

while(1) {

	if ( scheck() ) {
		sget();


	} else {
		tmsg "Trouble connecting to SneezyMUD. Pause 2 seconds.", 3;
		sleep 2;
		tmsg "Trying to connect to SneezyMUD.", 3;
		sconnect();
	}


	kp($k) if defined($k=turtle_key()); 

	$short_stack_ref = kp_serve();
	
	foreach my $hotcake (@$short_stack_ref) {
		lp $hotcake;
	}

	$short_stack_ref = lp_serve();

	foreach $hotcake (@$short_stack_ref) {
		ssend($hotcake);
		tmsg "LP RETURNED $hotcake", -2
	}
}

print "Unreachable code reached......\n";

tmsg "Program terminating abnormally.. ", 3;
ReadMode 1;
exit(1);
