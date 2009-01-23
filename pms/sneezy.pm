#######
# a perl shell module to... access sneezymud
#
#
use pms::tmsg;

tmsg "sneezy init", -2;

use Net::Telnet;

use pms::argverify;
use pms::logon;

use warnings;
use strict;


#...

my $port = 7900;
my $server = "play.sneezymud.com";

my $stelnet = new Net::Telnet(Timeout => 10, ErrMode => 'return');

##  $sconnectionstate
#   -----------------
# 0 = Disconnected
# 1 = TCP connection
# 2 = Logged in

my $sconnectionstate = 0;	# default = not connected

##  $sautologonvar
#   -----------------
# 0 = auto logon enabled
# 1 = auto logon disabled

my $sautologonvar = 1; 		# default = disabled

sub sconnect {
	tmsg "sconnect: telnetting to $server $port", 0;
	$stelnet->open(Host=>$server, Port=>$port) or sleep 1;
	tmsg "sconnect: calling scheck()", 0;
	scheck();

	$sconnectionstate=0; #sget will verify the connection

	# **** this is fine
	#    veryfibers program loop handles repeated failure..
}

#Check the health of the SneezyMUD connection
sub scheck {

	if($stelnet->eof()) {
		tmsg "scheck: Telnet connection lost", -1;
		$sconnectionstate=0;


		return 0;	#GENERAL FAILURE

	
	}

	#we probably need to just do this once and not a million times
	# old version had some problems requiring repeated application
	#  of $| = 1.  Subject to future testing: 
	#   
	
	unless($| == 1) {
		
		tmsg "Setting \$| to 1", 5;  # monitor for this in testing
		$| = 1; # set command buffering instead of line buffering
	}

	return 1;
}

sub testsub {
	print $stelnet->get();
}

sub sget {
	return unless argverify(\@_, 0, "sget takes no arguments");

	if ($sconnectionstate == 0) {
		# we had a problem. Are we ready?
		#

		unless($stelnet->eof()) {
			
			$sconnectionstate=1;	# we're online

			tmsg "sget: Sneezy connected.", -1;

		} else {
			tmsg "sget: called without Sneezy connection", -1;
			return;
		}

	} 


	if(my $incoming = $stelnet->get(Timeout => 0)) {

		#Pass the block to the block input handler
		bih($incoming);


		# AUTO LOGIN

		# If the connection state is not 2 and auto logon is enabled
		#  then check if it is a logon packet and send the credentials
		#  if so.

		# Note: This may be a non-optimal place for this functionality
		

		unless ( ($sconnectionstate == 2) || $sautologonvar == 0 ) {

			if ( logon_packet($incoming) ) 
			{
				tmsg "Automatically logging on.", 2;
				#output the user account name and password
				#

				#
				# skipping ssend()..
				#
				# using stelnet directly in case ssend ever
				#  does any logging
				#

				$stelnet->print(logon_credentials());

				#
				# Assume it worked - we tried anyway and
				#  connection state 2 will avoid running
				#  this code over and over in sget()
	
				$sconnectionstate = 2;

			}


		}
	}
}

sub ssend {
	my $datum;
	if(defined($_[0])) {
		$datum = $_[0];
	} else {
		$datum = "";
	}
	$stelnet->print($datum);
}

sub ssetserver {
	return unless argverify(\@_, 1, "ssetserver takes 1 arg");
   	$server = $_[0];
	tmsg "ssetserver: \$server is now $server", 0;
}

sub ssetport {
	return unless argverify(\@_, 1, "ssetport takes 1 arg");
	$port = $_[0];
	tmsg "ssetserver: \$port is now $port", 0;
}

sub sautologon {
	# enable or disable autologon
	return unless argverify(\@_, 1, "sautologon takes 1 arg");

	tmsg "sneezy::sautologon called with @_";

	$sautologonvar=0;

	$sautologonvar=1 if $_[0]==1;
	


}

#return true to please perl
;1;
