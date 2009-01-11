#!/usr/bin/perl
#
# Turtle Shell SneezyMUD Client
# You reconnected with negative hit points, automatic death RE-occurring.
#
# 2003-2005 <3 Dale
#
# test

use strict;
my $turtlever = "0.9���";

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
eval tcmd_scan();

use pms::sneezy;

use pms::cmdlineargs;

use pms::quit;

tmsg "TurtleShell version $turtlever firing up..",  0;

my %startuphash = (
	login => "sneezy.login",
	server => "sneezy.saw.net",
	port => "7900",
	common => "turtleshell.common",
	squelch => 0
);

#merge the commandline args
my $cmdhashref = cmdlineargs(\%startuphash,@ARGV);

#display the startup config
tmsg "--- Startup config ---";
foreach my $key (keys(%startuphash)) {
	tmsg "$key: $startuphash{$key}";
}
tmsg "----------------------";

if($startuphash{'squelch'} && $startuphash{'squelch'} =~ /^-{0,1}[0-9]*/) {
	tmsg "Startup set squelch to $startuphash{'squelch'}";
	set_tmsg_squelch($startuphash{'squelch'});
}

ssetserver($startuphash{server});
ssetport($startuphash{port});

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

while(1) {

	scheck();
	sget();
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